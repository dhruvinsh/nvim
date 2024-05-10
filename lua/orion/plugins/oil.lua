return {
  "stevearc/oil.nvim",
  config = function()
    require("oil").setup()
    vim.keymap.set("n", "<leader>fE", "<cmd>Oil<cr>", { desc = "Oil" })
  end,
}
