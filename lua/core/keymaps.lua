-- Some key binding done here, later in the future I plan to use which-key
-- as well. Another extention to current keymaps will be avilable there

local setkey = vim.api.nvim_set_keymap
local keyopt1 = { noremap = true }
local keyopt2 = { noremap = true, silent = true }

-- leader key
setkey('', '<Space>', '<Nop>', keyopt2)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Moving line bindings (I love this ones)
setkey('n', '<A-j>', ':m .+1<CR>==', keyopt1)
setkey('n', '<A-k>', ':m .-2<CR>==', keyopt1)
setkey('v', '<A-j>', ":m '>+1<CR>gv=gv", keyopt1)
setkey('v', '<A-k>', ":m '<-2<CR>gv=gv", keyopt1)
setkey('i', '<A-j>', '<Esc>:m .+1<CR>==gi', keyopt1)
setkey('i', '<A-k>', '<Esc>:m .-2<CR>==gi', keyopt1)

-- Telescope bindings
setkey("n", "<leader>bs", "<cmd>lua require('telescope.builtin').buffers()<cr>", keyopt2)
setkey("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", keyopt2)
setkey("n", "<leader>fr", "<cmd>lua require('telescope.builtin').oldfiles()<cr>", keyopt2)
setkey("n", "<leader>gf", "<cmd>lua require('telescope.builtin').git_files()<cr>", keyopt2)
setkey("n", "<leader>sc", "<cmd>lua require('telescope.builtin').commands()<cr>", keyopt2)
setkey("n", "<leader>sC", "<cmd>lua require('telescope.builtin').colorscheme()<cr>", keyopt2)
-- some how i keep pressing this to open files, probably from default.nvim
setkey("n", "<leader>sf", "<cmd>lua require('telescope.builtin').find_files()<cr>", keyopt2)
setkey("n", "<leader>sg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", keyopt2)
setkey("n", "<leader>sh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", keyopt2)
setkey("n", "<leader>sk", "<cmd>lua require('telescope.builtin').keymaps()<cr>", keyopt2)
setkey("n", "<leader>ss", "<cmd>lua require('telescope.builtin').grep_string()<cr>", keyopt2)
setkey("n", "<leader>st", "<cmd>lua require('telescope.builtin').tags()<cr>", keyopt2)
