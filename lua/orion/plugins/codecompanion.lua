return {
  {
    "olimorris/codecompanion.nvim",
    version = "*", -- tagging to latest version
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
        adapters = {
          copilot = function()
            return require("codecompanion.adapters").extend("copilot", {
              schema = {
                model = {
                  default = "claude-3.7-sonnet-thought",
                },
              },
            })
          end,
        },
        strategies = {
          chat = {
            adapter = "copilot",
            slash_commands = {
              ["file"] = {
                opts = { provider = "fzf_lua" },
              },
              ["buffer"] = {
                opts = { provider = "fzf_lua" },
              },
            },
          },
          inline = {
            adapter = "copilot",
          },
          agent = {
            adapter = "copilot",
          },
        },
        prompt_library = {
          ["Generate a Commit Message"] = {
            strategy = "inline",
            opts = {
              name = "copilot",
              model = "gpt-4o-2024-08-06",
            },
          },
        },
      }
    end,
  },
}
