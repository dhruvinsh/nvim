local M = {}

M.augroup = function(name)
  return vim.api.nvim_create_augroup("orion_" .. name, { clear = true })
end

M.os_name = vim.loop.os_uname().sysname

---@return boolean
M.is_mac = function()
  return M.os_name == "Darwin" and true or false
end

---@param bufnr number
M.is_big_buffer = function(bufnr)
  local max_filesize = 100 * 1024 -- 100 KB
  local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
  if ok and stats and stats.size > max_filesize then
    return true
  else
    return false
  end
end

M.insert = function(tbl, ...)
  for _, value in ipairs({ ... }) do
    table.insert(tbl, value)
  end
end

M.persistbuffer = function()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.fn.setbufvar(bufnr, "bufpersist", 1)
end

return M
