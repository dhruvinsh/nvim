---@diagnostic disable-next-line:missing-fields
require("notify").setup({
  render = "compact",
})

-- replace the built-in
vim.notify = require("notify")

require("telescope").load_extension("notify")

-- it supports Telescope notification as well
vim.keymap.set("n", "<leader>sn", "<cmd>Telescope notify<cr>", { desc = "Notifications" })
