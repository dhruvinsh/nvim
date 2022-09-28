local g = vim.g
local kmap = vim.keymap.set

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
g.mapleader = " "
g.maplocalleader = " "

kmap({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
kmap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
kmap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
