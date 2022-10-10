" in ~/after/ftplugin/json.vim

" show json path in the winbar
if exists('+winbar')
  setlocal winbar=%{luaeval('require\"jsonpath\".get()')}
endif

" send json path to clipboard
nnoremap <buffer> y<C-p> :let @+=luaeval('require"jsonpath".get()')<CR>
