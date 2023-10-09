if vim.fn.executable("volta") then
  vim.g.node_host_prog = vim.fn.trim(vim.fn.system("volta which neovim-node-host", true))
end

-- editor
vim.opt.autoindent = true
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.confirm = true
vim.opt.expandtab = true
vim.opt.formatoptions = "jcroqlnt" -- see :help fo-table
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.spelllang = { "en" }
vim.opt.timeoutlen = 200
vim.opt.undofile = true
vim.opt.undolevels = 10000
-- ui
vim.opt.cmdheight = 1
vim.opt.cursorline = true
vim.opt.foldlevel = 99
vim.opt.foldmethod = "indent"
vim.opt.laststatus = 3
vim.opt.pumblend = 10
vim.opt.pumheight = 10
vim.opt.scrolloff = 4
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen"
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  -- fold = "⸱",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
