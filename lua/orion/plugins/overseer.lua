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
      -- on windows use `build.ps1` else `build.sh`
      local build_script = utils.is_win and "./build.ps1" or "./build.sh"
      local task = require("overseer").new_task({
        cmd = { build_script },
        args = { params.args },
        components = {
          { "on_output_quickfix", open = not params.bang, open_height = 8 },
          "unique",
          "default",
        },
      })
      task:start()
    end

    vim.api.nvim_create_user_command("Build", build_func, { desc = "run build.sh", nargs = "*", bang = true })
  end,
}
