if vim.fn.executable("volta") then
  vim.g.node_host_prog = vim.fn.trim(vim.fn.system("volta which neovim-node-host", true))
end

-- editor
vim.opt.autoindent = true
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = "menuone,noselect"
vim.opt.confirm = true
vim.opt.expandtab = true
vim.opt.formatoptions = "jcroqlnt" -- see :help fo-table
vim.opt.ignorecase = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.smartcase = true
vim.opt.spelllang = { "en" }
vim.opt.swapfile = false
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.updatetime = 250
-- ui
vim.opt.breakindent = true
vim.opt.cmdheight = 1
vim.opt.cursorline = true
vim.opt.laststatus = 3
vim.opt.mouse = "a"
vim.opt.pumblend = 10
vim.opt.pumheight = 10
vim.opt.numberwidth = 2
vim.opt.scrolloff = 4
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.smoothscroll = true
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen"
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.fillchars = { eob = " " }
