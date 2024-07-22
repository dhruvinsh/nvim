return {
  "ibhagwan/smartyank.nvim",
  event = "BufReadPost",
  keys = {
    { "y", desc = "yank" },
  },
  opts = {
    highlight = { enabled = false },
    osc52 = { silent = true },
  },
}
