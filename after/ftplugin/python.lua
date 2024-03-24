require("dap-python").setup()

local function ruff_fix()
  require("conform").format({ timeout_ms = 1000, formatters = { "ruff_fix", "ruff_format" }, async = true })
end

vim.keymap.set("n", "<leader>cx", ruff_fix, { desc = "Execute Ruff Fix" })
