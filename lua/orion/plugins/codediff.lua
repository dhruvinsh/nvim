return {
  "esmuellert/codediff.nvim",
  dependencies = {
    { "MunifTanjim/nui.nvim" },
    {
      "georgeguimaraes/review.nvim",
      cmd = { "Review" },
      keys = {
        { "<leader>cr", "<cmd>Review<cr>", desc = "Review" },
        { "<leader>cR", "<cmd>Review commits<cr>", desc = "Review commits" },
      },
      opts = {},
    },
  },
  cmd = "CodeDiff",
  keys = {
    { "<leader>cd", "<cmd>CodeDiff<cr>", desc = "Code Diff" },
  },
  opts = {},
}
