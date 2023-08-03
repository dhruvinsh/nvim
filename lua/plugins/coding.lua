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

  -- Git tool that supposed to be banned
  {
    "tpope/vim-fugitive",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "Git" },
    keys = {
      { "<leader>gg", "<cmd>Git<cr>", mode = "n", desc = "Git Status" },
    },
  },
}
