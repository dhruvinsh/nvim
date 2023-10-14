require("persistence").setup({
  options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" },
})

-- restore the session for the current directory
vim.api.nvim_set_keymap("n", "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]], { desc = "Current Session" })

-- restore the last session
vim.api.nvim_set_keymap(
  "n",
  "<leader>ql",
  [[<cmd>lua require("persistence").load({ last = true })<cr>]],
  { desc = "Last Session" }
)

-- stop Persistence => session won't be saved on exit
vim.api.nvim_set_keymap("n", "<leader>ts", [[<cmd>lua require("persistence").stop()<cr>]], { desc = "Session Stop" })
