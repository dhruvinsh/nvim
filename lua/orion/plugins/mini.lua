return {
  {
    "echasnovski/mini.ai",
    event = "BufReadPost",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = function()
      local spec = require("mini.ai").gen_spec.treesitter

      return {
        n_lines = 300,
        custom_textobjects = {
          c = spec({ a = "@class.outer", i = "@class.inner" }),
          f = spec({ a = "@function.outer", i = "@function.inner" }),
        },
        silent = true,
      }
    end,
  },

  {
    "echasnovski/mini.align",
    opts = {},
    keys = {
      { "ga", mode = { "n", "v" }, desc = "align" },
      { "gA", mode = { "n", "v" }, desc = "align (preview)" },
    },
  },

  {
    "echasnovski/mini.bufremove",
    keys = {
      { "<leader>bd", "<cmd>lua MiniBufremove.delete(0)<cr>", desc = "delete" },
    },
    opts = {},
  },

  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {
      lsp = {
        copilot = { glyph = "", hl = "MiniIconsPurple" },
      },
    },
    init = function()
      require("mini.icons").mock_nvim_web_devicons()
    end,
  },

  {
    "echasnovski/mini.indentscope",
    event = "BufReadPost",
    opts = {
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      local u = require("util")
      vim.api.nvim_create_autocmd("FileType", {
        group = u.augroup("mini.indentscope"),
        pattern = u.no_indent_filetypes,
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },

  {
    "echasnovski/mini.jump",
    event = "BufReadPost",
    opts = {},
  },

  {
    "echasnovski/mini.jump2d",
    event = "BufReadPost",
    opts = {
      view = { dim = true },
    },
    keys = {
      { "s", "<cmd>lua MiniJump2d.start(MiniJump2d.builtin_opts.single_character)<cr>", desc = "snip" },
    },
  },
}
