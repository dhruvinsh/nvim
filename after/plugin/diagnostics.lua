local trouble = require("trouble")

trouble.setup({})

vim.keymap.set("n", "<leader>cD", "<cmd>TroubleToggle<cr>", { desc = "Trouble" })
