if vim.g.colorscheme == "catppuccin" then
  vim.g.catppuccin_flavour = "frappe"
  require("catppuccin").setup()
  vim.cmd([[ colorscheme catppuccin ]])
elseif vim.g.colorscheme == "onedark" then
  require("onedark").load()
elseif vim.g.colorscheme == "gruvbox" then
  vim.o.background = "dark"
  vim.cmd([[ colorscheme gruvbox ]])
elseif vim.g.colorscheme == "nord" then
  vim.cmd([[ colorscheme nord]])
end
