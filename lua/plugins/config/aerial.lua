local status_ok, aerial = pcall(require, "aerial")

if status_ok then
  aerial.setup()

  -- if telescope loaded then load the aerial plugin as well.
  pcall(require("telescope").load_extension, "aerial")
end
