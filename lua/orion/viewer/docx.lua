-- docx viewer: converts word/document.xml to markdown (headings, bold/italic,
-- links, lists, tables) and highlights it with the markdown treesitter parser.
local viewer = require("orion.viewer")

local attr, unescape = viewer.attr, viewer.unescape

---@type viewer.Format
local M = {
  filetype = "docx",
  section = "heading",
  wo = { wrap = true, linebreak = true, list = false, conceallevel = 2 },
}

M.max_cell_width = 40

-- highlight with the markdown parser; this also lets Snacks.image render the
-- `![image](...)` links inline
vim.treesitter.language.register("markdown", "docx")

---@class docx.Ctx
---@field links table<string, string> relationship id -> url
---@field images table<string, string> relationship id -> extracted image file
---@field headings table<string, integer> style id -> heading level
---@field lists table<string, table<integer, string>> numId -> ilvl -> numFmt
---@field counters table<string, table<integer, integer>> numId -> ilvl -> current number

--- Byte index of the `>` closing the element that starts at `s`, accounting for
--- nested elements with the same tag.
---@param xml string
---@param tag string
---@param s integer
---@return integer
local function element_end(xml, tag, s)
  local depth, pos = 0, s
  while true do
    local a, b, slash = xml:find("<(/?)" .. tag .. "[%s/>]", pos)
    if not a then
      return #xml
    end
    local gt = xml:find(">", b, true) or #xml
    if slash == "/" then
      depth = depth - 1
    elseif xml:sub(gt - 1, gt - 1) ~= "/" then
      depth = depth + 1
    end
    if depth <= 0 then
      return gt
    end
    pos = gt + 1
  end
end

--- Iterate over the outermost `tag` elements of `xml`.
---@param xml string
---@param tag string
---@return fun(): string?
local function elements(xml, tag)
  local pos = 1
  return function()
    local s = xml:find("<" .. tag .. "[%s/>]", pos)
    if not s then
      return nil
    end
    local e = element_end(xml, tag, s)
    pos = e + 1
    return xml:sub(s, e)
  end
end

---@param path string
---@return table<string, integer>
local function heading_styles(path)
  local out = {}
  for a, body in (viewer.extract(path, "word/styles.xml") or ""):gmatch("<w:style%s([^>]*)>(.-)</w:style>") do
    local name = (attr(body:match("<w:name%s([^>]*)>") or "", "w:val") or ""):lower()
    local outline = tonumber(attr(body:match("<w:outlineLvl%s([^>]*)>") or "", "w:val") or "")
    local level = tonumber(name:match("^heading (%d)$"))
      or (outline and outline < 9 and outline + 1)
      or (name == "title" and 1)
      or nil
    local id = attr(a, "w:styleId")
    if id and level then
      out[id] = math.min(level, 6)
    end
  end
  return out
end

---@param path string
---@return table<string, table<integer, string>>
local function list_formats(path)
  local xml = viewer.extract(path, "word/numbering.xml") or ""
  local abstract = {}
  for a, body in xml:gmatch("<w:abstractNum%s([^>]*)>(.-)</w:abstractNum>") do
    local fmts = {}
    for la, lbody in body:gmatch("<w:lvl%s([^>]*)>(.-)</w:lvl>") do
      fmts[tonumber(attr(la, "w:ilvl")) or 0] = attr(lbody:match("<w:numFmt%s([^>]*)>") or "", "w:val") or "bullet"
    end
    abstract[attr(a, "w:abstractNumId") or ""] = fmts
  end
  local out = {}
  for a, body in xml:gmatch("<w:num%s([^>]*)>(.-)</w:num>") do
    out[attr(a, "w:numId") or ""] = abstract[attr(body:match("<w:abstractNumId%s([^>]*)>") or "", "w:val") or ""]
  end
  return out
end

--- Extract word/media/* into a cache dir keyed by the file's path, size and mtime.
---@param path string
---@return string? dir
local function extract_media(path)
  local stat = vim.uv.fs_stat(path)
  if not stat or vim.fn.executable("unzip") == 0 then
    return nil
  end
  local key = vim.fn.sha256(table.concat({ path, stat.size, stat.mtime.sec }, ":")):sub(1, 16)
  local dir = vim.fn.stdpath("cache") .. "/viewer/" .. key
  if vim.fn.isdirectory(dir .. "/word/media") == 0 then
    -- unzip -d only creates the last path component
    vim.fn.mkdir(dir, "p")
    vim.system({ "unzip", "-o", "-qq", path, "word/media/*", "-d", dir }):wait()
  end
  return dir
end

---@param path string
---@return table<string, string> links, table<string, string> images
local function relationships(path)
  local links, media = {}, {}
  for a in (viewer.extract(path, "word/_rels/document.xml.rels") or ""):gmatch("<Relationship%s([^>]*)>") do
    local id, target, type = attr(a, "Id"), attr(a, "Target"), attr(a, "Type") or ""
    if id and target then
      target = unescape(target)
      if type:find("/hyperlink$") then
        links[id] = target
      elseif type:find("/image$") and attr(a, "TargetMode") ~= "External" then
        media[id] = target:sub(1, 1) == "/" and target:sub(2) or "word/" .. target
      end
    end
  end
  local images = {}
  local dir = next(media) and extract_media(path)
  if dir then
    for id, member in pairs(media) do
      images[id] = dir .. "/" .. member
    end
  end
  return links, images
end

---@param file? string extracted image
---@param alt? string
---@return string
local function image(file, alt)
  alt = (alt or ""):gsub("[%[%]\n]", " ")
  alt = vim.trim(alt) ~= "" and vim.trim(alt) or "image"
  if not file or vim.fn.filereadable(file) == 0 then
    return "[" .. alt .. "] "
  end
  return "![" .. alt .. "](" .. file:gsub("[ ()]", { [" "] = "%20", ["("] = "%28", [")"] = "%29" }) .. ") "
end

--- `<w:b/>` turns bold on unless w:val is 0/false.
---@param attrs string
---@return boolean
local function toggle(attrs)
  local val = attr(attrs, "w:val")
  return val ~= "0" and val ~= "false"
end

---@param text string
---@param bold boolean
---@param italic boolean
---@return string
local function emphasize(text, bold, italic)
  local lead, body, trail = text:match("^(%s*)(.-)(%s*)$")
  if body == "" or not (bold or italic) then
    return text
  end
  local mark = (bold and "**" or "") .. (italic and "*" or "")
  return lead .. mark .. body .. mark .. trail
end

---@class docx.Paragraph
---@field text string may contain "\n" from line breaks
---@field style? string
---@field num_id? string
---@field ilvl integer
---@field outline? integer

---@param xml string a <w:p> element
---@param ctx docx.Ctx
---@return docx.Paragraph
local function parse_paragraph(xml, ctx)
  local p = { ilvl = 0 } ---@type docx.Paragraph
  local runs = {} ---@type { text: string, bold: boolean, italic: boolean, link?: string }[]
  local run, link, in_ppr, alt
  for close, tag, attrs, text in xml:gmatch("<(/?)([%w:]+)([^>]*)>([^<]*)") do
    local open, self_closing = close == "", attrs:sub(-1) == "/"
    if tag == "w:pPr" then
      in_ppr = open and not self_closing
    elseif in_ppr then
      if tag == "w:pStyle" then
        p.style = attr(attrs, "w:val")
      elseif tag == "w:numId" then
        p.num_id = attr(attrs, "w:val")
      elseif tag == "w:ilvl" then
        p.ilvl = tonumber(attr(attrs, "w:val")) or 0
      elseif tag == "w:outlineLvl" then
        p.outline = tonumber(attr(attrs, "w:val"))
      end
    elseif tag == "w:hyperlink" then
      link = open and not self_closing and (ctx.links[attr(attrs, "r:id") or ""] or nil) or nil
    elseif tag == "w:r" then
      run = nil
      if open and not self_closing then
        run = { text = "", bold = false, italic = false, link = link }
        runs[#runs + 1] = run
      end
    elseif run and open then
      if tag == "w:b" then
        run.bold = toggle(attrs)
      elseif tag == "w:i" then
        run.italic = toggle(attrs)
      elseif tag == "w:t" and not self_closing then
        run.text = run.text .. unescape(text)
      elseif tag == "w:tab" or tag == "w:ptab" then
        run.text = run.text .. "  "
      elseif tag == "w:br" or tag == "w:cr" then
        run.text = run.text .. "\n"
      elseif tag == "w:noBreakHyphen" then
        run.text = run.text .. "-"
      elseif tag == "wp:docPr" then
        alt = attr(attrs, "descr") or attr(attrs, "name")
      elseif tag == "a:blip" or tag == "v:imagedata" then
        local id = attr(attrs, "r:embed") or attr(attrs, "r:id") or ""
        run.text = run.text .. image(ctx.images[id], alt and unescape(alt))
        alt = nil
      elseif tag == "c:chart" then
        run.text = run.text .. "[chart] "
      elseif tag == "w:footnoteReference" or tag == "w:endnoteReference" then
        run.text = run.text .. "[^" .. (attr(attrs, "w:id") or "?") .. "]"
      end
    end
  end

  -- Word splits text into many runs with identical formatting; merge them so
  -- emphasis markers aren't repeated.
  local merged = {}
  for _, r in ipairs(runs) do
    local last = merged[#merged]
    if last and last.bold == r.bold and last.italic == r.italic and last.link == r.link then
      last.text = last.text .. r.text
    elseif r.text ~= "" then
      merged[#merged + 1] = { text = r.text, bold = r.bold, italic = r.italic, link = r.link }
    end
  end

  local parts, i = {}, 1
  while i <= #merged do
    local r = merged[i]
    if r.link then
      local label = {}
      while merged[i] and merged[i].link == r.link do
        label[#label + 1] = emphasize(merged[i].text, merged[i].bold, merged[i].italic)
        i = i + 1
      end
      parts[#parts + 1] = "[" .. table.concat(label) .. "](" .. r.link:gsub(" ", "%%20") .. ")"
    else
      parts[#parts + 1] = emphasize(r.text, r.bold, r.italic)
      i = i + 1
    end
  end
  p.text = table.concat(parts)
  return p
end

---@class docx.Block
---@field kind "heading"|"list"|"paragraph"|"table"
---@field lines string[]

---@param xml string a <w:p> element
---@param ctx docx.Ctx
---@return docx.Block?
local function paragraph_block(xml, ctx)
  local p = parse_paragraph(xml, ctx)
  if p.text:match("^%s*$") then
    return nil
  end
  local level = ctx.headings[p.style or ""] or (p.outline and p.outline < 9 and p.outline + 1)
  if level then
    return { kind = "heading", lines = { string.rep("#", math.min(level, 6)) .. " " .. p.text:gsub("%s*\n%s*", " ") } }
  end

  local fmts = p.num_id and ctx.lists[p.num_id]
  if fmts then
    local marker = "-"
    local fmt = fmts[p.ilvl] or "bullet"
    if fmt ~= "bullet" and fmt ~= "none" then
      local counters = ctx.counters[p.num_id] or {}
      ctx.counters[p.num_id] = counters
      counters[p.ilvl] = (counters[p.ilvl] or 0) + 1
      for lvl in pairs(counters) do
        if lvl > p.ilvl then
          counters[lvl] = nil
        end
      end
      marker = counters[p.ilvl] .. "."
    end
    local indent = string.rep("    ", p.ilvl)
    local text = p.text:gsub("\n", "\n" .. indent .. string.rep(" ", #marker + 1))
    return { kind = "list", lines = vim.split(indent .. marker .. " " .. text, "\n", { plain = true }) }
  end

  -- escape text that markdown would otherwise read as a heading/list/quote
  -- (the backslash is concealed by the markdown highlight queries)
  local text = p.text:gsub("^(%s*)([#>])", "%1\\%2"):gsub("^(%s*)([-+*] )", "%1\\%2"):gsub("^(%s*%d+)([.)] )", "%1\\%2")
  return { kind = "paragraph", lines = vim.split(text, "\n", { plain = true }) }
end

---@param xml string a <w:tbl> element
---@param ctx docx.Ctx
---@return docx.Block?
local function table_block(xml, ctx)
  local rows, ncols = {}, 0
  for tr in elements(xml, "w:tr") do
    local row = {}
    for tc in elements(tr, "w:tc") do
      local texts = {}
      for p in elements(tc, "w:p") do
        local text = parse_paragraph(p, ctx).text
        if not text:match("^%s*$") then
          texts[#texts + 1] = vim.trim(text)
        end
      end
      -- images are reduced to their alt text so the table stays aligned
      row[#row + 1] = table.concat(texts, " "):gsub("!(%b[])%b()", "%1"):gsub("%s*\n%s*", " "):gsub("|", "\\|")
      for _ = 2, tonumber(attr(tc:match("<w:gridSpan%s([^>]*)>") or "", "w:val") or "") or 1 do
        row[#row + 1] = ""
      end
    end
    rows[#rows + 1] = row
    ncols = math.max(ncols, #row)
  end
  if #rows == 0 or ncols == 0 then
    return nil
  end

  local widths = {}
  for c = 1, ncols do
    widths[c] = 3
    for _, row in ipairs(rows) do
      widths[c] = math.min(M.max_cell_width, math.max(widths[c], vim.api.nvim_strwidth(row[c] or "")))
    end
  end
  local function line(cells)
    local out = {}
    for c = 1, ncols do
      local cell = cells[c] or ""
      out[c] = cell .. string.rep(" ", widths[c] - vim.api.nvim_strwidth(cell))
    end
    return "| " .. table.concat(out, " | ") .. " |"
  end
  local lines = { line(rows[1]) }
  local sep = {}
  for c = 1, ncols do
    sep[c] = string.rep("-", widths[c])
  end
  lines[2] = line(sep)
  for r = 2, #rows do
    lines[#lines + 1] = line(rows[r])
  end
  return { kind = "table", lines = lines }
end

---@param path string
---@return viewer.Result
function M.render(path)
  local xml = viewer.extract(path, "word/document.xml")
  local body = xml and xml:match("<w:body>(.*)</w:body>")
  if not body then
    error("not a valid docx file (no word/document.xml body)")
  end
  -- drawings carry a VML fallback copy of their text boxes
  body = body:gsub("<mc:Fallback>.-</mc:Fallback>", "")

  local links, images = relationships(path)
  ---@type docx.Ctx
  local ctx =
    { links = links, images = images, headings = heading_styles(path), lists = list_formats(path), counters = {} }

  local blocks = {} ---@type docx.Block[]
  local pos = 1
  while true do
    local p = body:find("<w:p[%s/>]", pos)
    local t = body:find("<w:tbl[%s>]", pos)
    if not p and not t then
      break
    end
    local block
    if t and (not p or t < p) then
      local e = element_end(body, "w:tbl", t)
      block, pos = table_block(body:sub(t, e), ctx), e + 1
    else
      local e = element_end(body, "w:p", p)
      block, pos = paragraph_block(body:sub(p, e), ctx), e + 1
    end
    blocks[#blocks + 1] = block
  end

  local lines, sections = {}, {}
  for i, block in ipairs(blocks) do
    -- consecutive list items form one tight list; everything else gets a blank line
    if i > 1 and not (block.kind == "list" and blocks[i - 1].kind == "list") then
      lines[#lines + 1] = ""
    end
    if block.kind == "heading" then
      sections[#sections + 1] = #lines
    end
    vim.list_extend(lines, block.lines)
  end
  if #lines == 0 then
    lines = { "(empty document)" }
  end
  return { lines = lines, sections = sections }
end

---@param buf integer
function M.attach(buf)
  pcall(vim.treesitter.start, buf, "markdown")
  -- Snacks only sets up images on BufReadPre / image files, neither of which
  -- fires for a docx opened through BufReadCmd. Both calls are idempotent.
  local snacks = rawget(_G, "Snacks")
  if snacks and snacks.config.image and snacks.config.image.enabled then
    snacks.image.setup()
    snacks.image.doc.attach(buf)
  end
end

return M
