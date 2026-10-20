-- Read-only viewers for binary documents (xlsx, docx, pdf). Each format module
-- in lua/orion/viewer/ renders the file to text; this module owns the buffer.
local M = {}

M.ns = vim.api.nvim_create_namespace("viewer")

---@class viewer.Result
---@field lines string[]
---@field sections integer[] 0-based lines that `]]` / `[[` jump between
---@field error? boolean
---@field cell_meta? table<integer, xlsx.LineMeta> xlsx only

---@class viewer.Format
---@field filetype string
---@field section string name of a section, used in keymap descriptions
---@field wo table<string, any> window-local options
---@field render fun(path: string): viewer.Result
---@field attach? fun(buf: integer, result: viewer.Result)

--- Rendered result per buffer
---@type table<integer, viewer.Result>
M.state = {}

--- Extract one member of a zip archive (xlsx/docx are zip files).
---@param path string
---@param member string
---@return string?
function M.extract(path, member)
  local cmd
  if vim.fn.executable("unzip") == 1 then
    cmd = { "unzip", "-p", path, member }
  elseif vim.fn.executable("tar") == 1 then
    cmd = { "tar", "-xOf", path, member }
  else
    error("neither `unzip` nor `tar` is available")
  end
  local res = vim.system(cmd, { text = true }):wait()
  if res.code ~= 0 or res.stdout == "" then
    return nil
  end
  return res.stdout
end

local entities = { amp = "&", lt = "<", gt = ">", quot = '"', apos = "'" }

---@param s string
---@return string
function M.unescape(s)
  return (
    s:gsub("&(#?)(x?)(%w+);", function(hash, hex, code)
      if hash == "" then
        return entities[code]
      end
      local n = tonumber(code, hex == "x" and 16 or 10)
      return n and vim.fn.nr2char(n) or nil
    end)
  )
end

---@param s string attribute list of a tag
---@param name string
---@return string?
function M.attr(s, name)
  local _, value = s:match("%f[%w:]" .. name .. "%s*=%s*([\"'])(.-)%1")
  return value
end

---@param dir 1|-1
local function jump(dir)
  local result = M.state[vim.api.nvim_get_current_buf()]
  local sections = result and result.sections or {}
  local cur = vim.api.nvim_win_get_cursor(0)[1] - 1
  for i = dir == 1 and 1 or #sections, dir == 1 and #sections or 1, dir do
    if (dir == 1 and sections[i] > cur) or (dir == -1 and sections[i] < cur) then
      vim.api.nvim_win_set_cursor(0, { sections[i] + 1, 0 })
      vim.cmd("normal! zt")
      return
    end
  end
end

---@param buf integer
---@param file string
---@param fmt viewer.Format
function M.read(buf, file, fmt)
  local path = vim.fn.fnamemodify(file, ":p")
  local result ---@type viewer.Result
  if not vim.uv.fs_stat(path) then
    result = { lines = { "file not found: " .. path }, sections = {}, error = true }
  else
    local ok, res = pcall(fmt.render, path)
    if ok then
      result = res
    else
      local msg = tostring(res):gsub("^[^\n]-%.lua:%d+: ", "")
      local lines = vim.split(msg, "\n", { trimempty = true })
      table.insert(lines, 1, "failed to read " .. path)
      result = { lines = lines, sections = {}, error = true }
    end
  end
  M.state[buf] = result

  local bo = vim.bo[buf]
  bo.modifiable = true
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, result.lines)
  -- nowrite guards against `:w!` overwriting the document with rendered text
  bo.buftype = "nowrite"
  bo.swapfile = false
  bo.modified = false
  bo.modifiable = false
  bo.readonly = true
  bo.filetype = fmt.filetype

  vim.api.nvim_buf_clear_namespace(buf, M.ns, 0, -1)
  if result.error then
    vim.api.nvim_buf_set_extmark(buf, M.ns, 0, 0, { end_row = #result.lines, hl_group = "DiagnosticError" })
  elseif fmt.attach then
    fmt.attach(buf, result)
  end

  vim.keymap.set("n", "]]", function()
    jump(1)
  end, { buffer = buf, desc = "Next " .. fmt.section })
  vim.keymap.set("n", "[[", function()
    jump(-1)
  end, { buffer = buf, desc = "Previous " .. fmt.section })

  local function window_opts()
    for name, value in pairs(fmt.wo) do
      vim.wo[0][0][name] = value
    end
  end
  if vim.api.nvim_get_current_buf() == buf then
    window_opts()
  end
  if not vim.b[buf].viewer_loaded then
    vim.b[buf].viewer_loaded = true
    vim.api.nvim_create_autocmd("BufWinEnter", { buffer = buf, callback = window_opts })
    vim.api.nvim_create_autocmd("BufWipeout", {
      buffer = buf,
      callback = function()
        M.state[buf] = nil
      end,
    })
  end
end

return M
