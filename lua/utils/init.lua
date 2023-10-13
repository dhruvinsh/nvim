local M = {}

M.max_filesize = 512 * 1024 -- big file size threshold 0.5 MB
M.os_name = vim.loop.os_uname().sysname
M.root_patterns = { ".git", "Makefile", "pyproject.toml", ".projectile", ".neoconf.json", ".editorconfig" }

M.is_mac = M.os_name == "Darwin"

---@param name string
---@return integer
M.augroup = function(name)
  return vim.api.nvim_create_augroup("orion_" .. name, { clear = true })
end

---@param bufnr number
---@return boolean
M.is_big_buffer = function(bufnr)
  -- here fs_stat needs file path to identify file size.
  local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
  if ok and stats and stats.size > M.max_filesize then
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
