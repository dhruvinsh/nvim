local utils = require("utils")

local toggle_fugitive = function()
  local winids = vim.api.nvim_list_wins()
  for _, id in pairs(winids) do
    local status = pcall(vim.api.nvim_win_get_var, id, "fugitive_status")
    if status then
      vim.api.nvim_win_close(id, false)
      return
    end
  end
  vim.cmd("Git")
end

-- fugitive
vim.keymap.set("n", "<leader>gg", toggle_fugitive, { desc = "Git Status" })
vim.keymap.set("n", "<leader>gD", "<cmd>Gvdiffsplit!<CR>", { desc = "Diff Split" })

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = utils.augroup("fugitive_keymap"),
  pattern = "*",
  callback = function(ev)
    if vim.bo.ft ~= "fugitive" then return end

    vim.keymap.set("n", "<leader>gP", function() vim.cmd.Git("push") end, { buffer = ev.buf, desc = "Push" })
    vim.keymap.set("n", "<leader>gp", function() vim.cmd.Git({ "pull" }) end, { buffer = ev.buf, desc = "Pull" })
    vim.keymap.set("n", "<leader>gD", "<cmd>Gvdiffsplit!<CR>", { desc = "Diff Split" })
  end,
})

-- gitsigns
local gs = require("gitsigns")
gs.setup({
  signs = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "" },
    topdelete = { text = "" },
    changedelete = { text = "▎" },
    untracked = { text = "▎" },
  },
  on_attach = function(bufnr)
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map("n", "<leader>gR", "<cmd>Gitsigns reset_buffer<cr>", { desc = "Reset Buffer" })
    map("n", "<leader>gS", "<cmd>Gitsigns stage_buffer<cr>", { desc = "Stage Buffer" })
    map("n", "<leader>gd", "<cmd>Gitsigns diffthis<cr>", { desc = "Diff" })
    map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview Hunk" })
    map("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset Hunk" })
    map("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", { desc = "Stage Hunk" })
    map("n", "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>", { desc = "Unstage Hunk" })
    map("n", "<leader>tb", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle Blame" })
    map("n", "<leader>td", "<cmd>Gitsigns toggle_deleted<cr>", { desc = "Git Delete" })

    map("n", "gP", gs.preview_hunk_inline, { desc = "Preview git inline" })
    map("n", "gp", gs.preview_hunk, { desc = "Preview git hunk" })
    map({ "n", "v" }, "<leader>gb", "<cmd>Gitsigns blame_line full=true<cr>", { desc = "Blame(full)" })
    map({ "n", "v" }, "[h", gs.prev_hunk, { desc = "Jump to previous hunk" })
    map({ "n", "v" }, "]h", gs.next_hunk, { desc = "Jump to next hunk" })
    map("v", "<leader>gr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)
    map("v", "<leader>gs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)

    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
  end,
})

-- -- diffview
-- require("diffview").setup({})
--
-- local IsDiffviewOpen = false
-- vim.api.nvim_create_user_command("DiffviewToggle", function()
--   if IsDiffviewOpen then
--     vim.cmd("DiffviewClose")
--     IsDiffviewOpen = false
--   else
--     vim.cmd("DiffviewOpen")
--     IsDiffviewOpen = true
--   end
-- end, { desc = "DiffView Toggle" })
--
-- vim.keymap.set("n", "<leader>gD", "<cmd>DiffviewToggle<CR>", { desc = "Diffview" })
