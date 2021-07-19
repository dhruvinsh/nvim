local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- leader key
map("n", "<Space>", "<NOP>", opts)
vim.g.mapleader = " "


-- FTerm
map('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>', opts)
map('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opts)
