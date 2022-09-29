local status_ok, leap = pcall(require, "leap")

if status_ok then
  vim.api.nvim_set_hl(0, "LeapBackdrop", { fg = "#707070" })
  leap.set_default_keymaps()
end
