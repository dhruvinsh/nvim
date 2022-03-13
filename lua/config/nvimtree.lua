require("nvim-tree").setup({
  auto_close = false,
  filters = {
    custom = {
      ".git",
      "node_modules",
      ".cache",
      "__pycache__",
      ".mypy_cache",
    },
  },
})
vim.g.nvim_tree_special_files = {}
vim.g.nvim_tree_icons = {
  default = " ",
  symlink = " ",
  git = {
    unstaged = "✚",
    staged = "✚",
    unmerged = "",
    renamed = "≫",
    untracked = "★",
    deleted = " ",
    ignored = "◌",
  },
}
