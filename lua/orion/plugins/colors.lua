return {
  {
    "catppuccin/nvim",
    priority = 1000,
    name = "catppuccin",
    ---@module "catppuccin"
    ---@type CatppuccinOptions
    opts = {
      transparent_background = true,
      float = {
        transparent = false,
        solid = true,
      },
      lsp_styles = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
          ok = { "italic" },
        },
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
          ok = { "undercurl" },
        },
        inlay_hints = {
          background = true,
        },
      },
      integrations = {
        blink_cmp = true,
        dadbod_ui = true,
        diffview = true,
        grug_far = true,
        mason = true,
        nvim_surround = true,
        overseer = true,
        which_key = true,
      },
    },
  },
}
