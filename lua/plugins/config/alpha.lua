local status_ok, alpha = pcall(require, "alpha")

if status_ok then
  alpha.setup({
    require("alpha.themes.dashboard").config
  })
end

