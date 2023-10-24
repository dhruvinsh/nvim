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
