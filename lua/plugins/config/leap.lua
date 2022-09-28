local status_ok, leap = pcall(require, "leap")

if status_ok then
  leap.set_default_keymaps()
end
