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

    disable = function(lang, buf)
      -- for some language irrelevant of file size I want treesitter.
      local ignore_lang = { "vimdoc" }
      if vim.tbl_contains(ignore_lang, lang) then
        return false
      end

      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        vim.notify("Disabling treesitter")
        return true
      end
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

if vim.fn.has("nvim-0.10") == 1 then
  -- lets make sure treesitter is installed and then foldmethod get set
  vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.opt.foldlevel = 99
  vim.opt.foldmethod = "expr"
  vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"
end
