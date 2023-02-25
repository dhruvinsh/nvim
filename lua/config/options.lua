-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

if vim.fn.executable("volta") then
  vim.g.node_host_prog = vim.trim(vim.fn.execute("volta which neovim-node-host"))
end
