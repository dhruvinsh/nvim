return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
  },

  "mbbill/undotree",
  "andymass/vim-matchup",
  {
    "max397574/better-escape.nvim",
    config = true,
  },

  {
    "echasnovski/mini.align",
    version = false,
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_by_name = {
            ".git",
          },
        },
      },
    },
  },

  "Wansmer/treesj",
}
