return {
  "nvim-treesitter/nvim-treesitter",
  version = false,
  build = ":TSUpdate",
  event = "VeryLazy",
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  opts = {
    ensure_installed = {
      "bash",
      "c",
      "devicetree",
      "diff",
      "dockerfile",
      "git_config",
      "git_rebase",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "jsonc",
      "kdl",
      "lua",
      "luadoc",
      "luap",
      "make",
      "markdown",
      "markdown_inline",
      "ninja",
      "powershell",
      "python",
      "query",
      "regex",
      "rst",
      "rust",
      "ssh_config",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
    },
    sync_install = false,
    auto_instalm = true,
    --------------------------------
    -- Modules
    --------------------------------
    indent = { enable = true },
    highlight = {
      enable = true,
      disable = function(lang, bufnr)
        -- for some language irrelevant of file size I want treesitter.
        local allowed_lang = { "vimdoc" }
        if vim.tbl_contains(allowed_lang, lang) then
          return false
        end

        local u = require("utils")
        if u.is_big_buffer(bufnr) then
          return true
        end
      end,
      additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
