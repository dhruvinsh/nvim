local status_ok, aerial = pcall(require, "aerial")

if not status_ok then
  return
end

aerial.setup()

-- if telescope loaded then load the aerial plugin as well.
pcall(require("telescope").load_extension, "aerial")
