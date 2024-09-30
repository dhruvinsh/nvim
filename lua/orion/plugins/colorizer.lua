return {
  "norcalli/nvim-colorizer.lua",
  cmd = { "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer", "ColorizerReloadAllBuffers", "ColorizerToggle" },
  keys = {
    { "<leader>cc", "<cmd>ColorizerToggle<cr>", desc = "colorizer" },
  },
  opts = {},
}
