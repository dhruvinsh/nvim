vim.keymap.set("n", "<leader>gP", "<cmd>Git push<cr>", { desc = "push", buffer = 0 })
vim.keymap.set("n", "<leader>gp", "<cmd>Git pull<cr>", { desc = "pull", buffer = 0 })
vim.keymap.set("n", "q", "<cmd>quit<cr>", { desc = "close", silent = true, buffer = 0 })
