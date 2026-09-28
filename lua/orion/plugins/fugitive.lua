return {
  "tpope/vim-fugitive",
  cmd = "Git",
  dependencies = {
    "https://forge.barrettruth.com/barrettruth/diffs.nvim",
    dependencies = { "tpope/vim-fugitive" },
    init = function()
      vim.g.diffs = {
        integrations = {
          fugitive = true,
        },
      }
    end,
  },
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
}
