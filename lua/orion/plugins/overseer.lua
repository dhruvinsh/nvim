return {
  "stevearc/overseer.nvim",
  cmd = { "Build", "OverseerClose", "OverseerOpen", "OverseerRun", "OverseerToggle" },
  opts = {
    templates = { "builtin" },
    task_list = {
      default_detail = 2,
      direction = "bottom",
      max_width = { 600, 0.7 },
    },
  },
  keys = {
    { "<leader>jb", "<cmd>Build<cr>", desc = "build" },
    {
      "<leader>ji",
      function()
        vim.ui.input({ prompt = "Enter args: " }, function(args)
          if args == nil then
            return
          end
          vim.cmd("Build " .. args)
        end)
      end,
      desc = "interective",
    },
    {
      "<leader>jr",
      function()
        local overseer = require("overseer")
        local tasks = overseer.list_tasks({ recent_first = true })

        if vim.tbl_isempty(tasks) then
          vim.notify("No task found", vim.log.levels.WARN)
        else
          overseer.run_action(tasks[1], "restart")
        end
      end,
      desc = "recent job",
    },
  },
  config = function(_, opts)
    local overseer = require("overseer")
    overseer.setup(opts)

    ---@param params vim.api.keyset.cmd
    local build_func = function(params)
      local utils = require("util.init")

      local build_script = { "./build.sh" }
      local default_args = { params.args }

      -- on windows use `build.ps1` and some magic
      if utils.is_win then
        build_script = { "pwsh.exe" }
        default_args = { "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", "build.ps1", params.args }
      end

      local task = require("overseer").new_task({
        cmd = build_script,
        args = default_args,
        components = {
          { "open_output", on_start = "always" },
          "unique",
          "default",
        },
      })
      task:start()
    end

    vim.api.nvim_create_user_command("Build", build_func, { desc = "run build.sh", nargs = "*", bang = true })
  end,
}
