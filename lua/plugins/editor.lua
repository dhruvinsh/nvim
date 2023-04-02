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
}
