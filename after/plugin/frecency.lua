require("telescope").load_extension("frecency")

vim.keymap.set({ "n", "v" }, "<leader>?", "<cmd>Telescope frecency workspace=CWD<cr>", { desc = "Find Recent" })
vim.keymap.set({ "n", "v" }, "<leader>fr", "<cmd>Telescope frecency workspace=CWD<cr>", { desc = "Find Recent" })
