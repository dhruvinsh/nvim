return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "LspAttach",
  priority = 1000,
  keys = {
    {
      "gK",
      function()
        local new_config = not vim.diagnostic.config().virtual_lines
        vim.diagnostic.config({ virtual_lines = new_config })
      end,
      desc = "Toggle diagnostic virtual_lines",
    },
  },
  config = function()
    require("tiny-inline-diagnostic").setup()
    vim.diagnostic.config({ virtual_text = false })
  end,
}
