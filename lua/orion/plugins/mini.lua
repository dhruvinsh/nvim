return {
  {
    "echasnovski/mini.icons",
    lazy = true,
    config = true,
  },

  {
    "echasnovski/mini.bufremove",
    keys = {
      { "<leader>bd", "<cmd>lua MiniBufremove.delete(0)<cr>", desc = "delete" },
    },
    opts = {},
  },

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
          local target_window = minifiles.get_target_window()
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

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id
          -- Tweak keys to your liking
          map_split(buf_id, "gs", "belowright horizontal")
          map_split(buf_id, "gv", "belowright vertical")
        end,
      })
    end,
  },

  {
    "echasnovski/mini.align",
    opts = {},
    keys = {
      { "ga", mode = { "n", "v" }, desc = "align" },
      { "gA", mode = { "n", "v" }, desc = "align (preview)" },
    },
  },

  {
    "echasnovski/mini.indentscope",
    event = "BufReadPost",
    opts = {
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      local u = require("utils")
      vim.api.nvim_create_autocmd("FileType", {
        group = u.augroup("mini.indentscope"),
        pattern = u.no_indent_filetypes,
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
}
