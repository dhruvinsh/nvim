return {
  "navarasu/onedark.nvim",
  priority = 1000,
  config = function()
    require("onedark").setup({
      colors = {
        bg0 = "#16161D",
      },
    })
    require("onedark").load()
  end,
}
