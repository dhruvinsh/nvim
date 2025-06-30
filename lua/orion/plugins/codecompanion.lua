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
    require("util.lualine").inject_component({ "sections", "lualine_x" }, 1, component)

    return {
      adapters = {
        opts = {
          show_model_choices = true,
        },
        copilot = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                default = "gpt-4.1",
              },
            },
          })
        end,
      },
      strategies = {
        -- setting provider till snacks.nvim related PR gets merged
        chat = { adapter = "copilot", slash_commands = { ["file"] = { opts = { provider = "fzf_lua" } } } },
        inline = { adapter = "copilot" },
        agent = { adapter = "copilot" },
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
                  [[
You are an expert at writing git commit messages that strictly follow the [Conventional Commits 1.0.0 specification](https://www.conventionalcommits.org/en/v1.0.0/).  
Given the git diff below, generate a single commit message that:

- Uses the correct type (e.g., feat, fix, docs, chore, etc.).
- Optionally includes a scope in parentheses if appropriate.
- Provides a concise, imperative description of the change.
- Includes a body if more context is needed (after a blank line).
- Adds footers (e.g., BREAKING CHANGE, Refs, etc.) if relevant.
- Marks breaking changes with `!` or a BREAKING CHANGE footer as per the spec.

Format your response as a commit message only, with no extra explanation.

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
