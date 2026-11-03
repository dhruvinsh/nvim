return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
    ---@module "render-markdown"
    ---@type render.md.UserConfig
    opts = {
      code = {
        style = "language",
      },
    },
  },

  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        default = { "markdown" },
        providers = {
          markdown = {
            name = "RenderMarkdown",
            module = "render-markdown.integ.blink",
            fallbacks = { "lsp" },
          },
        },
      },
    },
  },

  {
    "dhruvinsh/mdserver.nvim",
    build = "build.lua",
    cmd = "MdServer",
    keys = {
      { "<leader>cm", "<cmd>MdServer open<cr>", desc = "markdown project server" },
      { "<leader>cM", "<cmd>MdServer open!<cr>", desc = "markdown project server (network)" },
    },
    opts = {},
  },

  {
    "ellisonleao/glow.nvim",
    cmd = "Glow",
    opts = {},
  },
}
