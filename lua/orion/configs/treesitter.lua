local status_ok, tconfig = pcall(require, "nvim-treesitter.configs")

if status_ok then
  tconfig.setup({
    ensure_installed = {
      "bash",
      "c",
      "cpp",
      "dockerfile",
      "gitattributes",
      "gitignore",
      "go",
      "html",
      "javascript",
      "json",
      "lua",
      "markdown",
      "org",
      "python",
      "query",
      "rust",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "yaml",
    },
    highlight = { enable = true, additional_vim_regex_highlighting = { "org" } },
    indent = { enable = true, disable = { "python", "yaml" } },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<c-space>",
        node_incremental = "<c-space>",
        -- TODO: I'm not sure for this one.
        scope_incremental = "<c-s>",
        node_decremental = "<c-backspace>",
      },
    },
  })
end
