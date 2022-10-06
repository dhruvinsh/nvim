local M = {}

-- Labels for the whichkey
M.tags = {
  n = {
    ["<leader>b"] = { name = "buffer" },
    ["<leader>c"] = { name = "code" },
    ["<leader>f"] = { name = "file" },
    ["<leader>g"] = { name = "git" },
    ["<leader>n"] = { name = "neogen" },
    ["<leader>o"] = { name = "open" },
    ["<leader>P"] = { name = "packer" },
    ["<leader>p"] = { name = "project" },
    ["<leader>s"] = { name = "search" },
    ["<leader>z"] = { name = "zen" },
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

-- Git keymaps
M.git = {
  n = {
    ["<leader>gg"] = { ":Neogit <CR>", "Git Status" },
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
    ["<leader>nc"] = { ":Neogen class <CR>", "Func Doc" },
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
    ["<leader>pp"] = {
      function()
        require("telescope").extensions.projects.projects()
      end,
      "Projects",
    },
  },
}

-- Telescope keymaps
M.telescope = {
  n = {
    ["<leader><leader>"] = {
      function()
        require("telescope").extensions.frecency.frecency()
      end,
      "Rcent Files",
    },

    ["<leader>?"] = {
      ":Telescope oldfiles <CR>",
      "? Find recently opened files",
    },

    ["<leader>b/"] = {
      function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require("telescope.builtin").current_buffer_fuzzy_find(
          require("telescope.themes").get_dropdown({ winblend = 10, previewer = false })
        )
      end,
      "/ Fuzzily search in current buffer",
    },
    ["<leader>bb"] = { ":Telescope buffers <CR>", "Find existing buffers" },
    ["<leader>f/"] = { ":Telescope live_grep <CR>", "Live Grep" },

    ["<leader>fa"] = {
      ":Telescope find_files follow=true, no_ignore=true, hidden=true <CR>",
      "All Files",
    },
    ["<leader>fd"] = { ":Telescope diagnostics <CR>", "Find Diagnostics" },
    ["<leader>ff"] = { ":Telescope find_files <CR>", "Find Files" },
    ["<leader>fw"] = { ":Telescope grep_string <CR>", "Find Word" },
    ["<leader>sh"] = { ":Telescope help_tags <CR>", "Search Help" },
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

return M
