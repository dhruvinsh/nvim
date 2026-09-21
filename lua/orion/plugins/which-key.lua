return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      { "<leader><tab>", group = "tab", icon = "󰓩" },
      { "<leader>a", group = "ai", icon = "󰚩" },
      { "<leader>b", group = "buffer" },
      { "<leader>c", group = "code" },
      { "<leader>d", group = "debug" },
      { "<leader>f", group = "file" },
      { "<leader>g", group = "git" },
      { "<leader>j", group = "job", icon = "" },
      { "<leader>l", group = "lsp" },
      { "<leader>q", group = "session" },
      { "<leader>s", group = "search" },
      { "<leader>t", group = "toggle" },
      { "[", group = "prev" },
      { "]", group = "next" },
      { "g", group = "goto" },
      { "z", group = "fold" },
    },
    icons = {
      rules = {
        { plugin = "overseer.nvim", icon = " ", color = "cyan" },
      },
    },
    triggers = {
      { "<auto>", mode = "nxso" },
      { "c", mode = "n" },
      { "d", mode = "n" },
      { "r", mode = "n" },
    },
  },
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
