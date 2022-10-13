local M = {}
local util = require("orion.core.util")

M.core = {
  n = {
    ["<Space>"] = { "<Nop>" },
    ["j"] = { "v:count == 0 ? 'gj' : 'j'", "", { expr = true } },
    ["k"] = { "v:count == 0 ? 'gk' : 'k'", "", { expr = true } },
  },
  v = {
    ["<Space>"] = { "<Nop>" },
  },
}

M.autosave = {
  n = {
    ["<F3>"] = { ":ASToggle <CR>", "autosave toggle" },
  },
}

-- Buffer managment keymaps
M.buffer = {
  n = {
    ["<S-Tab>"] = { ":bp <CR>", "Pext Buffer" },
    ["<Tab>"] = { ":bn <CR>", "Next Buffer" },
    ["<leader>bd"] = { ":Bdelete <CR>", "Pext Buffer" },
    ["<leader>bn"] = { ":bn <CR>", "Next Buffer" },
    ["<leader>bp"] = { ":bp <CR>", "Pext Buffer" },
  },
}

-- dial.nvim keymap
M.dial = {
  n = {
    ["<C-a>"] = { util.lazy_required_fn("dial.map", "inc_normal"), "Dial Increament" },
    ["<C-x>"] = { util.lazy_required_fn("dial.map", "dec_normal"), "Dial Decrement" },
  },
  v = {
    ["<C-a>"] = { util.lazy_required_fn("dial.map", "inc_visual"), "Dial Increament" },
    ["<C-x>"] = { util.lazy_required_fn("dial.map", "dec_visual"), "Dial Decrement" },
    ["g<C-a>"] = { util.lazy_required_fn("dial.map", "inc_gvisual"), "Dial Increament" },
    ["g<C-x>"] = { util.lazy_required_fn("dial.map", "dec_gvisual"), "Dial Decrement" },
  },
}

-- Git keymaps
M.git = {
  n = {
    ["<leader>gg"] = { ":Neogit <CR>", "Git Status" },
    ["<leader>gn"] = { ":Gitsigns next_hunk <CR>", "Next Hunk" },
    ["<leader>gp"] = { ":Gitsigns prev_hunk <CR>", "Previous Hunk" },
  },
}

-- Move keymaps
M.move = {
  n = {
    ["<A-h>"] = { ":MoveHChar(-1) <CR>", "Move text left" },
    ["<A-j>"] = { ":MoveLine(1) <CR>", "Move text down" },
    ["<A-k>"] = { ":MoveLine(-1) <CR>", "Move text up" },
    ["<A- l>"] = { ":MoveHChar(1) <CR>", "Move text right" },
  },
  v = {
    ["<A-h>"] = { ":MoveHBlock(-1) <CR>", "Move text left" },
    ["<A-j>"] = { ":MoveBlock(1) <CR>", "Move text down" },
    ["<A-k>"] = { ":MoveBlock(-1) <CR>", "Move text up" },
    ["<A- l>"] = { ":MoveHBlock(1) <CR>", "Move text right" },
  },
}

-- Neogen keymaps
M.neogen = {
  n = {
    ["<leader>nf"] = { ":Neogen func <CR>", "Func Doc" },
    ["<leader>nc"] = { ":Neogen class <CR>", "Class Doc" },
  },
  i = {
    ["<C-l>"] = { require("neogen").jump_next },
    ["<C-h>"] = { require("neogen").jump_prev },
  },
}

-- NvimTree setup
M.nvimtree = {
  n = {
    ["<leader>fe"] = { ":NvimTreeFocus <CR>", "Focus Nvim-tree" },
    ["<leader>ft"] = { ":NvimTreeToggle <CR>", "Open Nvim-tree" },
    ["<leader>pt"] = { ":NvimTreeToggle <CR>", "Open Nvim-tree" },
    ["<F9>"] = { ":NvimTreeToggle <CR>", "Open Nvim-tree" },
  },
}

-- Packer keymaps
M.packer = {
  n = {
    ["<leader>PS"] = { ":PackerStatus <CR>", "Status" },
    ["<leader>Pc"] = { ":PackerCompile <CR>", "Compile" },
    ["<leader>Pi"] = { ":PackerInstall <CR>", "Install" },
    ["<leader>Pu"] = { ":PackerUpdate <CR>", "Update" },
  },
}

-- Project keymaps
M.project = {
  n = {
    ["<leader>pp"] = { ":Telescope projects <CR>", "Projects" },
  },
}

-- Telescope keymaps
M.telescope = {
  n = {
    ["<leader><leader>"] = { ":Telescope frecency workspace=CWD <CR>", "Find Files (frecency)" },
    ["<leader>fr"] = { ":Telescope frecency <CR>", "Recent Files" },
    ["<leader>'"] = { ":Telescope current_buffer_fuzzy_find winblend=10, previewer=false", "Search in buffer" },
    ["<leader>bb"] = { ":Telescope buffers <CR>", "Find existing buffers" },
    ["<leader>/"] = { ":Telescope live_grep <CR>", "Live Grep" },

    ["<leader>fa"] = {
      ":Telescope find_files follow=true, no_ignore=true, hidden=true <CR>",
      "All Files",
    },
    ["<leader>fd"] = { ":Telescope diagnostics <CR>", "Find Diagnostics" },
    ["<leader>ff"] = { ":Telescope find_files <CR>", "Find Files" },
    ["<leader>fw"] = { ":Telescope grep_string <CR>", "Find Word" },
    ["<leader>sh"] = { ":Telescope help_tags <CR>", "Help" },
  },
}

-- Terminal mappings
M.terminal = {
  n = {
    ["<leader>ot"] = { ":ToggleTerm <CR>", "Open Terminal" },
  },
  t = {
    ["<ESC>"] = { "<C-\\><C-n>" },
    ["<C-w>h"] = { "<C-\\><C-n><C-W>h" },
    ["<C-w>j"] = { "<C-\\><C-n><C-W>j" },
    ["<C-w>k"] = { "<C-\\><C-n><C-W>k" },
    ["<C-w>l"] = { "<C-\\><C-n><C-W>l" },
  },
}

-- Truezen keymaps
M.truzen = {
  n = {
    ["<leader>fz"] = { ":TZAtaraxis <CR>", "Zen Mode" },
    ["<leader>za"] = { ":TZAtaraxis <CR>", "Ataraxis Mode" },
    ["<leader>zf"] = { ":TZFocus <CR>", "File Focus" },
    ["<leader>zm"] = { ":TZMinimalist <CR>", "Minimal Mode" },
    ["<leader>zn"] = { ":TZNarrow <CR>", "Narrow Mode" },
  },
}

-- lets register all the keymaps
util.build_keymap(M)
