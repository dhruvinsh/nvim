vim.g.nvim_tree_ignore = { ".git", "node_modules", ".cache" }
vim.g.nvim_tree_special_files = {}
vim.g.nvim_tree_auto_close = 1
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