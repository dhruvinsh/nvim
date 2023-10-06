return {
  "tpope/vim-surround",
  "tpope/vim-sleuth",
  "tpope/vim-repeat",

  -- git plugins
  "tpope/vim-fugitive",
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
  },

  {
    "numToStr/Comment.nvim",
    config = true,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      open_mapping = [[<c-\>]],
    },
  },

  {
    "ellisonleao/glow.nvim",
    config = true,
    cmd = "Glow",
  },

  -- LSP Configuration & Plugins
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      "folke/neodev.nvim",
      -- till the rewrite is done keep it to legacy
      { "j-hui/fidget.nvim", tag = "legacy", opts = {} },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/nvim-cmp",

      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },
  "mfussenegger/nvim-lint",
  "stevearc/conform.nvim",
}
