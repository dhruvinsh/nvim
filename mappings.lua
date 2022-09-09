local M = {}

M.nvimtree = {
  n = {
      ["<leader>ft"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },
  },
  t = {
    ["<Esc>"] = { [[<C-\><C-n>]] },
    ["<C-w>h"] = { [[<C-\><C-n><C-W>h]] },
    ["<C-w>j"] = { [[<C-\><C-n><C-W>j]] },
    ["<C-w>k"] = { [[<C-\><C-n><C-W>k]] },
    ["<C-w>l"] = { [[<C-\><C-n><C-W>l]] },
  },
}

return M
