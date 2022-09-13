local M = {}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- python
    "pyright",

    -- web dev
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "json-lsp",

    -- shell
    "shfmt",
    "shellcheck",
  },
}

M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
