return {
  {
    "rmagatti/auto-session",
    event = "BufReadPre",
    cmd = "SessionRestore",
    keys = {
      { "<leader>qr", "<cmd>SessionRestore<cr>", desc = "restore" },
    },
    opts = {
      auto_restore_enabled = false,
      auto_session_use_git_branch = true,
      bypass_session_save_file_types = { "man" },
    },
  },
}
