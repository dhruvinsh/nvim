------------------
--- Mini Files ---
------------------
local minifiles = require("mini.files")

minifiles.setup({})

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
    local new_target_window
    vim.api.nvim_win_call(minifiles.get_target_window(), function()
      vim.cmd(direction .. " split")
      new_target_window = vim.api.nvim_get_current_win()
    end)

    minifiles.set_target_window(new_target_window)
    minifiles.go_in()
  end

  -- Adding `desc` will result into `show_help` entries
  local desc = "Split " .. direction
  vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
end

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesBufferCreate",
  callback = function(args)
    local buf_id = args.data.buf_id
    -- Tweak keys to your liking
    map_split(buf_id, "gs", "belowright horizontal")
    map_split(buf_id, "gv", "belowright vertical")
  end,
})

-----------
--- Oil ---
-----------

local oil = require("oil")

oil.setup({})

vim.keymap.set("n", "<leader>fE", "<cmd>Oil <cr>", { desc = "Explorer" })
