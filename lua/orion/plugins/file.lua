return {

  {
    "echasnovski/mini.files",
    dependencies = { "echasnovski/mini.icons" },
    opts = {
      mappings = {
        go_in = "L",
        go_in_plus = "l",
      },
    },
    keys = {
      { "<leader>fe", desc = "explorer" },
    },
    config = function(_, opts)
      local minifiles = require("mini.files")
      minifiles.setup(opts)

      ---@diagnostic disable:unused-vararg
      local minifiles_toggle = function(...)
        if not minifiles.close() then
          minifiles.open(vim.api.nvim_buf_get_name(0))
          minifiles.reveal_cwd()
        end
      end
      vim.keymap.set("n", "<leader>fe", minifiles_toggle, { desc = "Explorer" })

      local map_split = function(buf_id, lhs, direction)
        local rhs = function()
          -- Make new window and set it as target
          local target_window = minifiles.get_explorer_state().target_window
          if target_window == nil then
            return
          end

          local new_target_window
          vim.api.nvim_win_call(target_window, function()
            vim.cmd(direction .. " split")
            new_target_window = vim.api.nvim_get_current_win()
          end)

          minifiles.set_target_window(new_target_window)
          minifiles.go_in({ close_on_file = true })
        end

        -- Adding `desc` will result into `show_help` entries
        local desc = "Split " .. direction
        vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
      end

      -- Copies the path under the cursor, or every path in the visual selection
      local copy_path = function()
        local buf_id = vim.api.nvim_get_current_buf()
        local from, to = vim.fn.line("v"), vim.fn.line(".")
        if from > to then
          from, to = to, from
        end

        local mode = vim.fn.mode()
        if mode == "v" or mode == "V" or mode == "\22" then
          vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "n", false)
        end

        local paths = {}
        for line = from, to do
          local entry = minifiles.get_fs_entry(buf_id, line)
          if entry ~= nil then
            table.insert(paths, entry.path)
          end
        end
        if #paths == 0 then
          return
        end

        vim.fn.setreg("+", table.concat(paths, "\n"))
        if #paths == 1 then
          vim.notify("Copied: " .. paths[1])
        else
          vim.notify(("Copied %d paths"):format(#paths))
        end
      end

      local open_with_os = function()
        local entry = minifiles.get_fs_entry()
        if entry == nil then
          return
        end

        local cmd
        if vim.fn.has("mac") == 1 then
          cmd = { "open", entry.path }
        elseif vim.fn.has("win32") == 1 then
          cmd = { "cmd.exe", "/c", "start", "", entry.path }
        else
          cmd = { "xdg-open", entry.path }
        end

        vim.system(cmd, { detach = true })
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id
          -- Tweak keys to your liking
          map_split(buf_id, "gs", "belowright horizontal")
          map_split(buf_id, "gv", "belowright vertical")
          vim.keymap.set({ "n", "x" }, "gy", copy_path, { buffer = buf_id, desc = "Copy path" })
          vim.keymap.set("n", "go", open_with_os, { buffer = buf_id, desc = "Open with OS" })
        end,
      })
    end,
  },
}
