return {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
  ---@module "grug-far"
  ---@type grug.far.OptionsOverride
  opts = {
    helpLine = {
      enabled = false,
    },
    helpWindow = {
      relative = "editor",
      width = math.ceil(vim.o.columns * 0.9),
    },
    keymaps = {
      help = { n = "?" },
    },
    showCompactInputs = true,
    showInputsBottomPadding = false,
    showInputsTopPadding = false,
    transient = true,
  },
  keys = {
    { "<leader>cs", "<cmd>GrugFar ripgrep<cr>", desc = "search (ripgrep)", mode = { "n", "v" } },
    { "<leader>cS", "<cmd>GrugFar astgrep<cr>", desc = "search (astgrep)", mode = { "n", "v" } },
  },
}
