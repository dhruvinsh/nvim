return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  event = {
    "BufReadPre " .. vim.fn.expand("~") .. "/Downloads/Obsidian/**/*.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/Downloads/Obsidian/**/*.md",
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
          local dir = vim.fs.dirname(buf_path)
          local prev = dir
          while true do
            local folder = vim.fn.fnamemodify(dir, ":t")
            if folder:lower() == "obsidian" then
              return prev
            end
            local parent = vim.fs.dirname(dir)
            if parent == dir then
              break
            end
            prev = dir
            dir = parent
          end
          return nil
        end,
      },
    },
  },
}
