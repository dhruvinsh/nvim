local M = {}

--------------------------
-- global disable keymaps
--------------------------
M.disabled = {
  n = {
    ["<leader>b"] = "", -- unmap create buffer
    ["<leader>x"] = "", -- unmap delete buffer
  },
}

-- buffer managment
M.buffer = {
  n = {
    ["<leader>bb"] = { "", "buffers" },
    ["<leader>bc"] = { "<cmd> enew <CR>", "new buffer" },
    ["<leader>bd"] = {
      function()
        require("nvchad_ui.tabufline").close_buffer()
      end,
      "close buffer",
    },
  },
}

-- lsp, linting option
M.lsp = {
  n = {
    -- addition formatting keymap
    ["<leader>bf"] = {
      function()
        vim.lsp.buf.format({ async = true })
      end,
      "lsp format",
    },
  },
}

-- git keymaps
M.neogit = {
  n = {
    -- git keymaps
    ["<leader>gg"] = { "<cmd>Neogit <CR>", "Neogit" },
  },
}

-- nvimtree keymaps
M.nvimtree = {
  n = {
    ["<leader>ft"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },
  },
}

-- terminal managment
M.terminal = {
  t = {
    ["<Esc>"] = { [[<C-\><C-n>]] },
    ["<C-w>h"] = { [[<C-\><C-n><C-W>h]] },
    ["<C-w>j"] = { [[<C-\><C-n><C-W>j]] },
    ["<C-w>k"] = { [[<C-\><C-n><C-W>k]] },
    ["<C-w>l"] = { [[<C-\><C-n><C-W>l]] },
  },
}

M.truezen = {
  n = {
    ["<leader>fz"] = { "<cmd>TZFocus<CR>", "Zen mode" },
    ["<leader>za"] = { "<cmd>TZAtaraxis<CR>", "Ataraxis mode" },
    ["<leader>zf"] = { "<cmd>TZFocus<CR>", "File focus" },
    ["<leader>zm"] = { "<cmd>TZMinimalist<CR>", "Minimal mode" },
    ["<leader>zn"] = { "<cmd>TZNarrow<CR>", "Narrow mode" },
  },
  v = {
    ["<leader>zn"] = { "<cmd>'<,'>TZNarrow<CR>" },
  },
}

return M
