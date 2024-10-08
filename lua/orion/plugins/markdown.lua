return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    version = "*",
    ft = "markdown",
    main = "render-markdown",
    opts = {},
    name = "render-markdown",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function(plugin)
      vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install")
    end,
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_open_to_the_world = 1
      vim.g.mkdp_echo_preview_url = 1
    end,
  },

  {
    "ellisonleao/glow.nvim",
    opts = {},
    cmd = "Glow",
  },
}
