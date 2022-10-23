local status_ok, codewindow = pcall(require, "codewindow")

if not status_ok then
  return
end

codewindow.setup({
  active_in_terminals = false, -- Should the minimap activate for terminal buffers
  auto_enable = false, -- Automatically open the minimap when entering a (non-excluded) buffer (accepts a table of filetypes)
  exclude_filetypes = {
    "NvimTree",
    "TelescopePrompt",
    "alpha",
    "dirvish",
    "fugitive",
    "NeogitStatus",
    "NeogitCommitMessage",
    "packer",
    "toggleterm",
  }, -- Choose certain filetypes to not show minimap on
  max_minimap_height = nil, -- The maximum height the minimap can take (including borders)
  max_lines = nil, -- If auto_enable is true, don't open the minimap for buffers which have more than this many lines.
  minimap_width = 20, -- The width of the text part of the minimap
  use_lsp = true, -- Use the builtin LSP to show errors and warnings
  use_treesitter = true, -- Use nvim-treesitter to highlight the code
  width_multiplier = 4, -- How many characters one dot represents
  z_index = 1, -- The z-index the floating window will be on
  show_cursor = true, -- Show the cursor position in the minimap
  window_border = "single", -- The border style of the floating window (accepts all usual options)
})
