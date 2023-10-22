require("mini.bufremove").setup()

vim.keymap.set("n", "<leader>bd", require("mini.bufremove").delete, { desc = "Delte" })
