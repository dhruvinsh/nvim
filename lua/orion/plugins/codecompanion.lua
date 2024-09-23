return {
  "olimorris/codecompanion.nvim",
  version = "*", -- tagging to latest version
  cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionToggle", "CodeCompanionActions" },
  dependencies = {
    "hrsh7th/nvim-cmp",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
  },
  opts = {
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
    pre_defined_prompts = {
      ["Generate a Commit Message for Staged Files"] = {
        strategy = "chat",
        description = "staged file commit messages",
        opts = {
          index = 9,
          default_prompt = true,
          mapping = "<LocalLeader>gm",
          slash_cmd = "commit",
          auto_submit = true,
        },
        prompts = {
          {
            role = "user",
            contains_code = true,
            content = function()
              return "You are an expert at following the Conventional Commit specification. Given the git diff listed below, please generate a commit message for me:"
                .. "\n\n```\n"
                .. vim.fn.system("git diff --staged")
                .. "\n```"
            end,
          },
        },
      },
    },
  },
  keys = {
    { "<C-a>", "<cmd>CodeCompanionActions<cr>", desc = "ai action", mode = { "n", "v" } },
    { "<leader>at", "<cmd>CodeCompanionToggle<cr>", desc = "toggle", mode = { "n", "v" } },
    { "<leader>gm", desc = "message" },
  },
}
