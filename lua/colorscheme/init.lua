local name = "catppuccin"

-- Check for colorscheme configuration, if available or not
pcall(require, "colorscheme.config." .. name)

-- Check if the colorscheme is found
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. name)
if not status_ok then
  return
end
