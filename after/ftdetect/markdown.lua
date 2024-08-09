-- options
vim.opt_local.spell = true

-- keymaps
vim.keymap.set("n", "<leader>cp", "<cmd>MarkdownPreviewToggle<cr>", { desc = "preview" })
vim.keymap.set("n", "<leader>cP", "<cmd>Glow<cr>", { desc = "preview" })
