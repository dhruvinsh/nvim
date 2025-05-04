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
            tools = {
              ["mcp"] = {
                callback = function()
                  return require("mcphub.extensions.codecompanion")
                end,
                description = "Call tools and resources from the MCP Servers",
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

  {
    "ravitemer/mcphub.nvim",
    cmd = "MCPHub",
    keys = {
      { "<leader>lh", "<cmd>MCPHub<cr>", desc = "MCPHub" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    build = vim.fn.executable("volta") == 1 and "volta install mcp-hub@latest" or "bundled_build.lua",
    opts = {
      auto_approve = true,
      use_bundled_binary = not vim.fn.executable("volta") == 0,
      extensions = {
        codecompanion = {
          show_result_in_chat = true,
          make_vars = true,
          make_slash_commands = true,
        },
      },
      log = {
        level = vim.log.levels.INFO,
        to_file = true,
        file_path = vim.fn.expand("~/.local/state/nvim/mcphub.log"),
        prefix = "MCPHub",
      },
    },
    config = function(_, opts)
      require("mcphub").setup(opts)

      do
        local ok, lualine = pcall(require, "lualine")
        if not ok then
          return
        end
        local lualine_cfg = lualine.get_config()
        table.insert(lualine_cfg.sections.lualine_x, 1, require("mcphub.extensions.lualine"))
        lualine.setup(lualine_cfg)
      end
    end,
  },

  vim.fn.executable("vectorcode") == 1 and {
    "Davidyz/VectorCode",
    version = "*",
    build = "uv tool install -U vectorcode",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "VectorCode",
    keys = {
      { "<leader>av", "<cmd>VectorCode<cr>", desc = "VectorCode" },
    },
  } or {},
}
