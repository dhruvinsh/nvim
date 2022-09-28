-- disable some built-in plugins
-- reference: https://github.com/mrjones2014/dotfiles/blob/master/.config/nvim/lua/disable-builtins.lua
local built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit",
}

vim.tbl_map(function(plugin)
  vim.g["loaded_" .. plugin] = 1
end, built_ins)
