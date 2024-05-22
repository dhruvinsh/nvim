return {
  "navarasu/onedark.nvim",
  priority = 1000,
  config = function()
    require("onedark").setup({
      colors = {
        bg0 = "#16161D",
      },
      highlights = {
        ["illuminatedWord"] = { bg = "$bg2", fmt = "bold" },
        ["illuminatedCurWord"] = { bg = "$bg2", fmt = "bold" },
        ["IlluminatedWordText"] = { bg = "$bg2", fmt = "bold" },
        ["IlluminatedWordRead"] = { bg = "$bg2", fmt = "bold" },
        ["IlluminatedWordWrite"] = { bg = "$bg2", fmt = "bold" },
      },
    })
    require("onedark").load()
  end,
}
