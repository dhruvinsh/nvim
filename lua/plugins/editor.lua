return {
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
          always_show = {
            ".clang-format",
            ".editorconfig",
            ".envrc",
            ".github",
            ".gitignore",
            ".vscode",
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
      mapping = { "jk" }, -- a table with mappings to use
      timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
      clear_empty_lines = false, -- clear line after escaping if there is only whitespace
    },
    config = function(_, opts)
      require("better_escape").setup(opts)
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
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

  -- add telescope-fzf-native
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },
}
