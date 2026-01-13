-- options
vim.opt_local.spell = true

-- keymaps
vim.keymap.set("n", "<leader>cp", "<cmd>MarkdownPreviewToggle<cr>", { desc = "preview", buffer = 0 })
vim.keymap.set("n", "<leader>cP", "<cmd>Glow<cr>", { desc = "preview", buffer = 0 })

-- folding
vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.wo[0][0].foldmethod = "expr"

-- indentation
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
