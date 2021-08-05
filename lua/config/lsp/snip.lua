local util = require("util")

-- CREDITS: defaults.nvim, nvim-compe
-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
local luasnip = require("luasnip")
luasnip.config.set_config({
  history = true,
  -- Update more often, :h events for more info.
  updateevents = "TextChanged,TextChangedI",
})
require("luasnip/loaders/from_vscode").load()

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return util.t '<C-n>'
  elseif luasnip.expand_or_jumpable() then
    return util.t '<Plug>luasnip-expand-or-jump'
  elseif util.check_back_space() then
    return util.t '<Tab>'
  else
    return vim.fn['compe#complete']()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return util.t '<C-p>'
  elseif luasnip.jumpable(-1) then
    return util.t '<Plug>luasnip-jump-prev'
  else
    return util.t '<S-Tab>'
  end
end

-- Map tab to the above tab complete functiones
vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.tab_complete()', { expr = true })
vim.api.nvim_set_keymap('s', '<Tab>', 'v:lua.tab_complete()', { expr = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
vim.api.nvim_set_keymap('s', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
