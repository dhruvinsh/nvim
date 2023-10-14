local utils = require("utils")

---@diagnostic disable-next-line
require("nvim-treesitter.configs").setup({
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = {
    "bash",
    "c",
    "devicetree",
    "diff",
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
      return utils.is_big_buffer(bufnr)
    end,

    additional_vim_regex_highlighting = false,
  },
  -- disabling in favor of flash.nvim
  incremental_selection = {
    enable = false,
  },
  indent = {
    enable = true,
  },
})

vim.api.nvim_create_autocmd("BufReadPre", {
  group = utils.augroup("disable_folding"),
  callback = function(ev)
    -- work only with nvim-0.10
    if vim.fn.has("nvim-0.10") ~= 1 then
      return
    end

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
