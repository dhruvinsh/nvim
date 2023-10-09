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
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        vim.notify("Disabling treesitter")
        return true
      end
    end,

    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-Space>",
      node_incremental = "<C-Space>",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true,
  },
})
