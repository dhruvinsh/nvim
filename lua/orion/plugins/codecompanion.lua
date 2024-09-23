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
    }
  end,
  keys = {
    { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "action", mode = { "n", "v" } },
    { "<leader>at", "<cmd>CodeCompanionToggle<cr>", desc = "toggle", mode = { "n", "v" } },
    { "<leader>gm", desc = "message" },
  },
}
