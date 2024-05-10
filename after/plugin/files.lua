-----------
--- Oil ---
-----------

local oil = require("oil")

oil.setup({})

vim.keymap.set("n", "<leader>fE", "<cmd>Oil <cr>", { desc = "Explorer" })
