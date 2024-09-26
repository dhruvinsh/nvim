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
    {"<leader>fg",      "<cmd>FzfLua git_files<cr>",                                                    desc = "git files"},
    {"<leader>ff",      "<cmd>FzfLua files<cr>",                                                        desc = "files"},
    {"<leader>fp",      "<cmd>FzfLua files cwd=" .. require("lazy.core.config").options.root .. "<cr>", desc = "files"},
    {"<leader>sh",      "<cmd>FzfLua helptags<cr>",                                                     desc = "help"},
    {"<leader>sk",      "<cmd>FzfLua keymaps<cr>",                                                      desc = "keymaps"},
    -- stylua: ignore end
  },
  opts = {
    files = {
      prompt = "F❯ ",
      cwd_prompt = false,
      formatter = "path.filename_first",
    },
  },
  config = function(_, opts)
    require("fzf-lua").setup(opts)
  end,
}
