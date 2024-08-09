return {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufReadPost",
  main = "ibl",
  opts = function()
    local u = require("utils")
    return {
      indent = {
        char = "│",
      },
      scope = { enabled = false },
      exclude = {
        filetypes = u.no_indent_filetypes,
      },
    }
  end
}
