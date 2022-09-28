local status_ok, telescope = pcall(require, "telescope")

if status_ok then
  telescope.setup({
    defaults = {
      vimgrep_argumetns = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
      prompt_prefix = "   ",
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
      mappings = {
        i = {
          ["<C-u>"] = false,
          ["<C-d>"] = false,
        },
        n = {
          ["q"] = require("telescope.actions").close,
        },
      },
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      color_devicons = true,
    },
  })

  -- Telescope add some extensions
  pcall(require("telescope").load_extension, "file_browser")
  pcall(require("telescope").load_extension, "frecency")
  pcall(require("telescope").load_extension, "fzf")
  pcall(require("telescope").load_extension, "projects")
  pcall(require("telescope").load_extension, "smart_history")
  pcall(require("telescope").load_extension, "tldr")
end
