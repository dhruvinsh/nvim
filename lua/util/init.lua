local M = {}

M.no_indent_filetypes = {
  "Trouble",
  "alpha",
  "dashboard",
  "fzf",
  "help",
  "lazy",
  "mason",
  "neo-tree",
  "notify",
  "toggleterm",
  "trouble",
}

M.max_filesize = 512 * 1024 -- big file size threshold 0.5 MB
M.os_name = vim.uv.os_uname().sysname
M.root_patterns = { ".editorconfig", ".git", ".neoconf.json", ".projectile", "Makefile", "pyproject.toml" }

M.is_mac = M.os_name == "Darwin"
M.is_win = M.os_name == "Windows_NT"

---@param name string
---@param clear? boolean default set to true
---@return integer
M.augroup = function(name, clear)
  if clear == nil then
    clear = true
  end
  return vim.api.nvim_create_augroup("orion_" .. name, { clear = clear })
end

---@param bufnr number
---@return boolean
M.is_big_buffer = function(bufnr)
  local ok, stat = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(bufnr))
  if not ok then
    vim.notify("Not able to determine file size, declaring big file", vim.log.levels.ERROR)
    return true
  end

  if stat and stat.size > M.max_filesize then
    -- vim.notify("Big file size detected", vim.log.levels.ERROR)
    return true
  end

  return false
end

---@param tbl table
---@param ... string | integer
---@return nil
M.tbl_append = function(tbl, ...)
  for _, value in ipairs({ ... }) do
    table.insert(tbl, value)
  end
end

M.persistbuffer = function()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.fn.setbufvar(bufnr, "bufpersist", 1)
end

return M
