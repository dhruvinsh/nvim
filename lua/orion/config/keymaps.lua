-- color scheme
require("util.toggle").colorscheme:map_and_register("n", "<leader>tc")
-- ease of life
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "clear search + escape" })
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- editor
vim.keymap.set("n", "<C-s>", "<cmd>w<cr>", { desc = "save" })
vim.keymap.set("i", "<C-s>", "<C-o><cmd>w<cr>", { desc = "save" })
vim.keymap.set("n", "<C-S-s>", "<cmd>wa<cr>", { desc = "save all" })
vim.keymap.set("i", "<C-S-s>", "<C-o><cmd>wa<cr>", { desc = "save all" })
require("util.toggle").wrap:map_and_register("n", "<leader>tw")

-- indent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- buffers
vim.keymap.set("n", "<S-h>", "<cmd>bprev<cr>", { desc = "previous" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "next" })

-- windows
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "w-left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "w-down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "w-up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "w-left" })
vim.keymap.set("n", "<leader>wd", "<C-w>c", { desc = "close" })
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "vertical" })
vim.keymap.set("n", "<leader>wx", "<C-w>s", { desc = "split" })

-- tabs
vim.keymap.set("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "next" })
vim.keymap.set("n", "<leader><tab>[", "<cmd>tabprev<cr>", { desc = "prev" })
vim.keymap.set("n", "<leader><tab>n", "<cmd>tabnew<cr>", { desc = "new" })
vim.keymap.set("n", "<leader><tab>c", "<cmd>tabclose<cr>", { desc = "close" })

-- tools
vim.keymap.set("n", "<leader>ll", "<cmd>Lazy<cr>", { desc = "lazy" })
