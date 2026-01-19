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
        http = {
          opts = {
            show_model_choices = true,
          },
        },
      },
      strategies = {
        -- setting provider till snacks.nvim related PR gets merged
        chat = { adapter = "copilot" },
        inline = { adapter = "copilot" },
        agent = { adapter = "copilot" },
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
