return {
  "akinsho/toggleterm.nvim",
  cmd = "ToggleTerm",
  keys = {
    { "<leader>ft", "<cmd>ToggleTerm<cr>", desc = "terminal" },
  },
  ---@type ToggleTermConfig
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = [[<c-t>]],
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    shade_terminals = false,
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
    persist_size = true,
    direction = "horizontal" or "vertical" or "window" or "float",
    close_on_exit = true, -- close the terminal window when the process exits
    auto_scroll = false,
  },
}
