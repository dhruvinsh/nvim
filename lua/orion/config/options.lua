if vim.fn.executable("volta") then
  vim.g.node_host_prog = vim.fn.trim(vim.fn.system("volta which neovim-node-host", true))
end

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.termguicolors = true
vim.opt.cmdheight = 1
vim.opt.pumheight = 10

vim.opt.fillchars = { eob = " " } -- remove tidal sign on left side for non-text buffer
