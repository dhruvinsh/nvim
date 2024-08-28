return {
  "olimorris/codecompanion.nvim",
  cmd = { "CodeCompanion" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "stevearc/dressing.nvim",
      opts = {},
    },
  },
  opts = {
    strategies = {
      chat = {
        adapter = "copilot",
      },
      inline = {
        adapter = "copilot",
      },
      agent = {
        adapter = "copilot",
      },
    },
  },
}
