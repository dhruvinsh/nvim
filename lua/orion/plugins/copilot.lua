return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
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
    config = function(_, opts)
      require("copilot").setup(opts)

      local component = require("util.copilot")
      do
        local ok, lualine = pcall(require, "lualine")
        if not ok then
          return
        end
        local lualine_cfg = lualine.get_config()
        table.insert(lualine_cfg.sections.lualine_x, 1, component)
        lualine.setup(lualine_cfg)
      end
    end,
  },

  {
    "saghen/blink.cmp",
    dependencies = { "giuxtaposition/blink-cmp-copilot" },
    opts = {
      sources = {
        default = { "copilot" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
            score_offset = 70,
            async = true,
            transform_items = function(_, items)
              for _, item in ipairs(items) do
                item.kind_icon = ""
                item.kind_name = "Copilot"
              end
              return items
            end,
          },
        },
      },
    },
  },
}
