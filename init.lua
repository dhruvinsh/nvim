-- impatient
local impatient_ok, impatient = pcall(require, "impatient")
if impatient_ok then
  impatient.enable_profile()
end

require("core.options")
require("core.autocmds")
require("core.mappings")

-- Main config starts here
-- Install packer
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- Bootstrapping the neovim
if fn.empty(fn.glob(install_path)) > 0 then
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e222a" })
  fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })

  -- installing plugins
  vim.cmd([[packadd packer.nvim]])
  require("plugins")
  vim.cmd("PackerSync")
end

-- FIX: better theme selection required
-- colorschem setup
-- valid vlaues: onedark, catppuccin, gruvbox, nord
vim.g.colorscheme = "catppuccin"
require("core.ui")
