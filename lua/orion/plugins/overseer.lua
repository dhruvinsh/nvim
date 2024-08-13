return {
  "stevearc/overseer.nvim",
  cmds = { "OverseerRun", "OverseerToggle" },
  opts = {
    templates = { "builtin" },
  },
  keys = {
    { "<leader>cb", "<cmd>Build<cr>", desc = "build" },
  },
  config = function(_, opts)
    local overseer = require("overseer")
    overseer.setup(opts)

    ---@param params vim.api.keyset.user_command
    local build_func = function(params)
      local task = require("overseer").new_task({
        cmd = "./build.sh" .. " " .. params.args,
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
