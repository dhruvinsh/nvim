return {
  {
    "rmagatti/auto-session",
    event = "BufReadPre",
    cmd = "SessionRestore",
    keys = {
      { "<leader>qr", "<cmd>SessionRestore<cr>", desc = "restore" },
    },
    opts = {
      auto_restore = false,
      use_git_branch = true,
      bypass_save_filetypes = { "man" },
    },
  },
}
