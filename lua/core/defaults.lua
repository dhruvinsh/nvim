-- Some sane defaults I would like to have

local opt = vim.opt

-- set relative number
opt.relativenumber = true
-- updatetime
opt.updatetime = 300
-- set number column width
opt.numberwidth = 4
-- save undo history
opt.undofile = true
-- enable break indent
opt.breakindent = true
-- Case insensitive searching UNLESS /C or capital in search
opt.ignorecase = true
opt.smartcase = true
--Add map to enter paste mode
opt.pastetoggle = "<F3>"
-- inser 2 spaces for a tab
opt.expandtab = true
-- spaces inserted for each indentation
opt.shiftwidth = 2
-- set term gui colors
opt.termguicolors = true
-- enable mouse
opt.mouse = "a"
-- fix for indentline
opt.colorcolumn = "99999"
