return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      filetypes = { markdown = true },
      panel = { enabled = false },
      suggestion = { enabled = false },
    },
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "zbirenbaum/copilot-cmp",
      dependencies = "copilot.lua",
      opts = {},
    },
    opts = function(_, opts)
      opts.sources = opts.source or {}
      table.insert(opts.sources, { name = "copilot", group_index = 1, priority = 100 })
    end,
  },
}