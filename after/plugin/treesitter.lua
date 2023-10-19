local utils = require("utils")

---@diagnostic disable-next-line
require("nvim-treesitter.configs").setup({
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = {
    "bash",
    "c",
    "devicetree",
    "diff",
    "dockerfile",
    "html",
    "javascript",
    "jsdoc",
    "json",
    "jsonc",
    "kdl",
    "lua",
    "luadoc",
    "luap",
    "markdown",
    "markdown_inline",
    "ninja",
    "python",
    "query",
    "regex",
    "rst",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  auto_install = true,

  --------------------------------
  -- Modules
  --------------------------------
  highlight = {
    enable = true,
    disable = function(lang, bufnr)
      -- for some language irrelevant of file size I want treesitter.
      local allowed_lang = { "vimdoc" }
      if vim.tbl_contains(allowed_lang, lang) then
        return false
      end
      if utils.is_big_buffer(bufnr) then
        vim.notify("Big File: disabling treesitter", vim.log.levels.WARN)
      end
    end,

    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    -- disabling in favor of flash.nvim
    enable = false,
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
  },
})

-- folding only with nvim-0.10
if vim.fn.has("nvim-0.10") == 1 then
  vim.api.nvim_create_autocmd("BufReadPre", {
    group = utils.augroup("big_file_disable", false),
    callback = function(ev)
      if utils.is_big_buffer(ev.buf) then
        -- fallback to default values
        vim.opt.foldmethod = "manual"
        vim.opt.foldexpr = "0"
        vim.opt.foldlevel = 0
        vim.opt.foldtext = "foldtext()"
      else
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.opt.foldlevel = 99
        vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"
      end
    end,
  })
end
