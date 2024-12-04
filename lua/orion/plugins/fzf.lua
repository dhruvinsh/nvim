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
  config = function()
    local act = require("fzf-lua.actions")

    require("fzf-lua").setup({
      files = {
        prompt = "F❯ ",
        cwd_prompt = false,
        formatter = "path.filename_first",
      },
      grep = {
        rg_opts = "--column --line-number --no-heading --color=always --smart-case --hidden --glob '!.git/**' --max-columns=4096 -e ",
        actions = {
          ["alt-q"] = {
            fn = act.file_edit_or_qf,
            prefix = "select-all+",
          },
        },
      },
    })
  end,
}
