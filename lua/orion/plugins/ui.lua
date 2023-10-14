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

  { "nvim-lualine/lualine.nvim", config = true },

  { "akinsho/bufferline.nvim", config = true },

  { "lukas-reineke/indent-blankline.nvim", main = "ibl" },
  "echasnovski/mini.indentscope",

  { "folke/which-key.nvim", config = true },

  { "folke/todo-comments.nvim", config = true },

  { "stevearc/dressing.nvim", opts = {} },

  "rcarriga/nvim-notify",
}
