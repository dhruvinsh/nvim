return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@module "snacks"
  ---@type snacks.Config
  opts = {
    input = { enabled = true },
    notifier = { enabled = true },
    picker = { enabled = true },
  },
}
