local M = {}

--- build whichkey compatible keymap from group of keymaps
---@param maps table
M.build_keymap = function(maps)
  local KEYMAP = {}

  for group, keymaps in pairs(maps) do
    -- work on actual keymap, unlike aerial keymaps, see mappings.lua
    if not vim.is_callable(keymaps) then
      for mode, keymap in pairs(keymaps) do
        local keys = vim.tbl_keys(KEYMAP)
        if not vim.tbl_contains(keys, mode) then
          KEYMAP[mode] = {}
        end

        KEYMAP[mode] = vim.tbl_deep_extend("keep", KEYMAP[mode], keymap)
      end
    end
  end

  return KEYMAP
end

return M
