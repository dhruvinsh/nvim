local color_schemes = {
  ["rose-pine"] = function()
    require("rose-pine").setup({
      extend_background_behind_borders = false,
      dim_inactive_windows = true,
      styles = { italic = false },
      highlight_groups = {
        Comment = { italic = true },

        -- from catppuccin
        ["@lsp.type.unresolvedReference"] = { link = "@error" },
        ["@lsp.typemod.type.defaultLibrary"] = { link = "@type.builtin" },

        -- from bamboo
        ["@lsp.typemod.typeAlias.defaultLibrary"] = { link = "@type.builtin" },

        -- not using from tokyonight
        -- ["@lsp.type.interface"] = { fg = util.lighten(c.blue1, 0.7) },
        -- ["@lsp.typemod.type.defaultLibrary"] = { fg = util.darken(c.blue1, 0.8) },
        -- ["@lsp.typemod.typeAlias.defaultLibrary"] = { fg = util.darken(c.blue1, 0.8) },

        ["@lsp.type.boolean"] = { link = "@boolean" },
        ["@lsp.type.builtinType"] = { link = "@type.builtin" },
        ["@lsp.type.comment"] = { link = "@comment" },
        ["@lsp.type.decorator"] = { link = "@attribute" },
        ["@lsp.type.deriveHelper"] = { link = "@attribute" },
        ["@lsp.type.enum"] = { link = "@type" },
        ["@lsp.type.enumMember"] = { link = "@constant" },
        ["@lsp.type.escapeSequence"] = { link = "@string.escape" },
        ["@lsp.type.formatSpecifier"] = { link = "@markup.list" },
        ["@lsp.type.generic"] = { link = "@variable" },
        ["@lsp.type.keyword"] = { link = "@keyword" },
        ["@lsp.type.lifetime"] = { link = "@keyword.storage" },
        ["@lsp.type.namespace"] = { link = "@module" },
        ["@lsp.type.number"] = { link = "@number" },
        ["@lsp.type.operator"] = { link = "@operator" },
        ["@lsp.type.parameter"] = { link = "@variable.parameter" },
        ["@lsp.type.property"] = { link = "@property" },
        ["@lsp.type.selfKeyword"] = { link = "@variable.builtin" },
        ["@lsp.type.selfTypeKeyword"] = { link = "@variable.builtin" },
        ["@lsp.type.string"] = { link = "@string" },
        ["@lsp.type.typeAlias"] = { link = "@type.definition" },
        ["@lsp.type.variable"] = {}, -- use treesitter styles for regular variables
        ["@lsp.typemod.class.defaultLibrary"] = { link = "@type.builtin" },
        ["@lsp.typemod.enum.defaultLibrary"] = { link = "@type.builtin" },
        ["@lsp.typemod.enumMember.defaultLibrary"] = { link = "@constant.builtin" },
        ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
        ["@lsp.typemod.keyword.async"] = { link = "@keyword.coroutine" },
        ["@lsp.typemod.keyword.injected"] = { link = "@keyword" },
        ["@lsp.typemod.macro.defaultLibrary"] = { link = "@function.builtin" },
        ["@lsp.typemod.method.defaultLibrary"] = { link = "@function.builtin" },
        ["@lsp.typemod.operator.injected"] = { link = "@operator" },
        ["@lsp.typemod.string.injected"] = { link = "@string" },
        ["@lsp.typemod.struct.defaultLibrary"] = { link = "@type.builtin" },
        ["@lsp.typemod.variable.callable"] = { link = "@function" },
        ["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },
        ["@lsp.typemod.variable.injected"] = { link = "@variable" },
        ["@lsp.typemod.variable.static"] = { link = "@constant" },
        -- NOTE: maybe add these with distinct highlights?
        -- ["@lsp.typemod.variable.globalScope"] (global variables)

        -- Python
        ["@lsp.type.namespace.python"] = { link = "@variable" },
      },
    })
  end,
  ["onedark"] = function()
    require("onedark").setup({
      style = "warmer",
    })
  end,
  ["catppuccin"] = function()
    require("catppuccin").setup({
      flavour = "mocha",
      integrations = {
        cmp = true,
        dashboard = true,
        fidget = true,
        flash = true,
        gitsigns = true,
        illuminate = true,
        lsp_trouble = true,
        mason = true,
        mini = { enabled = true, indentscope_color = "" },
        neotree = true,
        notify = true,
        telescope = { enabled = true, style = "nvchad" },
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    })
  end,
}

---A global function that allow to set color scheme
---@param scheme? string or it uses vim.g.orion_color_scheme
function SetColorscheme(scheme)
  local color_scheme = scheme or vim.g.orion_color_scheme
  local scheme_fn = color_schemes[color_scheme]

  if scheme_fn == nil then
    vim.notify("no valid scheme found, setting up habamax", vim.log.levels.ERROR)
    color_scheme = "habamax"
  else
    vim.notify("Setting up " .. color_scheme)
    scheme_fn()
  end

  vim.cmd.colorscheme(color_scheme)
end

SetColorscheme()
