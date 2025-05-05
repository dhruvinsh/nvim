return {
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
}
