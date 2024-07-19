return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = { },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "local keymaps",
    },
  },
}
