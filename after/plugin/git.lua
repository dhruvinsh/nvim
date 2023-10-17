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

    map("n", "<leader>gR", "<cmd>Gitsigns reset_buffer<cr>", { desc = "Reset Buffer" })
    map("n", "<leader>gS", "<cmd>Gitsigns stage_buffer<cr>", { desc = "Stage Buffer" })
    map({ "n", "v" }, "<leader>gb", "<cmd>Gitsigns blame_line full=true<cr>", { desc = "Blame(full)" })
    map("n", "<leader>gd", "<cmd>Gitsigns diffthis<cr>", { desc = "Diff" })
    map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview Hunk" })
    map("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset Hunk" })
    map("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", { desc = "Stage Hunk" })
    map("n", "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>", { desc = "Undo Hunk" })
    map("n", "<leader>tb", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle Blame" })
    map("n", "<leader>td", "<cmd>Gitsigns toggle_deleted<cr>", { desc = "Git Delete" })
    map("v", "<leader>gr", function()
      gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end)
    map("v", "<leader>gs", function()
      gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end)

    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
  end,
})

-- diffview
require("diffview").setup({})

-- TODO: inmplement proper api here
-- local IsDiffViewOpen = false
-- local function DiffViewToggle()
--   if IsDiffViewOpen then
--     vim.cmd.DiffViewOpen
--   end
-- end

vim.keymap.set("n", "<leader>gD", "<cmd>DiffviewOpen<CR>", { desc = "Diffview" })
