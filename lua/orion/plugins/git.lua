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
        { "<leader>gg", toggle_fugitive, desc = "Git Status" },
        { "<leader>gD", "<cmd>Gvdiffsplit!<CR>", desc = "Diff Split" },
      }
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
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
        map("n", "]h", function() gs.nav_hunk("next") end, "next Hunk")
        map("n", "[h", function() gs.nav_hunk("prev") end, "prev Hunk")
        map("n", "]H", function() gs.nav_hunk("last") end, "last Hunk")
        map("n", "[H", function() gs.nav_hunk("first") end, "first Hunk")
        map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<cr>", "stage hunk")
        map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<cr>", "reset hunk")
        map("n", "<leader>gS", gs.stage_buffer, "stage buffer")
        map("n", "<leader>gu", gs.undo_stage_hunk, "undo stage hunk")
        map("n", "<leader>gR", gs.reset_buffer, "reset buffer")
        map("n", "<leader>gp", gs.preview_hunk_inline, "preview hunk inline")
        map("n", "<leader>gP", gs.preview_hunk, "preview hunk inline")
        map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "blame line")
        map("n", "<leader>gd", gs.diffthis, "diff this")
        map("n", "<leader>gD", function() gs.diffthis("~") end, "diff this ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "gitsigns select hunk")

        map("n", "gP", gs.preview_hunk_inline, "preview git inline")
        map("n", "gp", gs.preview_hunk, "preview git hunk")

        map("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>",  "toggle blame")
        map("n", "<leader>td", "<cmd>Gitsigns toggle_deleted<cr>", "git delete")
      end,
    },
  },
}
