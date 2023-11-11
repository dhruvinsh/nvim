require("mini.files").setup({})

vim.keymap.set("n", "<leader>fe", ":lua MiniFiles.open() <cr>", { desc = "Explorer" })
