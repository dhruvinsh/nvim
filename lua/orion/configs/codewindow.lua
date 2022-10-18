local status_ok, codewindow = pcall(require, "codewindow")

if not status_ok then
  return
end

codewindow.setup()
codewindow.apply_default_keybinds()
