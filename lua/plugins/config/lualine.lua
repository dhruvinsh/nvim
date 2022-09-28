local status_ok, lualine = pcall(require, "lualine")

if status_ok then
  lualine.setup({
    options = {
      icons_enabled = false,
      theme = "auto",
      component_separators = "|",
      section_separators = "",
    },
  })
end
