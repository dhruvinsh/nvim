require("nvim-tree").setup({
  auto_close = false,
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  filters = {
    dotfiles = false,
    custom = {
      ".git",
      "node_modules",
      ".cache",
      "__pycache__",
      ".mypy_cache",
    },
  },
  -- project.nvim setup
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true
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

-- from project.nvim
vim.g.nvimi_tree_respect_buf_cwd = 1
