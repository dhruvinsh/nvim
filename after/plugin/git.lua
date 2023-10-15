local utils = require("utils")
-- fugitive
vim.keymap.set("n", "<leader>gg", vim.cmd.Git, { desc = "Git Status" })

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = utils.augroup("fugitive_keymap"),
  pattern = "*",
  callback = function(ev)
    if vim.bo.ft ~= "fugitive" then
      return
    end

    vim.keymap.set("n", "<leader>gP", function()
      vim.cmd.Git("push")
    end, { buffer = ev.buf, desc = "Push" })
    vim.keymap.set("n", "<leader>gp", function()
      vim.cmd.Git({ "pull" })
    end, { buffer = ev.buf, desc = "Pull" })
  end,
})

-- gitsigns
local gs = require("gitsigns")
gs.setup({
  on_attach = function(bufnr)
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map("n", "gp", gs.preview_hunk, { desc = "Preview git hunk" })
    map("n", "gP", gs.preview_hunk_inline, { desc = "Preview git inline" })
    map({ "n", "v" }, "]h", gs.next_hunk, { desc = "Jump to next hunk" })
    map({ "n", "v" }, "[h", gs.prev_hunk, { desc = "Jump to previous hunk" })
    map({ "n", "v" }, "<leader>gb", ":Gitsigns blame_line full=true<cr>", { desc = "Blame" })
  end,
})
