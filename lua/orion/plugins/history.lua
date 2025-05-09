return {
  {
    "ravitemer/codecompanion-history.nvim",
    lazy = true,
  },
  {
    "olimorris/codecompanion.nvim",
    opts = {
      extensions = {
        history = {
          opts = {
            auto_save = false,
            delete_on_clearing_chat = true,
            picker = "default",
          },
        },
      },
    },
  },
}
