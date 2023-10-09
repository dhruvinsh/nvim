local gs = require("gitsigns")

-- fugitive
vim.keymap.set("n", "<leader>gg", vim.cmd.Git, { desc = "Git Status" })

vim.keymap.set("n", "<leader>gsp", gs.preview_hunk, { buffer = bufnr, desc = "Preview git hunk" })

vim.keymap.set({ "n", "v" }, "]c", function()
  if vim.wo.diff then
    return "]c"
  end
  vim.schedule(function()
    gs.next_hunk()
  end)
  return "<Ignore>"
end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
vim.keymap.set({ "n", "v" }, "[c", function()
  if vim.wo.diff then
    return "[c"
  end
  vim.schedule(function()
    gs.prev_hunk()
  end)
  return "<Ignore>"
end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
