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

  -- I prefere toggleterm over float term of lazyvim
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = "ToggleTerm",
    keys = {
      {
        "<leader>ft",
        "<cmd>ToggleTerm dir=" .. require("lazyvim.util").get_root() .. "<cr>",
        desc = "Terminal (root dir)",
      },
      {
        "<leader>fT",
        "<cmd>ToggleTerm <cr>",
        desc = "Terminal (cwd)",
      },
    },
    config = true,
  },
}
