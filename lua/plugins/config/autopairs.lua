local status_ok, autopairs = pcall(require, "nvim-autopairs")

if status_ok then
  autopairs.setup({})
end
