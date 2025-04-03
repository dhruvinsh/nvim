return {
  {
    "catppuccin/nvim",
    priority = 1000,
    name = "catppuccin",
    opts = {
      integrations = {
        blink_cmp = true,
        dadbod_ui = true,
        diffview = true,
        grug_far = true,
        mason = true,
        nvim_surround = true,
        overseer = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
          inlay_hints = {
            background = true,
          },
        },
        which_key = true,
      },
    },
  },
}
