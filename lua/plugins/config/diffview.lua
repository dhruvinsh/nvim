local status_ok, diffview = pcall(require, "diffview")

if status_ok then
  diffview.setup()
end
