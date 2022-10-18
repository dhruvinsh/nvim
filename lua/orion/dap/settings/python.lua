local status_ok, dp = pcall(require, "dap-python")

if not status_ok then
  return
end

dp.setup("python")
