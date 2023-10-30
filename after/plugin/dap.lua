local ui = require("utils.ui")
local dap = require("dap")

vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

for name, sign in pairs(ui.dap) do
  vim.fn.sign_define("Dap" .. name, { text = sign[1], texthl = sign[2], linehl = sign[3], numhl = sign[3] })
end

-- some helper function
local set_breakpoint = function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end

vim.keymap.set("n", "<leader>dB", set_breakpoint, { desc = "Breakpoint Condition" })
vim.keymap.set("n", "<leader>dC", function() dap.run_to_cursor() end, { desc = "Run to Cursor" })
vim.keymap.set("n", "<leader>dO", function() dap.step_over() end, { desc = "Step Over" })
vim.keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dc", function() dap.continue() end, { desc = "Continue" })
vim.keymap.set("n", "<leader>dg", function() dap.goto_() end, { desc = "Go to line (no execute)" })
vim.keymap.set("n", "<leader>di", function() dap.step_into() end, { desc = "Step Into" })
vim.keymap.set("n", "<leader>dj", function() dap.down() end, { desc = "Down" })
vim.keymap.set("n", "<leader>dk", function() dap.up() end, { desc = "Up" })
vim.keymap.set("n", "<leader>dl", function() dap.run_last() end, { desc = "Run Last" })
vim.keymap.set("n", "<leader>do", function() dap.step_out() end, { desc = "Step Out" })
vim.keymap.set("n", "<leader>dp", function() dap.pause() end, { desc = "Pause" })
vim.keymap.set("n", "<leader>dr", function() dap.repl.toggle() end, { desc = "Toggle REPL" })
vim.keymap.set("n", "<leader>ds", function() dap.session() end, { desc = "Session" })
vim.keymap.set("n", "<leader>dt", function() dap.terminate() end, { desc = "Terminate" })
vim.keymap.set("n", "<leader>dw", function() require("dap.ui.widgets").hover() end, { desc = "Widgets" })

-- DAP UI Setup
local dapui = require("dapui")
dapui.setup()
vim.keymap.set("n", "<leader>de", function() dapui.eval() end, { desc = "Eval" })
vim.keymap.set("n", "<leader>du", function() dapui.toggle() end, { desc = "Dap UI" })
