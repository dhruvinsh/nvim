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
    -- some external plugins config for treesitter
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
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
end
