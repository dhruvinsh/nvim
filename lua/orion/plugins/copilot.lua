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
    keys = {
      {
        "<leader>ta",
        function()
          if require("copilot.client").is_disabled() then
            require("copilot.command").enable()
          else
            require("copilot.command").disable()
          end
        end,
        desc = "ai (copilot)",
      },
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
      table.insert(opts.sources, { group_index = 2, name = "copilot", priority = 100 })
      return opts
    end,
  },
}
