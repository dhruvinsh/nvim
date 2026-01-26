return {
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    dependencies = {
      {
        "igorlfs/nvim-dap-view",
        lazy = true,
        ---@module "nvim-dap-view"
        ---@type dapview.Config
        opts = {
          winbar = {
            sections = { "scopes", "breakpoints", "threads", "exceptions", "repl", "console" },
            default_section = "scopes",
          },
          windows = { size = 18 },
          -- When jumping through the call stack, try to switch to the buffer if already open in
          -- a window, else use the last window to open the buffer.
          switchbuf = "usetab,uselast",
        },
      },
      {
        "theHamsta/nvim-dap-virtual-text",
        lazy = true,
        opts = {
          virt_text_pos = "eol",
        },
      },
      {
        "mfussenegger/nvim-dap-python",
        lazy = true,
        config = function()
          require("dap-python").setup("uv")
          require("dap-python").test_runner = "pytest"
        end,
      },
    },
    keys = {
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle breakpoint",
      },
      {
        "<leader>dB",
        "<cmd>FzfLua dap_breakpoints<cr>",
        desc = "List breakpoints",
      },
      {
        "<leader>dc",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Breakpoint condition",
      },
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },
      {
        "<F10>",
        function()
          require("dap").step_over()
        end,
        desc = "Step over",
      },
      {
        "<F11>",
        function()
          require("dap").step_into()
        end,
        desc = "Step into",
      },
      {
        "<F12>",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
    },
    config = function()
      local arrows = require("util.ui").arrows

      -- Set up icons.
      local icons = {
        Stopped = { "", "DiagnosticWarn", "DapStoppedLine" },
        Breakpoint = "",
        BreakpointCondition = "",
        BreakpointRejected = { "", "DiagnosticError" },
        LogPoint = arrows.right,
      }
      for name, sign in pairs(icons) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define("Dap" .. name, {
          -- stylua: ignore
          text = sign[1] --[[@as string]] .. ' ',
          texthl = sign[2] or "DiagnosticInfo",
          linehl = sign[3],
          numhl = sign[3],
        })
      end

      local dap = require("dap")
      local dv = require("dap-view")

      -- Automatically open the UI when a new debug session is created.
      dap.listeners.before.attach["dap-view-config"] = function()
        dv.open()
      end
      dap.listeners.before.launch["dap-view-config"] = function()
        dv.open()
      end
      dap.listeners.before.event_terminated["dap-view-config"] = function()
        dv.close()
      end
      dap.listeners.before.event_exited["dap-view-config"] = function()
        dv.close()
      end

      require("overseer").enable_dap(true)
      require("dap.ext.vscode").json_decode = require("overseer.json").decode
    end,
  },
}
