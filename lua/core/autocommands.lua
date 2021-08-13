-- Add spellchecking
vim.cmd([[ autocmd FileType gitcommit setlocal spell ]])
vim.cmd([[ autocmd FileType markdown setlocal spell ]])

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)

--Disable numbers in terminal mode
vim.api.nvim_exec(
  [[
  augroup Terminal
    autocmd!
    au TermOpen * set nonu
  augroup end
]],
  false
)
