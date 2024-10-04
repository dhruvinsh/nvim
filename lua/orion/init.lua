require("orion.config.options")
require("orion.config.keymaps")
require("orion.config.autocmds")
require("orion.config.lazy")

vim.g.colorscheme = vim.env.NVIM_COLORSCHEME or "kanagawa"
vim.cmd.colorscheme(vim.g.colorscheme)
