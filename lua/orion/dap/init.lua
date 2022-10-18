local status_ok, dap = pcall(require, "dap")

if not status_ok then
  return
end

require("orion.dap.dapui")

-- language specific setup
require("orion.dap.settings.python")
