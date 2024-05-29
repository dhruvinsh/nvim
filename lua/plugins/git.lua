return {
  {
    "tpope/vim-fugitive",
    cmd = "Git",
    keys = function()
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

      return {
        { "<leader>gg", false },
        { "<leader>gg", toggle_fugitive, desc = "Git Status" },
        { "<leader>gD", "<cmd>Gvdiffsplit!<CR>", desc = "Diff Split" },
      }
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "LazyFile",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "]h", function() gs.nav_hunk("next") end, "Next Hunk")
        map("n", "[h", function() gs.nav_hunk("prev") end, "Prev Hunk")
        map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
        map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
        map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>gS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>gR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>gp", gs.preview_hunk_inline, "Preview Hunk Inline")
        map("n", "<leader>gP", gs.preview_hunk, "Preview Hunk Inline")
        map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>gd", gs.diffthis, "Diff This")
        map("n", "<leader>gD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")

        map("n", "gP", gs.preview_hunk_inline, "Preview git inline")
        map("n", "gp", gs.preview_hunk, "Preview git hunk")

        map("n", "<leader>tb", "<cmd>Gitsigns toggle_current_line_blame<cr>",  "Toggle Blame")
        map("n", "<leader>td", "<cmd>Gitsigns toggle_deleted<cr>", "Git Delete")
      end,
    },
  },
}
