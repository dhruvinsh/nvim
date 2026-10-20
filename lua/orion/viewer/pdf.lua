-- pdf viewer: text extracted with `pdftotext -layout` (poppler-utils), one
-- header line per page.
local viewer = require("orion.viewer")

---@type viewer.Format
local M = { filetype = "pdf", section = "page", wo = { wrap = false, list = false } }

vim.api.nvim_set_hl(0, "PdfPage", { link = "@markup.heading", default = true })
vim.api.nvim_set_hl(0, "PdfNoText", { link = "@comment", default = true })

---@param path string
---@return viewer.Result
function M.render(path)
  if vim.fn.executable("pdftotext") == 0 then
    error("`pdftotext` not found, install poppler-utils")
  end
  local res = vim.system({ "pdftotext", "-layout", "-enc", "UTF-8", path, "-" }, { text = true }):wait()
  if res.code ~= 0 then
    error(res.stderr)
  end
  local pages = vim.split(res.stdout, "\f", { plain = true })
  if #pages > 1 and pages[#pages]:match("^%s*$") then
    table.remove(pages)
  end
  local lines, sections = {}, {}
  for i, page in ipairs(pages) do
    if i > 1 then
      lines[#lines + 1] = ""
    end
    sections[#sections + 1] = #lines
    lines[#lines + 1] = string.format("── Page %d/%d ──", i, #pages)
    page = page:gsub("%s+$", "")
    if page == "" then
      lines[#lines + 1] = "(no text on this page, likely a scanned image)"
    else
      for _, line in ipairs(vim.split(page, "\n", { plain = true })) do
        lines[#lines + 1] = (line:gsub("%s+$", ""))
      end
    end
  end
  return { lines = lines, sections = sections }
end

--- Image buffer per text buffer, used while showing page images
---@type table<integer, integer>
local image_bufs = {}

---@param text_buf integer
---@param page integer
local function show_text(text_buf, page)
  if not vim.api.nvim_buf_is_valid(text_buf) then
    return
  end
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(win, text_buf)
  -- restore the window options Snacks.image changed for the image view
  for name, value in pairs(vim.w[win].pdf_saved_wo or {}) do
    vim.wo[win][name] = value
  end
  vim.w[win].pdf_saved_wo = nil
  local row = viewer.state[text_buf].sections[page]
  if row then
    vim.api.nvim_win_set_cursor(win, { row + 1, 0 })
    vim.cmd("normal! zt")
  end
end

--- Show `page` of the pdf as an image (Snacks.image) in the current window.
---@param text_buf integer
---@param page integer
local function show_image(text_buf, page)
  local ok, terminal = pcall(require, "snacks.image.terminal")
  if not ok then
    vim.notify("snacks.nvim is required for page images", vim.log.levels.WARN, { title = "pdf" })
    return
  end
  terminal.detect(function()
    if not Snacks.image.supports_terminal() then
      vim.notify(
        "terminal doesn't support the kitty graphics protocol, see `:checkhealth snacks`",
        vim.log.levels.WARN,
        { title = "pdf" }
      )
      return
    end
    local total = #viewer.state[text_buf].sections
    page = math.max(1, math.min(page, total))
    local path = vim.api.nvim_buf_get_name(text_buf)
    local win = vim.api.nvim_get_current_win()

    local buf = image_bufs[text_buf]
    if not (buf and vim.api.nvim_buf_is_valid(buf)) then
      buf = vim.api.nvim_create_buf(false, true)
      image_bufs[text_buf] = buf
      vim.bo[buf].bufhidden = "wipe"
      vim.bo[buf].filetype = "image"
      vim.bo[buf].modifiable = false
      local function map(lhs, fn, desc)
        vim.keymap.set("n", lhs, function()
          fn(vim.b[buf].pdf_page)
        end, { buffer = buf, desc = desc })
      end
      map("]]", function(p)
        show_image(text_buf, p + 1)
      end, "Next page image")
      map("[[", function(p)
        show_image(text_buf, p - 1)
      end, "Previous page image")
      map("gp", function(p)
        show_text(text_buf, p)
      end, "Back to pdf text")
    end

    if vim.api.nvim_win_get_buf(win) ~= buf then
      local saved = {}
      for name in pairs(Snacks.image.config.wo or {}) do
        saved[name] = vim.wo[win][name]
      end
      vim.w[win].pdf_saved_wo = saved
      vim.api.nvim_win_set_buf(win, buf)
    end
    vim.b[buf].pdf_page = page
    Snacks.image.placement.clean(buf)
    Snacks.image.placement.new(buf, path .. "#page=" .. page, { conceal = true, auto_resize = true })
    vim.api.nvim_echo(
      { { string.format("Page %d/%d", page, total) }, { "  ]] next  [[ prev  gp text", "Comment" } },
      false,
      {}
    )
  end)
end

--- 1-based page number at the cursor
---@param buf integer
---@return integer
local function cursor_page(buf)
  local row, page = vim.api.nvim_win_get_cursor(0)[1] - 1, 1
  for i, start in ipairs(viewer.state[buf].sections) do
    if start <= row then
      page = i
    end
  end
  return page
end

---@param buf integer
---@param result viewer.Result
function M.attach(buf, result)
  for _, row in ipairs(result.sections) do
    vim.api.nvim_buf_set_extmark(buf, viewer.ns, row, 0, { line_hl_group = "PdfPage" })
    if (result.lines[row + 2] or ""):find("^%(no text on this page") then
      vim.api.nvim_buf_set_extmark(buf, viewer.ns, row + 1, 0, { line_hl_group = "PdfNoText" })
    end
  end
  vim.keymap.set("n", "gp", function()
    show_image(buf, cursor_page(buf))
  end, { buffer = buf, desc = "Show page as image" })
end

return M
