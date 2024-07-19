vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- column
vim.opt.number = true
vim.opt.signcolumn = "yes"

-- timings
vim.opt.updatetime = 200
vim.opt.timeoutlen = 300

-- edit
vim.opt.virtualedit = "block"

-- undo
vim.opt.undofile = true
vim.opt.undolevels = 10000

-- mouse
vim.opt.mouse = "a"

-- Show whitespace.
vim.opt.list = true
vim.opt.listchars = { tab = "  ↦" }

-- Status line.
vim.opt.laststatus = 3
vim.opt.cmdheight = 1

-- split
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = "screen"

-- Git diff
vim.opt.diffopt:append({ "linematch:100" })

-- cursor
vim.opt.cursorline = true

-- GUI!?
vim.opt.termguicolors = true

-- spell
vim.opt.spelllang = { "en" }
vim.opt.spelloptions:append("noplainbuffer")

-- Markdown indentation
vim.g.markdown_recommended_style = 0
