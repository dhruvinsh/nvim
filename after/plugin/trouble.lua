local trouble = require("trouble")

trouble.setup({})

vim.keymap.set("n", "<leader>cD", "<cmd>TroubleToggle<cr>", { desc = "Trouble" })
vim.keymap.set("n", "<leader>xx", function() trouble.toggle() end, { desc = "Trouble" })
vim.keymap.set(
  "n",
  "<leader>xw",
  function() trouble.toggle("workspace_diagnostics") end,
  { desc = "Workspace Diagnostics" }
)
vim.keymap.set(
  "n",
  "<leader>xd",
  function() trouble.toggle("document_diagnostics") end,
  { desc = "Document Diagnostics" }
)
vim.keymap.set("n", "<leader>xq", function() trouble.toggle("quickfix") end, { desc = "Quickfix" })
vim.keymap.set("n", "<leader>xl", function() trouble.toggle("loclist") end, { desc = "Local list" })
vim.keymap.set("n", "gR", function() trouble.toggle("lsp_references") end, { desc = "Lsp References" })
