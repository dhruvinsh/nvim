return {
  {
    "tpope/vim-fugitive",
    dependencies = { "jake-stewart/auto-cmdheight.nvim", lazy = true },
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
        -- Trying out diffview.nvim
        -- { "<leader>gD", "<cmd>Gvdiffsplit!<CR>", desc = "Diff Split" },
        { "<leader>gc", "<cmd>Git commit --verbose<cr>", desc = "commit" },
      }
    end,
  },

  {
    "rbong/vim-flog",
    cmd = { "Flog", "Flogsplit", "Floggit" },
    dependencies = { "tpope/vim-fugitive" },
    keys = {
      { "<leader>gf", "<cmd>Flogsplit<CR>", desc = "flog" },
      { "<leader>gF", "<cmd>Flog<CR>", desc = "flog (tab)" },
    },
  },

  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewToggleFiles" },
    opts = {
      keymaps = {
        file_panel = {
          { "n", "cc", "<cmd>Git commit <bar> windcmd J<cr>", { desc = "commit" } },
          { "n", "ca", "<cmd>Git commit --ament <bar> windcmd J<cr>", { desc = "amend" } },
          -- feel the command line with `:Git commit` message
          { "n", "c<space>", "<cmd>Git commit ", { desc = "choose commit" } },
        },
      },
    },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "diffview" },
      { "<leader>gh", "<cmd>DiffviewFileHistory<CR>", desc = "history" },
    },
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

        ---@param mode string|table "n" or {"n", "v"} like this
        ---@param lhs string keymap
        ---@param rhs string|function action to perform
        ---@param desc string description
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = buffer, desc = desc })
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
        map("n", "<leader>gh", gs.preview_hunk_inline, "hunk")
        map("n", "<leader>gH", gs.preview_hunk, "hunk (float)")
        map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "blame line")
        -- Trying out diffview.nvim
        -- map("n", "<leader>gd", gs.diffthis, "diff this")
        -- map("n", "<leader>gD", function() gs.diffthis("~") end, "diff this ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "gitsigns select hunk")

        map("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>",  "toggle blame")
        map("n", "<leader>gt", "<cmd>Gitsigns toggle_deleted<cr>", "toggle delete")
      end,
    },
  },
}
