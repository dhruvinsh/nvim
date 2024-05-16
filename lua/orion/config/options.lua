local utils = require("utils")
vim.g.orion_color_scheme = "onedark"

-- setup volta
if vim.fn.executable("volta") then vim.g.node_host_prog = vim.fn.trim(vim.fn.system("volta which neovim-node-host")) end

-- setup python
if utils.is_win then
  if vim.fn.executable("python") then vim.g.python3_host_prog = "python" end
else
  -- on linux and mac os I use pyenv to manage python, soon to be `Rye`
  if vim.fn.executable("pyenv") then
    local py_version = vim.fn.trim(vim.fn.system("pyenv global"))
    vim.g.python3_host_prog = "~/.pyenv/versions/" .. py_version .. "/bin/python3"
  end
end

-- system
if not vim.env.SSH_TTY then
  -- only set clipboard if not in ssh, to make sure the OSC 52
  -- integration works automatically. Requires Neovim >= 0.10.0
  vim.opt.clipboard = "unnamedplus"
end

-- editor
vim.opt.autoindent = true
vim.opt.completeopt = "menuone,noselect"
vim.opt.confirm = true
vim.opt.expandtab = true
vim.opt.formatoptions = "jcroqlnt" -- see :help fo-table
vim.opt.ignorecase = true
vim.opt.number = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.smartcase = true
vim.opt.spelllang = { "en" }
vim.opt.swapfile = false
vim.opt.tabstop = 2
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.updatetime = 250
-- ui
vim.opt.breakindent = true
vim.opt.cmdheight = 1
vim.opt.conceallevel = 3
vim.opt.cursorline = true
vim.opt.laststatus = 3
vim.opt.mouse = "a"
vim.opt.pumblend = 10
vim.opt.fillchars = { foldclose = "", foldopen = "", eob = " " }
vim.opt.numberwidth = 2
vim.opt.pumheight = 10
vim.opt.scrolloff = 4
vim.opt.shortmess:append("C")
vim.opt.shortmess:append("I")
vim.opt.shortmess:append("W")
-- l	use "999L, 888B" instead of "999 lines, 888 bytes"	*shm-l*
-- m	use "[+]" instead of "[Modified]"			*shm-m*
-- r	use "[RO]" instead of "[readonly]"			*shm-r*
-- w	use "[w]" instead of "written" for file write message	*shm-w*
-- and "[a]" instead of "appended" for ':w >> file' command
-- a	all of the above abbreviations				*shm-a*
vim.opt.shortmess:append("a")
vim.opt.shortmess:append("c")
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.smoothscroll = true
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen"
vim.opt.splitright = true
vim.opt.termguicolors = true
-- Session
vim.opt.sessionoptions = { "blank", "buffers", "curdir", "folds", "help", "tabpages", "winsize", "terminal", "options" }

-- Neovide specific config
if vim.g.neovide then
  vim.o.guifont = "Iosevka NF:h14"
  vim.opt.linespace = 0
end
