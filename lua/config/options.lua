-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local utils = require("utils")

-- setup volta
if vim.fn.executable("volta") then
  vim.g.node_host_prog = vim.fn.trim(vim.fn.system("volta which neovim-node-host"))
end

-- setup python
if utils.is_win then
  if vim.fn.executable("python") then
    vim.g.python3_host_prog = "python"
  end
-- on linux and mac os I use pyenv to manage python, soon to be `Rye`
elseif vim.fn.executable("pyenv") then
  local py_version = vim.fn.trim(vim.fn.system("pyenv global"))
  vim.g.python3_host_prog = "~/.pyenv/versions/" .. py_version .. "/bin/python3"
end
