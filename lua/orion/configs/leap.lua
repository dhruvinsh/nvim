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

spooky.setup({
    affixes = {
    -- These will generate mappings for all native text objects, like:
    -- (ir|ar|iR|aR|im|am|iM|aM){obj}.
    -- Special line objects will also be added, by repeating the affixes.
    -- E.g. `yrr<leap>` and `ymm<leap>` will yank a line in the current
    -- window.
    -- You can also use 'rest' & 'move' as mnemonics.
    remote   = { window = 'r', cross_window = 'R' },
    magnetic = { window = 'm', cross_window = 'M' },
  },
  -- If this option is set to true, the yanked text will automatically be pasted
  -- at the cursor position if the unnamed register is in use.
  paste_on_remote_yank = false,
})
