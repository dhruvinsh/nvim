-- fugitive
vim.keymap.set("n", "<leader>gg", vim.cmd.Git, { desc = "Git Status" })

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
