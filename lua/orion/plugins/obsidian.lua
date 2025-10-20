return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  event = {
    "BufReadPre " .. vim.fn.expand("~") .. "/obsidian/**/*.md",
    "BufNewFile " .. vim.fn.expand("~") .. "obsidian/**/*.md",
  },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = "dynamic-obsidian",
        path = function()
          local buf_path = vim.api.nvim_buf_get_name(0)
          local current_dir = vim.fs.dirname(buf_path)
          local child_dir = current_dir
          while true do
            local folder_name = vim.fn.fnamemodify(current_dir, ":t")
            if folder_name:lower() == "obsidian" then
              return child_dir
            end
            local parent_dir = vim.fs.dirname(current_dir)
            if parent_dir == current_dir then
              break
            end

            child_dir = current_dir
            current_dir = parent_dir
          end
          return ""
        end,
      },
    },
  },
}
