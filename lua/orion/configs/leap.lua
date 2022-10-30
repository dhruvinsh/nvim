local status_ok, leap = pcall(require, "leap")

if status_ok then
  vim.api.nvim_set_hl(0, "LeapBackdrop", { fg = "#707070" })
  leap.set_default_keymaps()
end

-- Experimental Plugin Config
local spooky_status_ok, spooky = pcall(require, "leap-spooky")

if not spooky_status_ok then
  return
end

spooky.add_spooky_mappings({})
