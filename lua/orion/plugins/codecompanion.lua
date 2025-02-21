return {
  {
    "olimorris/codecompanion.nvim",
    version = "v12.*", -- tagging to latest version
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "action", mode = { "n", "v" } },
      { "<leader>at", "<cmd>CodeCompanionChat Toggle<cr>", desc = "toggle", mode = { "n", "v" } },
      { "<leader>gm", "<cmd>lua require('codecompanion').prompt('commit') <cr>", desc = "message" },
    },
    opts = function()
      local component = require("util.codecompanion")
      do
        local ok, lualine = pcall(require, "lualine")
        if not ok then
          return
        end
        local lualine_cfg = lualine.get_config()
        table.insert(lualine_cfg.sections.lualine_x, 1, component)
        lualine.setup(lualine_cfg)
      end

      return {
        strategies = {
          chat = {
            adapter = "copilot",
          },
          inline = {
            adapter = "copilot",
          },
          agent = {
            adapter = "copilot",
          },
        },
        display = { chat = { show_settings = true } },
      }
    end,
  },

  {
    "saghen/blink.cmp",
    -- optas = function(_, opts)
    --   local providers = opts.sources.completion.enabled_providers
    -- end,
    opts = {
      sources = {
        default = { "codecompanion" },
        providers = {
          codecompanion = {
            name = "CodeCompanion",
            module = "codecompanion.providers.completion.blink",
            enabled = true,
          },
        },
      },
    },
  },
}
