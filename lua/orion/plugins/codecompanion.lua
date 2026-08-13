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
  },
  opts = function()
    local component = require("util.codecompanion")
    require("util.lualine").inject_component({ "sections", "lualine_x" }, 1, component)

    return {
      interactions = {
        background = {
          adapter = {
            name = "claude_code",
            model = "sonnet",
          },
        },
        chat = { adapter = "claude_code" },
        inline = { adapter = "sonnet" },
        cmd = { adapter = "claude_code" },
      },
      prompt_library = {
        markdown = {
          dirs = {
            vim.fn.stdpath("config") .. "/prompts",
          },
        },
      },
    }
  end,
}
