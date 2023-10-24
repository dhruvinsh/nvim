require("zen-mode").setup({
  window = {
    width = 90,
  },
  plugins = {
    gitsigns = { enabled = true },
    tmux = { enabled = true },
    wezterm = { enabled = true, font = "+2" },
  },
})

vim.keymap.set("n", "<leader>fz", "<cmd>lua require('zen-mode').toggle()<cr>", { desc = "Zen" })
