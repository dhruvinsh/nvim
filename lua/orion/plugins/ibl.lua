return {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufReadPost",
  main = "ibl",
  opts = function()
    local u = require("util")
    ---@module "ibl"
    ---@type ibl.config
    return {
      indent = {
        tab_char = " ",
        char = "│",
      },
      scope = { enabled = false },
      exclude = {
        filetypes = u.no_indent_filetypes,
      },
    }
  end,
}
