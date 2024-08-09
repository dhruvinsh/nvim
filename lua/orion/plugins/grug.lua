return {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
  opts = {
    transient = true,
    keymaps = {
      help = { n = "?" },
    },
  },
  keys = {
    { "<leader>cR", "<cmd>GrugFar<cr>", desc = "Search and replace", mode = { "n", "v" } },
  },
}
