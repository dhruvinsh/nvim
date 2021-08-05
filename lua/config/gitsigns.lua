require("gitsigns").setup({
  signs = {
    add = { hl = "GitSignsAdd", text = "▍", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = {
      hl = "GitSignsChange",
      text = "▍",
      numhl = "GitSignsChangeNr",
      linehl = "GitSignsChangeLn",
    },
    delete = {
      hl = "GitSignsDelete",
      text = "▸",
      numhl = "GitSignsDeleteNr",
      linehl = "GitSignsDeleteLn",
    },
    topdelete = {
      hl = "GitSignsDelete",
      text = "▾",
      numhl = "GitSignsDeleteNr",
      linehl = "GitSignsDeleteLn",
    },
    changedelete = {
      hl = "GitSignsChange",
      text = "▍",
      numhl = "GitSignsChangeNr",
      linehl = "GitSignsChangeLn",
    },
  },
  keymaps = {
    -- Default keymap options
    noremap = true,
    buffer = true,
    ["n ]c"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<cr>'" },
    ["n [c"] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<cr>'" },
    ["n <leader>ghs"] = '<cmd>lua require"gitsigns".stage_hunk()<cr>',
    ['v <leader>ghs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<cr>',
    ["n <leader>ghu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<cr>',
    ["n <leader>ghr"] = '<cmd>lua require"gitsigns".reset_hunk()<cr>',
    ['v <leader>ghr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<cr>',
    ["n <leader>ghR"] = '<cmd>lua require"gitsigns".reset_buffer()<cr>',
    ["n <leader>ghp"] = '<cmd>lua require"gitsigns".preview_hunk()<cr>',
    ["n <leader>ghb"] = '<cmd>lua require"gitsigns".blame_line()<cr>',
    -- Text objects
    ["o ih"] = ':<C-U>lua require"gitsigns".select_hunk()<cr>',
    ["x ih"] = ':<C-U>lua require"gitsigns".select_hunk()<cr>',
  },
})
