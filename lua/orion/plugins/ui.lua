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
    "nvim-lualine/lualine.nvim",
    config = true,
  },

  {
    "akinsho/bufferline.nvim",
    config = true,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { enabled = false },
    },
  },

  {
    "echasnovski/mini.indentscope",
    version = false,
    opts = {
      symbol = "│",
      options = { try_as_border = true },
    },
  },

  { "folke/which-key.nvim", config = true },

  { "folke/todo-comments.nvim", config = true },

  { "stevearc/dressing.nvim", opts = {} },
}
