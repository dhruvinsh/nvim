local M = {}

-- global disable keymaps
M.disable = {
  n = {
    ["<leader>b"] = "", -- unmap create buffer
  }
}

-- nvimtree keymaps
M.nvimtree = {
  n = {
    ["<leader>ft"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },
  },
}

-- git keymaps
M.neogit = {
  n = {
    -- git keymaps
    ["<leader>gg"] = { "<cmd>Neogit <CR>", "Neogit"},
  },
}

-- buffer managment
M.buffer = {
  n = {
    ["<leader>bb"] = { "", "buffers" },
    ["<leader>bc"] = { "<cmd> enew <CR>", "new buffer" },
    ["<leader>bd"] = { [[ rquire("core.utils").close_buffer() ]], "close buffer" },
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

return M
