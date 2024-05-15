return {
  { "echasnovski/mini.bufremove", version = false },
  { "folke/flash.nvim", opts = {} },
  "cshuaimin/ssr.nvim",
  "nvim-pack/nvim-spectre",
  { "kevinhwang91/nvim-bqf", ft = "qf" },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "nvim-telescope/telescope-frecency.nvim",
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
  },
  "nvim-treesitter/nvim-treesitter-context",

  "mbbill/undotree",
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

  "Shatur/neovim-session-manager",
  "ahmedkhalf/project.nvim",
}
