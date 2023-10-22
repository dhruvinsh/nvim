local tsj = require("treesj")
local langs = require("treesj.langs")

tsj.setup({
  use_default_keymaps = false,
  langs = langs["presets"],
})

vim.keymap.set("n", "gS", tsj.split, { desc = "Split" })
vim.keymap.set("n", "gJ", tsj.join, { desc = "Join" })
