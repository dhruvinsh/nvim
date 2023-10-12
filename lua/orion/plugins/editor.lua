return {
  { "echasnovski/mini.bufremove", version = false },
  { "folke/flash.nvim", opts = {} },
  { "cshuaimin/ssr.nvim" },

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
  "nvim-treesitter/nvim-treesitter-context",

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

  "nvim-neo-tree/neo-tree.nvim",
  "Wansmer/treesj",
  "folke/persistence.nvim",
  "ahmedkhalf/project.nvim",
}
