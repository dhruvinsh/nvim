return {
  "joshuavial/aider.nvim",
  cmd = { "AiderOpen", "AiderAddModifiedFiles" },
  keys = {
    { "<leader>aa", "<cmd>AiderOpen<cr>", desc = "open" },
    { "<leader>am", "<cmd>AiderAddModifiedFiles<cr>", desc = "add modified" },
  },
  opts = {
    auto_manage_context = true,
    default_bindings = false,
    debug = false,
  },
}
