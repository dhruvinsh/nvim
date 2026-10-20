-- xlsx viewer: renders every sheet as an aligned table, cells colored by type.
local viewer = require("orion.viewer")

local attr = viewer.attr

---@type viewer.Format
local M = { filetype = "xlsx", section = "sheet", wo = { wrap = false, list = false } }

M.max_col_width = 50

local ns = vim.api.nvim_create_namespace("viewer.xlsx")

-- Colors link to treesitter capture groups so they follow the colorscheme.
-- Override any Xlsx* group to customize.
local hl_links = {
  XlsxTitle = "@markup.heading",
  XlsxColumn = "@label",
  XlsxRowNr = "LineNr",
  XlsxSeparator = "@punctuation.delimiter",
  XlsxEmpty = "@comment",
  XlsxString = "@string",
  XlsxNumber = "@number",
  XlsxFloat = "@number.float",
  XlsxDate = "@string.special",
  XlsxBoolean = "@boolean",
  XlsxError = "@comment.error",
}

local function set_hl()
  for group, link in pairs(hl_links) do
    vim.api.nvim_set_hl(0, group, { link = link, default = true })
  end
end
set_hl()
vim.api.nvim_create_autocmd("ColorScheme", { group = require("util").augroup("viewer_xlsx_hl"), callback = set_hl })

---@alias xlsx.Kind "string"|"number"|"float"|"date"|"boolean"|"error"

---@type table<xlsx.Kind, string>
local kind_hl = {
  string = "XlsxString",
  number = "XlsxNumber",
  float = "XlsxFloat",
  date = "XlsxDate",
  boolean = "XlsxBoolean",
  error = "XlsxError",
}

local SEP = "│"

---@param s string
---@return string
local function unescape(s)
  -- Excel escapes control characters as _xHHHH_
  return (viewer.unescape(s):gsub("_x(%x%x%x%x)_", function(code)
    return vim.fn.nr2char(tonumber(code, 16))
  end))
end

--- Concatenate all <t> runs (rich text splits one string into several runs).
---@param xml string
---@return string
local function text_runs(xml)
  xml = xml:gsub("<rPh.-</rPh>", ""):gsub("<t%s*/>", "")
  local parts = {}
  for t in xml:gmatch("<t[^>]*>(.-)</t>") do
    parts[#parts + 1] = t
  end
  return unescape(table.concat(parts))
end

---@param path string
---@return string[]
local function shared_strings(path)
  local xml = viewer.extract(path, "xl/sharedStrings.xml") or ""
  local out = {}
  for si in xml:gsub("<si%s*/>", "<si></si>"):gmatch("<si[^>]*>(.-)</si>") do
    out[#out + 1] = text_runs(si)
  end
  return out
end

local builtin_date_fmts = { [14] = true, [15] = true, [16] = true, [17] = true, [18] = true, [19] = true, [20] = true }
for id = 21, 22 do
  builtin_date_fmts[id] = true
end
for id = 45, 47 do
  builtin_date_fmts[id] = true
end

---@param code string
---@return boolean
local function is_date_code(code)
  code = code:gsub('"[^"]*"', ""):gsub("%[[^%]]*%]", ""):gsub("[_*\\].", ""):lower()
  return code:find("[dmyhs]") ~= nil
end

--- Map of cell style index (0-based) -> true for styles with a date/time format.
---@param path string
---@return table<integer, boolean>
local function date_styles(path)
  local xml = viewer.extract(path, "xl/styles.xml") or ""
  local custom = {}
  for a in xml:gmatch("<numFmt%s+([^>]*)>") do
    local id, code = tonumber(attr(a, "numFmtId")), attr(a, "formatCode")
    if id and code then
      custom[id] = is_date_code(unescape(code))
    end
  end
  local out, i = {}, 0
  for a in (xml:match("<cellXfs[^>]*>(.-)</cellXfs>") or ""):gmatch("<xf%s+([^>]*)>") do
    local id = tonumber(attr(a, "numFmtId") or "")
    if id and (builtin_date_fmts[id] or custom[id]) then
      out[i] = true
    end
    i = i + 1
  end
  return out
end

---@param serial number days since 1899-12-30
---@return string
local function format_date(serial)
  local days = math.floor(serial)
  local secs = math.floor((serial - days) * 86400 + 0.5)
  local ts = (days - 25569) * 86400 + secs
  if days == 0 then
    return os.date("!%H:%M:%S", ts) --[[@as string]]
  elseif secs == 0 then
    return os.date("!%Y-%m-%d", ts) --[[@as string]]
  end
  return os.date("!%Y-%m-%d %H:%M:%S", ts) --[[@as string]]
end

---@param letters string
---@return integer
local function col_index(letters)
  local n = 0
  for c in letters:gmatch("%u") do
    n = n * 26 + c:byte() - 64
  end
  return n
end

---@param n integer
---@return string
local function col_name(n)
  local s = ""
  while n > 0 do
    s = string.char(65 + (n - 1) % 26) .. s
    n = math.floor((n - 1) / 26)
  end
  return s
end

---@param a string cell attributes
---@param body string cell contents
---@param strings string[]
---@param dates table<integer, boolean>
---@return string?, xlsx.Kind
local function cell_value(a, body, strings, dates)
  local t = attr(a, "t")
  if t == "inlineStr" then
    return text_runs(body), "string"
  end
  local v = body:match("<v[^>]*>(.-)</v>")
  if not v then
    return nil, "string"
  elseif t == "s" then
    return strings[(tonumber(v) or -1) + 1], "string"
  elseif t == "b" then
    return v == "1" and "TRUE" or "FALSE", "boolean"
  elseif t == "e" then
    return unescape(v), "error"
  elseif t == "d" then
    return unescape(v), "date"
  elseif t == "str" then
    return unescape(v), "string"
  end
  local n = tonumber(v)
  if not n then
    return unescape(v), "string"
  elseif dates[tonumber(attr(a, "s") or "")] then
    return format_date(n), "date"
  end
  local s = string.format("%.15g", n)
  return s, s:find("[.e]") and "float" or "number"
end

---@param xml string
---@param strings string[]
---@param dates table<integer, boolean>
---@return table<integer, table<integer, string>> rows, table<integer, table<integer, xlsx.Kind>> kinds, integer max_row, integer max_col
local function parse_sheet(xml, strings, dates)
  local data = (xml:match("<sheetData[^>]*>(.*)</sheetData>") or "")
    :gsub("<row%s[^>]-/>", "")
    :gsub("<c>", "<c >")
    :gsub("<c(%s[^>]-)/>", "<c%1></c>")
  local rows, kinds, max_row, max_col = {}, {}, 0, 0
  local r = 0
  for ra, rbody in data:gmatch("<row%s*([^>]*)>(.-)</row>") do
    r = tonumber(attr(ra, "r") or "") or r + 1
    local c = 0
    for ca, cbody in rbody:gmatch("<c%s+([^>]*)>(.-)</c>") do
      local ref = attr(ca, "r")
      c = ref and col_index(ref:match("^%a+"):upper()) or c + 1
      local value, kind = cell_value(ca, cbody, strings, dates)
      if value and value ~= "" then
        rows[r], kinds[r] = rows[r] or {}, kinds[r] or {}
        -- the separator is replaced so highlighting can split rows on it
        rows[r][c] = value:gsub("\r?\n", " ↵ "):gsub("\t", " "):gsub(SEP, "|")
        kinds[r][c] = kind
        max_row, max_col = math.max(max_row, r), math.max(max_col, c)
      end
    end
  end
  return rows, kinds, max_row, max_col
end

---@param path string
---@return { name: string, hidden: boolean, member: string }[]
local function list_sheets(path)
  local workbook = viewer.extract(path, "xl/workbook.xml")
  if not workbook then
    error("not a valid xlsx file (no xl/workbook.xml)")
  end
  local targets = {}
  for a in (viewer.extract(path, "xl/_rels/workbook.xml.rels") or ""):gmatch("<Relationship%s+([^>]*)>") do
    local id, target = attr(a, "Id"), attr(a, "Target")
    if id and target then
      targets[id] = target:sub(1, 1) == "/" and target:sub(2) or "xl/" .. target
    end
  end
  local sheets = {}
  for a in workbook:gmatch("<sheet%s+([^>]*)>") do
    local target = targets[attr(a, "r:id") or ""]
    if target then
      sheets[#sheets + 1] = {
        name = unescape(attr(a, "name") or "?"),
        hidden = (attr(a, "state") or "visible") ~= "visible",
        member = target,
      }
    end
  end
  return sheets
end

---@param s string
---@param width integer
---@return string
local function fit(s, width)
  local w = vim.api.nvim_strwidth(s)
  if w > width then
    local n = vim.fn.strchars(s)
    repeat
      n = n - 1
      s = vim.fn.strcharpart(s, 0, n)
    until vim.api.nvim_strwidth(s) <= width - 1
    s, w = s .. "…", vim.api.nvim_strwidth(s) + 1
  end
  return s .. string.rep(" ", width - w)
end

---@param rows table<integer, table<integer, string>>
---@param max_row integer
---@param max_col integer
---@return string[]
local function render_table(rows, max_row, max_col)
  local widths = {}
  for c = 1, max_col do
    widths[c] = #col_name(c)
  end
  for _, row in pairs(rows) do
    for c, v in pairs(row) do
      widths[c] = math.min(M.max_col_width, math.max(widths[c], vim.api.nvim_strwidth(v)))
    end
  end
  local gutter = #tostring(max_row)
  local function line(label, cells)
    local parts = { string.rep(" ", gutter - vim.api.nvim_strwidth(label)) .. label }
    for c = 1, max_col do
      parts[#parts + 1] = fit(cells[c] or "", widths[c])
    end
    return (table.concat(parts, " " .. SEP .. " "):gsub("%s+$", ""))
  end
  local header = {}
  for c = 1, max_col do
    header[c] = col_name(c)
  end
  local lines = { line("", header) }
  for r = 1, max_row do
    lines[#lines + 1] = line(tostring(r), rows[r] or {})
  end
  return lines
end

---@alias xlsx.LineMeta "title"|"empty"|"columns"|table<integer, xlsx.Kind>

---@param path string
---@return viewer.Result
function M.render(path)
  local strings, dates = shared_strings(path), date_styles(path)
  local sheets = list_sheets(path)
  local lines, headers, meta = {}, {}, {}
  for i, sheet in ipairs(sheets) do
    if i > 1 then
      lines[#lines + 1] = ""
    end
    local rows, kinds, max_row, max_col = parse_sheet(viewer.extract(path, sheet.member) or "", strings, dates)
    headers[#headers + 1] = #lines
    meta[#lines] = "title"
    lines[#lines + 1] = string.format(
      "%s  [%d/%d%s, %d×%d]",
      sheet.name,
      i,
      #sheets,
      sheet.hidden and ", hidden" or "",
      max_row,
      max_col
    )
    if max_row == 0 then
      meta[#lines] = "empty"
      lines[#lines + 1] = "(empty)"
    else
      meta[#lines] = "columns"
      for r = 1, max_row do
        meta[#lines + r] = kinds[r] or {}
      end
      vim.list_extend(lines, render_table(rows, max_row, max_col))
    end
  end
  return { lines = lines, sections = headers, cell_meta = meta }
end

---@param buf integer
---@param row integer 0-based
---@param col integer 0-based start
---@param end_col integer 0-based exclusive end
---@param group string
local function hl(buf, row, col, end_col, group)
  vim.api.nvim_buf_set_extmark(buf, ns, row, col, { end_col = end_col, hl_group = group, ephemeral = true })
end

---@param buf integer
---@param row integer 0-based
local function highlight_line(buf, row)
  local m = viewer.state[buf].cell_meta[row]
  if not m then
    return
  end
  local line = vim.api.nvim_buf_get_lines(buf, row, row + 1, false)[1] or ""
  if m == "title" or m == "empty" then
    hl(buf, row, 0, #line, m == "title" and "XlsxTitle" or "XlsxEmpty")
    return
  end
  -- table row: gutter (column 0) then one segment per cell, split on SEP
  local c, start = 0, 1
  while true do
    local s, e = line:find(SEP, start, true)
    local group
    if m == "columns" then
      group = c > 0 and "XlsxColumn" or nil
    else
      group = c == 0 and "XlsxRowNr" or kind_hl[m[c]]
    end
    if group then
      local a, b = line:sub(start, (s or #line + 1) - 1):match("^%s*()%S.-()%s*$")
      if a then
        hl(buf, row, start + a - 2, start + b - 2, group)
      end
    end
    if not s then
      return
    end
    hl(buf, row, s - 1, e, "XlsxSeparator")
    start, c = e + 1, c + 1
  end
end

vim.api.nvim_set_decoration_provider(ns, {
  on_win = function(_, _, buf)
    local result = viewer.state[buf]
    return result ~= nil and result.cell_meta ~= nil
  end,
  on_line = function(_, _, buf, row)
    highlight_line(buf, row)
  end,
})

return M
