local util = require("util")
local compe = require("compe")
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

_G.auto_completion_close = function()
  if vim.fn.pumvisible() == 1 then
    return vim.fn['compe#close']('<C-e>')
  end
  return util.t '<ESC>'
end

-- Map compe confirm and complete functions
vim.api.nvim_set_keymap('i', '<c-space>', 'compe#complete()', { silent=true, expr = true })
vim.api.nvim_set_keymap('i', '<cr>', 'compe#confirm("<cr>")', { silent=true, expr = true })
vim.api.nvim_set_keymap('i', '<ESC>', "v:lua.auto_completion_close()", { silent=true, expr = true })
