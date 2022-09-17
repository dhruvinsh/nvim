local M = {}

M.telescope = {
  defaults = {
    file_ignore_patterns = { "^node_modules$", "^.git" },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
    },
  },
}

M.treesitter = {
  highlight = {
    additional_vim_regex_highlighting = { "org" },
  },
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
    "org",
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
  view = {
    -- specially working with python file nvimtree keep resizing
    adaptive_size = false,
  },
  filters = {
    custom = {
      "^.git$",
      "^.mypy_cache$",
      "^__pycache__$",
    },
  },
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

M.statusline = {
  statusline = {
    -- https://github.com/NvChad/ui/blob/main/lua/nvchad_ui/statusline/init.lua#L8
    -- overriden_modules need to be a function that returns the one of the
    -- modified modules. original modules are:
    --            mode
    --            fileInfo
    --            git
    --            LSP_progress
    --            LSP_Diagnostics
    --            cwd
    --            cursor_position
    overriden_modules = function()
      return {
        cursor_position = function()
          local st_modules = require("nvchad_ui.statusline.modules")
          local line, col = unpack(vim.api.nvim_win_get_cursor(0))

          -- lets store the cursor_position modules so that new data can be
          -- append to it.
          local cp = st_modules.cursor_position()

          -- need to increament col by 1 since its zero based
          return cp .. line .. ":" .. (col + 1)
        end,
      }
    end,
  },
}

return M
