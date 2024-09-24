return {
  {
    "folke/tokyonight.nvim",
    opts = { style = "moon" },
  },

  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    opts = {
      italic = {
        strings = false,
      },
    },
  },

  {
    "navarasu/onedark.nvim",
    lazy = true,
    config = function()
      require("onedark").setup({
        colors = {
          -- schemer-dark color scheme
          -- base00 = "#16161D",
          -- base01 = "#3e4451",
          -- base02 = "#2c313c",
          -- base03 = "#565c64",
          -- base04 = "#6c7891",
          -- base05 = "#abb2bf",
          -- base06 = "#9a9bb3",
          -- base07 = "#c5c8e6",
          -- base08 = "#e06c75",
          -- base09 = "#d19a66",
          -- base0A = "#e5c07b",
          -- base0B = "#98c379",
          -- base0C = "#56b6c2",
          -- base0D = "#0184bc",
          -- base0E = "#c678dd",
          -- base0F = "#a06949",
          bg0 = "#16161D",
          blue = "#0184bc",
        },
        highlights = {
          illuminatedWord = { bg = "$bg2", fmt = "bold" },
          illuminatedCurWord = { bg = "$bg2", fmt = "bold" },
          IlluminatedWordText = { bg = "$bg2", fmt = "bold" },
          IlluminatedWordRead = { bg = "$bg2", fmt = "bold" },
          IlluminatedWordWrite = { bg = "$bg2", fmt = "bold" },

          TelescopePromptTitle = { bg = "$dark_cyan", fg = "white", fmt = "bold" },
          TelescopeResultsTitle = { bg = "$dark_purple", fg = "white", fmt = "bold" },
          TelescopePreviewTitle = { bg = "$dark_red", fg = "white", fmt = "bold" },
        },
      })
    end,
  },
}
