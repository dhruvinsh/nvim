return {
  {
    "ravitemer/mcphub.nvim",
    cmd = "MCPHub",
    keys = {
      { "<leader>lh", "<cmd>MCPHub<cr>", desc = "mcphub" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    build = vim.fn.executable("mise") == 1 and "mise use -g npm:mcp-hub" or "bundled_build.lua",
    ---@module "mcphub"
    ---@type MCPHub.Config
    opts = {
      auto_approve = true,
      use_bundled_binary = vim.fn.executable("mise") == 0,
      log = {
        level = vim.log.levels.INFO,
        to_file = true,
        file_path = vim.fn.stdpath("state") .. "/mcphub.log",
        prefix = "MCPHub",
      },
    },
    config = function(_, opts)
      require("mcphub").setup(opts)

      local component = require("mcphub.extensions.lualine")
      require("util.lualine").inject_component({ "sections", "lualine_x" }, 1, component)
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    opts = {
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            show_result_in_chat = true,
            make_vars = true,
            make_slash_commands = true,
          },
        },
      },
    },
  },
}
