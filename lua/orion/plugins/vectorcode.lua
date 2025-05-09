if vim.fn.executable("vectorcode") == 0 then
  return {}
end

return {
  {
    "Davidyz/VectorCode",
    version = "*",
    build = "uv tool install -U vectorcode",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "VectorCode",
    keys = {
      { "<leader>av", "<cmd>VectorCode<cr>", desc = "VectorCode" },
    },
  },

  {
    "olimorris/codecompanion.nvim",
    opts = {
      extensions = {
        vectorcode = {
          callback = "codecompanion._extensions.vectorcode",
          opts = { add_tool = true, add_slash_command = true, tool_opts = {} },
        },
      },
    },
  },
}
