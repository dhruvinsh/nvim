local utils = require("utils")

---@return LazySpec
return {
  "RRethy/vim-illuminate",
  event = "InsertEnter",
  opts = {
    delay = 200,
    large_file_cutoff = utils.max_filesize,
    large_file_overrides = {
      providers = { "lsp" },
    },
  },
  config = function(_, opts)
    local illuminate = require("illuminate")
    illuminate.configure(opts)
    vim.keymap.set("n", "]r", function() illuminate.goto_next_reference(false) end, { desc = "Next reference" })
    vim.keymap.set("n", "[r", function() illuminate.goto_prev_reference(false) end, { desc = "Prev reference" })
  end,
}
