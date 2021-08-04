-- Some sane defaults I would like to have

local opt = vim.opt

-- set relative number
opt.relativenumber = true
-- for better completion experience
opt.completeopt = "menuone,noselect"
-- save undo history
opt.undofile = true
-- enable break indent
opt.breakindent = true
-- Case insensitive searching UNLESS /C or capital in search
opt.ignorecase = true
opt.smartcase = true
--Add map to enter paste mode
opt.pastetoggle = '<F3>'
