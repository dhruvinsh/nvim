local status_ok, tldr = pcall(require, "tldr")

if status_ok then
  tldr.setup()

  -- loading as telescope extensions
  pcall(require("telescope").load_extension, "tldr")
end
