local gs = require("gitsigns")

-- fugitive
vim.keymap.set("n", "<leader>gg", vim.cmd.Git, { desc = "Git Status" })

-- gitsigns
vim.keymap.set("n", "gP", gs.preview_hunk, { buffer = true, desc = "Preview git hunk" })
vim.keymap.set({ "n", "v" }, "]h", gs.next_hunk, { buffer = true, desc = "Jump to next hunk" })
vim.keymap.set({ "n", "v" }, "[h", gs.prev_hunk, { buffer = true, desc = "Jump to previous hunk" })
