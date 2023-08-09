return {

  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
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
