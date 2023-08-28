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
      { "tpope/vim-repeat", event = "VeryLazy" },
    },
    config = true,
  },

  -- automatic pair insersion
  {
    "windwp/nvim-autopairs",
    config = true,
    event = { "BufReadPost", "BufNewFile", "InsertEnter" },
    dependencies = {
      {
        "windwp/nvim-ts-autotag",
        config = true,
      },
    },
  },

  -- Git tool that supposed to be banned
  -- {
  --   "tpope/vim-fugitive",
  --   event = { "BufReadPost", "BufNewFile" },
  --   cmd = { "Git" },
  --   keys = {
  --     { "<leader>gg", "<cmd>Git<cr>", mode = "n", desc = "Git Status" },
  --   },
  -- },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "sindrets/diffview.nvim",
    },
    config = true,
    cmd = { "Neogit" },
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", mode = "n", desc = "Git Status" },
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

  -- nvim-cmp disable luasnip for comment and string context
  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      for _, source in ipairs(opts.sources) do
        if source.name == "luasnip" then
          source.option = { use_show_condition = true }
          source.entry_filter = function()
            local ctx = require("cmp.config.context")
            local string_ctx = ctx.in_treesitter_capture("string") or ctx.in_syntax_group("String")
            local comment_ctx = ctx.in_treesitter_capture("comment") or ctx.in_syntax_group("Comment")

            --   Returning `true` will keep the entry, while returning `false` will remove it.
            return not (string_ctx or comment_ctx)
          end
        end
      end
    end,
  },

  {
    "ellisonleao/glow.nvim",
    config = true,
    cmd = "Glow",
  },
}
