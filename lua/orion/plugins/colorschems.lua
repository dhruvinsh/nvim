return {
  {
    "RRethy/base16-nvim",
    config = function()
      require("base16-colorscheme").setup({
        base00 = "#181818",
        base01 = "#282828",
        base02 = "#383838",
        base03 = "#585858",
        base04 = "#b8b8b8",
        base05 = "#d8d8d8",
        base06 = "#e8e8e8",
        base07 = "#f8f8f8",
        base08 = "#ab4642",
        base09 = "#dc9656",
        base0A = "#f7ca88",
        base0B = "#a1b56c",
        base0C = "#86c1b9",
        base0D = "#7cafc2",
        base0E = "#ba8baf",
        base0F = "#a16946",
      })
    end,
  },
  -- {
  --   "echasnovski/mini.base16",
  --   config = function()
  --     require("mini.base16").setup({
  --       palette = {
  --         base00 = "#16161D",
  --         base01 = "#2c313c",
  --         base02 = "#3e4451",
  --         base03 = "#6c7891",
  --         base04 = "#565c64",
  --         base05 = "#abb2bf",
  --         base06 = "#9a9bb3",
  --         base07 = "#c5c8e6",
  --         base08 = "#e06c75",
  --         base09 = "#d19a66",
  --         base0A = "#e5c07b",
  --         base0B = "#98c379",
  --         base0C = "#56b6c2",
  --         base0D = "#0184bc",
  --         base0E = "#c678dd",
  --         base0F = "#a06949",
  --       },
  --     })
  --   end,
  -- },
  -- {
  --   "rose-pine/neovim",
  --   name = "rose-pine",
  --   config = true,
  --   opts = {
  --     extend_background_behind_borders = false,
  --     dim_inactive_windows = true,
  --     styles = { italic = false },
  --     highlight_groups = {
  --       Comment = { italic = true },
  --
  --       -- illuminate
  --       IlluminatedWordText = { link = "LspReferenceText" },
  --       IlluminatedWordRead = { link = "LspReferenceRead" },
  --       IlluminatedWordWrite = { link = "LspReferenceWrite" },
  --
  --       -- from catppuccin
  --       ["@lsp.type.unresolvedReference"] = { link = "@error" },
  --       ["@lsp.typemod.type.defaultLibrary"] = { link = "@type.builtin" },
  --
  --       -- from bamboo
  --       ["@lsp.typemod.typeAlias.defaultLibrary"] = { link = "@type.builtin" },
  --
  --       -- not using from tokyonight
  --       -- ["@lsp.type.interface"] = { fg = util.lighten(c.blue1, 0.7) },
  --       -- ["@lsp.typemod.type.defaultLibrary"] = { fg = util.darken(c.blue1, 0.8) },
  --       -- ["@lsp.typemod.typeAlias.defaultLibrary"] = { fg = util.darken(c.blue1, 0.8) },
  --
  --       ["@lsp.type.boolean"] = { link = "@boolean" },
  --       ["@lsp.type.builtinType"] = { link = "@type.builtin" },
  --       ["@lsp.type.comment"] = { link = "@comment" },
  --       ["@lsp.type.decorator"] = { link = "@attribute" },
  --       ["@lsp.type.deriveHelper"] = { link = "@attribute" },
  --       ["@lsp.type.enum"] = { link = "@type" },
  --       ["@lsp.type.enumMember"] = { link = "@constant" },
  --       ["@lsp.type.escapeSequence"] = { link = "@string.escape" },
  --       ["@lsp.type.formatSpecifier"] = { link = "@markup.list" },
  --       ["@lsp.type.generic"] = { link = "@variable" },
  --       ["@lsp.type.keyword"] = { link = "@keyword" },
  --       ["@lsp.type.lifetime"] = { link = "@keyword.storage" },
  --       ["@lsp.type.namespace"] = { link = "@module" },
  --       ["@lsp.type.number"] = { link = "@number" },
  --       ["@lsp.type.operator"] = { link = "@operator" },
  --       ["@lsp.type.parameter"] = { link = "@variable.parameter" },
  --       ["@lsp.type.property"] = { link = "@property" },
  --       ["@lsp.type.selfKeyword"] = { link = "@variable.builtin" },
  --       ["@lsp.type.selfTypeKeyword"] = { link = "@variable.builtin" },
  --       ["@lsp.type.string"] = { link = "@string" },
  --       ["@lsp.type.typeAlias"] = { link = "@type.definition" },
  --       ["@lsp.type.variable"] = {}, -- use treesitter styles for regular variables
  --       ["@lsp.typemod.class.defaultLibrary"] = { link = "@type.builtin" },
  --       ["@lsp.typemod.enum.defaultLibrary"] = { link = "@type.builtin" },
  --       ["@lsp.typemod.enumMember.defaultLibrary"] = { link = "@constant.builtin" },
  --       ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
  --       ["@lsp.typemod.keyword.async"] = { link = "@keyword.coroutine" },
  --       ["@lsp.typemod.keyword.injected"] = { link = "@keyword" },
  --       ["@lsp.typemod.macro.defaultLibrary"] = { link = "@function.builtin" },
  --       ["@lsp.typemod.method.defaultLibrary"] = { link = "@function.builtin" },
  --       ["@lsp.typemod.operator.injected"] = { link = "@operator" },
  --       ["@lsp.typemod.string.injected"] = { link = "@string" },
  --       ["@lsp.typemod.struct.defaultLibrary"] = { link = "@type.builtin" },
  --       ["@lsp.typemod.variable.callable"] = { link = "@function" },
  --       ["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },
  --       ["@lsp.typemod.variable.injected"] = { link = "@variable" },
  --       ["@lsp.typemod.variable.static"] = { link = "@constant" },
  --       -- NOTE: maybe add these with distinct highlights?
  --       -- ["@lsp.typemod.variable.globalScope"] (global variables)
  --
  --       -- Python
  --       ["@lsp.type.namespace.python"] = { link = "@variable" },
  --     },
  --   },
  -- },
  -- { "navarasu/onedark.nvim", config = true, opts = { style = "warmer" } },
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   config = true,
  --   opts = {
  --     flavour = "mocha",
  --     integrations = {
  --       cmp = true,
  --       dashboard = true,
  --       fidget = true,
  --       flash = true,
  --       gitsigns = true,
  --       illuminate = true,
  --       lsp_trouble = true,
  --       mason = true,
  --       mini = { enabled = true, indentscope_color = "" },
  --       neotree = true,
  --       notify = true,
  --       telescope = { enabled = true, style = "nvchad" },
  --       treesitter = true,
  --       treesitter_context = true,
  --       which_key = true,
  --     },
  --   },
  -- },
  -- { "sainnhe/gruvbox-material", config = function() vim.g.gruvbox_material_background = "hard" end },
  -- { "HoNamDuong/hybrid.nvim", priority = 1000, config = true, opts = {} },
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = true,
  --   opts = { style = "moon" },
  -- },
  -- { "phha/zenburn.nvim", config = true },
}
