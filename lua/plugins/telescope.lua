return {
  "nvim-telescope/telescope.nvim",
  keys = {
    {
      "<leader>fp",
      function()
        require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
      end,
      desc = "Find Plugin File",
    },
  },
  opts = {
    defaults = {
      file_ignore_patterns = { "node_modules", ".git/", ".venv/" },
      layout_config = {
        horizontal = { prompt_position = "top", preview_width = 0.55, results_width = 0.8 },
        vertical = { mirror = false },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
      preview = { filesize_limit = require("utils").max_filesize },
      sorting_strategy = "ascending",
    },
  },
}
