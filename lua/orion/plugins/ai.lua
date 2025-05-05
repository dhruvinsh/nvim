return {
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
    { "<leader>gm", "<cmd>lua require('codecompanion').prompt('orion_commit') <cr>", desc = "message" },
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
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            show_result_in_chat = true,
            make_vars = true,
            make_slash_commands = true,
          },
        },
        vectorcode = {
          opts = { add_tool = true, add_slash_command = true, tool_opts = {} },
        },
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
        ["git commits"] = {
          strategy = "inline",
          description = "Generate git commit for staged changes",
          opts = {
            placement = "replace",
            short_name = "orion_commit",
            auto_submit = true,
            adapter = {
              name = "copilot",
              model = "gpt-4.1",
            },
          },
          prompts = {
            {
              role = "user",
              content = function()
                return string.format(
                  [[You are an expert at following the Conventional Commit specification. Given the git diff listed below, please generate a commit message for me:

```diff
%s
```
]],
                  vim.fn.system("git diff --no-ext-diff --staged")
                )
              end,
              opts = {
                contains_code = true,
              },
            },
          },
        },
      },
    }
  end,
}
