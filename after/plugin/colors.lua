local colors = {
  ["rose-pine"] = function()
    vim.notify("Setting up rose-pine")
    require("rose-pine").setup({
      disable_italics = true,
      highlight_groups = {
        Comment = { italic = true },
      },
    })
  end,
  ["onedark"] = function()
    vim.notify("Setting up onedark")
    require("onedark").setup({
      style = "warmer",
    })
  end,
}

local function SetColorscheme(scheme)
  local scheme_fn = colors[scheme]
  if scheme == nil or scheme_fn == nil then
    vim.notify("no valid scheme found, setting up habamax", vim.log.levels.ERROR)
    scheme = "habamax"
  else
    scheme_fn()
  end
  vim.cmd.colorscheme(scheme)
end

SetColorscheme(vim.g.orion_color_scheme)
