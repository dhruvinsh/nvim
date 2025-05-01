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
      { "<leader>ac", "<cmd>CodeCompanionActions<cr>", desc = "action", mode = { "n", "v" } },
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
                  default = "gemini-2.5-pro",
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
              model = "gemini-2.0-flash-001",
            },
          },
        },
      }
    end,
  },

  {
    "joshuavial/aider.nvim",
    cmd = { "AiderOpen", "AiderAddModifiedFiles" },
    keys = {
      { "<leader>aa", "<cmd>AiderOpen<cr>", desc = "open" },
      { "<leader>am", "<cmd>AiderAddModifiedFiles<cr>", desc = "add modified" },
    },
    opts = {
      auto_manage_context = true,
      default_bindings = false,
      debug = false,
    },
  },
}
