local g = vim.g

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
g.mapleader = " "
g.maplocalleader = " "

-- disable some built-in plugins
-- reference: https://github.com/mrjones2014/dotfiles/blob/master/.config/nvim/lua/disable-builtins.lua
local built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit",
}

vim.tbl_map(function(plugin)
  vim.g["loaded_" .. plugin] = 1
end, built_ins)

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

-- Set colorscheme
vim.o.termguicolors = true

-- Global statusline
vim.o.laststatus = 3

-- Some UI changes
vim.o.title = true
vim.o.cursorline = true

-- I like look without any cmdline
vim.o.cmdheight = 0

-- mousemovent for bufferline hover option
-- NOTE: using this would take about 1% to 2% CPU usage
-- vim.o.mousemoveevent = true

-- NOTE: this was behaving unexpected way with better-escape.
-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
-- vim.o.whichwrap:append("<>[]hl")