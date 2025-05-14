require("orion.config.options")
require("orion.config.lazy")
require("orion.config.autocmds")
require("orion.config.keymaps")

vim.g.colorscheme = vim.env.NVIM_COLORSCHEME or "default"
local ok, _ = pcall(vim.cmd.colorscheme, vim.g.colorscheme)

if not ok then
  vim.notify("Error loading colorscheme " .. vim.g.colorscheme, vim.log.levels.ERROR, { title = "Orion" })
  vim.g.colorscheme = "default"
  vim.cmd.colorscheme(vim.g.colorscheme)
end
