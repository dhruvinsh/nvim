return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  dependencies = { "echasnovski/mini.icons" },
  keys = {
    -- stylua: ignore start
    {"<leader>/",       "<cmd>FzfLua live_grep<cr>",                                                    desc = "grep"},
    {"<leader><space>", "<cmd>FzfLua files<cr>",                                                        desc = "files"},
    {"<leader>fb",      "<cmd>FzfLua buffers<cr>",                                                      desc = "buffers"},
    {"<leader>fc",      "<cmd>FzfLua git_commits<cr>",                                                  desc = "commits"},
    {"<leader>ff",      "<cmd>FzfLua files<cr>",                                                        desc = "files"},
    {"<leader>fg",      "<cmd>FzfLua git_files<cr>",                                                    desc = "git files"},
    {"<leader>fp",      "<cmd>FzfLua files cwd=" .. require("lazy.core.config").options.root .. "<cr>", desc = "files"},
    {"<leader>sh",      "<cmd>FzfLua helptags<cr>",                                                     desc = "help"},
    {"<leader>sk",      "<cmd>FzfLua keymaps<cr>",                                                      desc = "keymaps"},
    {"<leader>sw",      "<cmd>FzfLua grep_cword<cr>",                                                   desc = "keymaps"},
    -- stylua: ignore end
  },
  opts = function()
    local config = require("fzf-lua.config")

    -- Quickfix
    -- stylua: ignore start
    config.defaults.keymap.fzf["ctrl-q"]    = "select-all+accept"
    config.defaults.keymap.fzf["ctrl-u"]    = "half-page-up"
    config.defaults.keymap.fzf["ctrl-d"]    = "half-page-down"
    config.defaults.keymap.fzf["ctrl-x"]    = "jump"
    config.defaults.keymap.fzf["ctrl-f"]    = "preview-page-down"
    config.defaults.keymap.fzf["ctrl-b"]    = "preview-page-up"
    config.defaults.keymap.builtin["<c-f>"] = "preview-page-down"
    config.defaults.keymap.builtin["<c-b>"] = "preview-page-up"
    -- stylua: ignore end

    ---@module "fzf-lua"
    ---@type fzf-lua.Config
    return {
      "default-title",
      fzf_colors = true,
      fzf_opts = {
        ["--no-scrollbar"] = true,
      },
      defaults = {
        formatter = "path.filename_first",
      },
      files = {
        prompt = " ",
        cwd_prompt = false,
      },
      grep = {
        rg_opts = "--column --line-number --no-heading --color=always --smart-case --hidden --glob '!.git/**' --max-columns=4096 -e ",
      },
    }
  end,
}
