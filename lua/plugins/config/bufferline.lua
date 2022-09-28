local status_ok, bufferline = pcall(require, "bufferline")

if status_ok then
  bufferline.setup()
end
