local compe = require("compe")

-- better completion
vim.o.completeopt = "menuone,noselect"

compe.setup {
  source = {
    path = true,
    nvim_lsp = true,
    luasnip = true,
    buffer = true,
    calc = false,
    nvim_lua = false,
    vsnip = false,
    ultisnips = false,
  },
}

-- Map compe confirm and complete functions
vim.api.nvim_set_keymap('i', '<c-space>', 'compe#complete()', { silent=true, expr = true })
vim.api.nvim_set_keymap('i', '<cr>', "compe#confirm('<cr>')", { silent=true, expr = true })
vim.api.nvim_set_keymap('i', '<C-e>', "compe#close('<C-e>')", { silent=true, expr = true })
