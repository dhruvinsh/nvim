return {
  {
    "rmagatti/auto-session",
    event = "BufReadPre",
    cmd = "AutoSession",
    keys = {
      { "<leader>qr", "<cmd>AutoSession restore<cr>", desc = "restore" },
    },
    opts = {
      auto_restore = false,
      bypass_save_filetypes = { "man" },
      git_use_branch_name = true,
    },
  },
}
