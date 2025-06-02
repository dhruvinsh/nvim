return {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
  ---@module "grug-far"
  ---@type grug.far.OptionsOverride
  opts = {
    transient = true,
    keymaps = {
      help = { n = "?" },
    },
  },
  keys = {
    { "<leader>cs", "<cmd>GrugFar ripgrep<cr>", desc = "search (ripgrep)", mode = { "n", "v" } },
    { "<leader>cS", "<cmd>GrugFar astgrep<cr>", desc = "search (astgrep)", mode = { "n", "v" } },
  },
}
