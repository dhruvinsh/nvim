return {
  "ibhagwan/smartyank.nvim",
  event = "BufReadPost",
  keys = {
    { "y", desc = "yank" },
  },
  opts = {
    osc52 = { silent = true },
  },
}
