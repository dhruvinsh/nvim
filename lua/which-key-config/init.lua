local opts = {
      mode = "n", -- NORMAL mode
      prefix = "<leader>",
      buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true, -- use `nowait` when creating keymaps
    }

local vopts = {
  mode = "v", -- VISUAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local vmappings = {
      ["/"] = { ":Commentary<CR>", "Comment" },
}

local mappings = {
  ["/"] = { "<cmd>Commentary<CR>", "Comment" },
  ["h"] = { '<cmd>let @/=""<CR>', "No Highlight" },
  f = {
    name = "Files",
    b = { "<cmd>Telescope buffers<CR>", "Find Buffers" },
    f = { "<cmd>Telescope find_files<CR>", "Find Files" },
    g = { "<cmd>Telescope live_grep<CR>", "Live Grep" },
    h = { "<cmd>Telescope help_tags<CR>", "Help Tags" },
    s = { "<cmd>w!<CR>", "Save" },
    t = { "<cmd>NvimTreeToggle<CR>", "Toggle Explorer" },
    z = { "<cmd>ZenMode<CR>", "Zen Mode" },
  },
  g = {
    name = "Git",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    n = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    p = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    C = {
      "<cmd>Telescope git_bcommits<cr>",
      "Checkout commit(for current file)",
    },
    P = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
  },
  q = {
    name = "Quite",
    q = { "<cmd>qa<CR>", "Exit" },
    w = { "<cmd>wa<CR><cmd>qa<CR>", "Save and Exit" },
    Q = { "<cmd>qa!<CR>", "Exit without saving" },
  },
  s = {
    name = "Search",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    t = { "<cmd>Telescope live_grep<cr>", "Text" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
  },
  P = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },
  S = {
    name = "Session",
    l = { "<cmd>SessionLoad<cr>", "Load" },
    s = { "<cmd>SessionSave<cr>", "Save" },
  },
  T = {
    name = "Treesitter",
    i = { ":TSConfigInfo<cr>", "Info" },
  },
}

local majormappings = {
  m = {
    name = "Major",
    l = { "<cmd>lua require('lint').try_lint()<CR>", "nvim-lint"},
  },
}

-- setup
local wk = require "which-key"
wk.setup()
wk.register(mappings, opts)
wk.register(vmappings, vopts)
