return {

  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    opts = {
      disable_italics = true,
      highlight_groups = {
        Comment = { italic = true },
      },
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },
}
