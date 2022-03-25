-- Some key binding done here, later in the future I plan to use which-key
-- as well. Another extention to current keymaps will be avilable there

local setkey = vim.api.nvim_set_keymap
local keyopt1 = { noremap = true }
local keyopt2 = { noremap = true, silent = true }
local keyopt3 = { noremap = true, expr = true, silent = true }

-------------------
-- leader key
-------------------
setkey("", "<Space>", "<Nop>", keyopt2)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

------------------------
-- Some custom keymaps
------------------------
-- Moving line bindings (I love this ones)
setkey("i", "<A-j>", "<Esc>:m .+1<cr>==gi", keyopt1)
setkey("i", "<A-k>", "<Esc>:m .-2<cr>==gi", keyopt1)
setkey("n", "<A-j>", ":m .+1<cr>==", keyopt1)
setkey("n", "<A-k>", ":m .-2<cr>==", keyopt1)
setkey("v", "<A-j>", ":m '>+1<cr>gv=gv", keyopt1)
setkey("v", "<A-k>", ":m '<-2<cr>gv=gv", keyopt1)
--Remap for dealing with word wrap
setkey("n", "j", "v:count == 0 ? 'gj' : 'j'", keyopt3)
setkey("n", "k", "v:count == 0 ? 'gk' : 'k'", keyopt3)
--Remap escape to leave terminal mode
setkey("t", "<Esc>", [[<c-\><c-n>]], keyopt1)
setkey("t", "<C-w>h", [[<C-\><C-n><C-W>h]], keyopt1)
setkey("t", "<C-w>j", [[<C-\><C-n><C-W>j]], keyopt1)
setkey("t", "<C-w>k", [[<C-\><C-n><C-W>k]], keyopt1)
setkey("t", "<C-w>l", [[<C-\><C-n><C-W>l]], keyopt1)

-------------------
-- Buffer keymaps
-------------------
setkey("n", "<leader>bb", "<cmd>Telescope buffers<cr>", keyopt2)
setkey("n", "<leader>bd", ":bdelete<cr>", keyopt2)
setkey("n", "<leader>bn", ":bnext<cr>", keyopt2)
setkey("n", "<leader>bp", ":bprevious<cr>", keyopt2)

-----------------------------
-- Documents keymaps (neogen)
-----------------------------
setkey("n", "<leader>dc", "<cmd>Neogen class<cr>", keyopt2)
setkey("n", "<leader>df", "<cmd>Neogen func<cr>", keyopt2)
setkey("n", "<leader>dF", "<cmd>Neogen file<cr>", keyopt2)
setkey("n", "<leader>dt", "<cmd>Neogen type<cr>", keyopt2)

-------------------
-- Files keymaps
-------------------
setkey("n", "<leader>ff", "<cmd>Telescope find_files<cr>", keyopt2)
setkey("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", keyopt2)
setkey("n", "<leader>ft", "<cmd>NvimTreeToggle<cr>", keyopt2)
setkey("n", "<leader>fT", "<cmd>ToggleTerm<cr>", keyopt2)
setkey("n", "<leader>fz", "<cmd>TZAtaraxis<cr>", keyopt2)

-------------------
-- Git keymaps
-------------------
setkey("n", "<leader>ghP", "<cmd>lua require('gitsigns').preview_hunk()<cr>", keyopt2)
setkey("n", "<leader>ghR", "<cmd>lua require('gitsigns').reset_buffer()<cr>", keyopt2)
setkey("n", "<leader>gf", "<cmd>Telescope git_files<cr>", keyopt2)
setkey("n", "<leader>gg", "<cmd>Neogit<cr>", keyopt2)
setkey("n", "<leader>ghb", "<cmd>lua require('gitsigns').blame_line()<cr>", keyopt2)
setkey("n", "<leader>ghn", "<cmd>lua require('gitsigns').next_hunk()<cr>", keyopt2)
setkey("n", "<leader>ghp", "<cmd>lua require('gitsigns').prev_hunk()<cr>", keyopt2)
setkey("n", "<leader>ghr", "<cmd>lua require('gitsigns').reset_hunk()<cr>", keyopt2)
setkey("n", "<leader>ghs", "<cmd>lua require('gitsigns').stage_hunk()<cr>", keyopt2)
setkey("n", "<leader>ghu", "<cmd>lua require('gitsigns').undo_stage_hunk()<cr>", keyopt2)

setkey("o", "ih", ":<C-U>lua require('gitsigns').select_hunk()<cr>", keyopt2)

setkey("v", "<leader>ghr", "<cmd>lua require('gitsigns').reset_hunk({vim.fn.line('.'), vim.fn.line('v')})<cr>", keyopt2)
setkey("v", "<leader>ghs", "<cmd>lua require('gitsigns').stage_hunk({vim.fn.line('.'), vim.fn.line('v')})<cr>", keyopt2)

setkey("x", "ih", ":<C-U>lua require('gitsigns').select_hunk()<cr>", keyopt2)

--------------------------
-- LSP management keymaps
--------------------------
setkey("n", "<leader>li", "<cmd>LspInfo<CR>", keyopt2)
setkey("n", "<leader>lr", "<cmd>LspRestart<CR>", keyopt2)
setkey("n", "<leader>ls", "<cmd>LspStart<CR>", keyopt2)
setkey("n", "<leader>lt", "<cmd>LspStop<CR>", keyopt2)

-------------------
-- Project keymaps
-------------------
setkey("n", "<leader>pp", "<cmd>Telescope projects<CR>", keyopt2)

-------------------
-- Search keymaps
-------------------
setkey("n", "<leader>sC", "<cmd>lua Telescope colorscheme<cr>", keyopt2)
setkey("n", "<leader>sc", "<cmd>lua Telescope commands<cr>", keyopt2)
-- some how i keep pressing this to open files, probably from default.nvim
setkey("n", "<leader>sf", "<cmd>lua Telescope find_files<cr>", keyopt2)
setkey("n", "<leader>sg", "<cmd>lua Telescope live_grep<cr>", keyopt2)
setkey("n", "<leader>sh", "<cmd>lua Telescope help_tags<cr>", keyopt2)
setkey("n", "<leader>sk", "<cmd>lua Telescope keymaps<cr>", keyopt2)
setkey("n", "<leader>ss", "<cmd>lua Telescope grep_string<cr>", keyopt2)
setkey("n", "<leader>st", "<cmd>lua Telescope tags<cr>", keyopt2)
