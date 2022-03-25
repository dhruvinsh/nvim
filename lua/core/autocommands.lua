-- Add spellchecking
vim.api.nvim_exec(
  [[
  augroup spellCheck
      autocmd!
      autocmd FileType gitcommit,markdown,norg setlocal spell
  augroup END 
]],
  false
)

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
