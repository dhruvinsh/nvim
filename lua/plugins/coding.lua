return {

  -- disabling some defaults
  {
    "echasnovski/mini.surround",
    enabled = false,
  },

  {
    "echasnovski/mini.pairs",
    enabled = false,
  },

  -- ([< surround >]) it.
  {
    "kylechui/nvim-surround",
    version = "*",
    event = { "BufReadPost", "BufNewFile", "InsertEnter" },
    dependencies = {
      { "tpope/vim-repeat", lazy = true },
    },
    config = true,
  },

  -- automatic pair insersion
  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    config = true,
  },
}
