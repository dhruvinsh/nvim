local color_schemes = {
  ["rose-pine"] = function()
    require("rose-pine").setup({
      disable_italics = true,
      highlight_groups = {
        Comment = { italic = true },
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
