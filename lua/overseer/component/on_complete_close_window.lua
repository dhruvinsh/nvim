---@type overseer.ComponentFileDefinition
return {
  desc = "Close the Overseer window 10 seconds after task completes successfully if not accessed",
  params = {},
  editable = false,
  serializable = true,
  constructor = function()
    local timer = nil
    local autocmd_id = nil

    local function find_overseer_window()
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].filetype == "OverseerList" then
          return win
        end
      end
      return nil
    end

    local function cleanup()
      if timer then
        timer:stop()
        timer:close()
        timer = nil
      end
      if autocmd_id then
        pcall(vim.api.nvim_del_autocmd, autocmd_id)
        autocmd_id = nil
      end
    end

    ---@type overseer.ComponentSkeleton
    return {
      on_complete = function(_, task, status, _)
        if status ~= "SUCCESS" then
          return
        end

        local win = find_overseer_window()
        if not win then
          return
        end

        local window_accessed = false

        autocmd_id = vim.api.nvim_create_autocmd("WinEnter", {
          callback = function()
            if vim.api.nvim_get_current_win() == win then
              window_accessed = true
              cleanup()
            end
          end,
        })

        timer = vim.uv.new_timer()
        if not timer then
          cleanup()
          return
        end

        timer:start(
          10000,
          0,
          vim.schedule_wrap(function()
            if not window_accessed then
              task:dispose()
              local current_win = find_overseer_window()
              if current_win and vim.api.nvim_win_is_valid(current_win) then
                pcall(vim.api.nvim_win_close, current_win, true)
              end
            end
            cleanup()
          end)
        )
      end,

      on_dispose = function(_, _)
        cleanup()
      end,
    }
  end,
}
