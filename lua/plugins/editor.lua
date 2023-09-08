return {
  {
    "m4xshen/hardtime.nvim",
    event = "BufReadPost",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {
      disabled_filetypes = {
        "NeogitStatus",
        "NvimTree",
        "fugitive",
        "lazy",
        "mason",
        "neo-tree",
        "netrw",
        "noice",
        "oil",
        "qf",
      },
    },
    keys = {
      {
        "<leader>uh",
        "<cmd>Hardtime toggle<cr>",
        desc = "Hardtime toggle",
      },
    },
  },

  {
    "echasnovski/mini.align",
    version = false,
    event = { "BufReadPre", "BufNewFile" },
    config = function(_, opts)
      require("mini.align").setup(opts)
    end,
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

  -- jk to Esc
  {
    "max397574/better-escape.nvim",
    event = "BufReadPost",
    opts = {
      mapping = { "jk", "ne" }, -- a table with mappings to use
      timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
      clear_empty_lines = false, -- clear line after escaping if there is only whitespace
    },
    config = function(_, opts)
      require("better_escape").setup(opts)
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      -- add telescope-fzf-native
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
    opts = {
      defaults = {
        file_ignore_patterns = { ".git" },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--column",
          "--hidden",
          "--line-number",
          "--no-heading",
          "--smart-case",
          "--with-filename",
        },
      },
    },
  },
}
