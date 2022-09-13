local M = {}

M.treesitter = {
  ensure_installed = {
    "bash",
    "c",
    "c_sharp",
    "cmake",
    "comment",
    "cpp",
    "css",
    "dockerfile",
    "gitattributes",
    "gitignore",
    "html",
    "javascript",
    "jsdoc",
    "json",
    "lua",
    "make",
    "markdown",
    "python",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "yaml",
  },
}

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
