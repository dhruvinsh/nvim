return {
  "olimorris/codecompanion.nvim",
  version = "*", -- tagging to latest version
  cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
  dependencies = {
    "hrsh7th/nvim-cmp",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
  },
  keys = {
    { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "action", mode = { "n", "v" } },
    { "<leader>at", "<cmd>CodeCompanionChat Toggle<cr>", desc = "toggle", mode = { "n", "v" } },
    { "<leader>gm", desc = "message" },
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
      prompt_library = {
        ["Generate a Commit Message"] = {
          opts = {
            mapping = "<LocalLeader>gm",
          },
        },
      },
    }
  end,
}
