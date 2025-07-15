return {
  "williamboman/mason.nvim",
  cmd = { "Mason", "MasonUpdate" },
  build = ":MasonUpdate",
  keys = {
    { "<leader>lm", "<cmd>Mason<cr>", desc = "mason" },
  },
  opts = {
    ui = {
      border = "rounded",
      width = 0.7,
      height = 0.8,
    },
  },
}
