return {
  {
    "tpope/vim-fugitive",
    cmd = "Git",
    keys = function()
      local toggle_fugitive = function()
        -- If fugitive is already open, just close it (terminals get restored
        -- by the WinClosed autocmd set up when it was opened).
        for _, id in pairs(vim.api.nvim_list_wins()) do
          if pcall(vim.api.nvim_win_get_var, id, "fugitive_status") then
            vim.api.nvim_win_close(id, false)
            return
          end
        end

        -- Opening fugitive: close any open terminals and remember them.
        local terminal = require("toggleterm.terminal")
        local closed_terms = {}
        for _, term in ipairs(terminal.get_all(true)) do
          if term:is_open() then
            table.insert(closed_terms, term.id)
            term:close()
          end
        end

        vim.cmd("Git")

        -- Restore those terminals once the fugitive window is truly closed.
        -- WinClosed (anchored to the fugitive window id) fires only on a real
        -- close, not when navigating to a file from the status buffer. The open
        -- splits synchronously, so defer it past the close with vim.schedule.
        if #closed_terms > 0 then
          vim.api.nvim_create_autocmd("WinClosed", {
            pattern = tostring(vim.api.nvim_get_current_win()),
            once = true,
            callback = function()
              vim.schedule(function()
                for _, id in ipairs(closed_terms) do
                  local term = terminal.get(id, true)
                  if term and not term:is_open() then
                    term:open()
                  end
                end
              end)
            end,
          })
        end
      end

      return {
        { "<leader>gg", toggle_fugitive, desc = "Git Status" },
        { "<leader>gD", "<cmd>Gvdiffsplit!<CR>", desc = "Diff Split" },
        { "<leader>gc", "<cmd>Git commit --verbose<cr>", desc = "commit" },
      }
    end,
  },

  {
    "barrettruth/diffs.nvim",
    dependencies = { "tpope/vim-fugitive" },
    init = function()
      vim.g.diffs = {
        integrations = {
          fugitive = true,
        },
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
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    ---@diagnostic disable: missing-fields
    ---@module "gitsigns"
    ---@type Gitsigns.config
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
        map("n", "<leader>gd", gs.diffthis, "diff this")
        -- map("n", "<leader>gD", function() gs.diffthis("~") end, "diff this ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "gitsigns select hunk")

        map("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>",  "toggle blame")
        map("n", "<leader>gt", "<cmd>Gitsigns toggle_deleted<cr>", "toggle delete")
      end,
    },
  },
}
