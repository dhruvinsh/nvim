local M = {}

-- Utility functions for compe and luasnip
M.t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

M.check_back_space = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

function M.error(msg, name)
  vim.notify(msg, vim.log.levels.ERROR, { title = name })
end

return M
