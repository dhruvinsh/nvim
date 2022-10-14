-- impatient
local impatient_ok, impatient = pcall(require, "impatient")
if impatient_ok then
  impatient.enable_profile()
end

require("orion.core.options")
require("orion.core.autocmds")
require("orion.core.mappings")

-- Main config starts here
-- Install packer
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- Bootstrapping the neovim
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })

  -- installing plugins
  vim.api.nvim_cmd({
    cmd = "packadd",
    args = { "packer.nvim" },
  }, {})
  require("orion.plugins")
  vim.api.nvim_cmd({ cmd = "PackerSync" }, {})
end

require("orion.colorscheme")
