return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      theme = "auto",
    },
    extensions = { "fugitive", "overseer" },
  },
  config = function(_, opts)
    require("lualine").setup(opts)
    require("util.lualine").inject_component({ "sections", "lualine_x" }, 1, require("util.commit").status_component)
  end,
}
