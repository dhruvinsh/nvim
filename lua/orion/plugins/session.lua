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
      bypass_save_filetypes = { "man" },
      git_use_branch_name = true,
    },
  },
}
