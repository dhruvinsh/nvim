-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local utils = require("utils")

local augroup = function(name)
  return vim.api.nvim_create_augroup("orion_" .. name, { clear = true })
end

-- Closing unused buffer:
-- https://www.reddit.com/r/neovim/comments/12c4ad8/closing_unused_buffers/
vim.api.nvim_create_autocmd({ "BufRead" }, {
  group = augroup("unused_buffer"),
  pattern = { "*" },
  callback = function()
    vim.api.nvim_create_autocmd({ "InsertEnter", "BufModifiedSet" }, {
      buffer = 0,
      once = true,
      callback = function()
        utils.persistbuffer()
      end,
    })
  end,
})

-- clear exisitng wrap_spell and make new one
vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown", "NeogitCommitMessage" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})
