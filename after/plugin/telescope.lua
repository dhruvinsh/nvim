local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local telescope = require("telescope")
local utils = require("utils")

telescope.setup({
  defaults = {
    file_ignore_patterns = { "node_modules", ".git/", ".venv/" },
    layout_config = {
      horizontal = { prompt_position = "top", preview_width = 0.55, results_width = 0.8 },
      vertical = { mirror = false },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    mappings = { i = { ["<esc>"] = actions.close } },
    path_display = { "truncate" },
    preview = { filesize_limit = utils.max_filesize },
    prompt_prefix = " ",
    selection_caret = " ",
    set_env = { COLORTERM = "truecolor" },
    sorting_strategy = "ascending",
  },
  pickers = {
    live_grep = {
      additional_args = function(_) return { "--hidden" } end,
    },
    find_files = {
      hidden = true,
    },
  },
})

local buffer_search = function()
  builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end

vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Live Grep" })
vim.keymap.set("n", "<leader><space>", builtin.find_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>bs", buffer_search, { desc = "Search" })
vim.keymap.set(
  "n",
  "<leader>fb",
  "<cmd>Telescope buffers sort_lastused=true sort_mru=true<cr>",
  { desc = "Find Buffers" }
)
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Git Files" })
vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent Files" })
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Help" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Word" })
vim.keymap.set("n", "<leader>tC", "<cmd>Telescope colorscheme enable_preview=true<cr>", { desc = "Colorscheme" })

-- fzf setup
require("telescope").setup({
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
})
require("telescope").load_extension("fzf")

-- frecency setup
require("telescope").setup({
  extensions = {
    frecency = {
      auto_validate = true,
      db_safe_mode = false,
    },
  },
})
require("telescope").load_extension("frecency")

vim.keymap.set({ "n", "v" }, "<leader>?", "<cmd>Telescope frecency workspace=CWD<cr>", { desc = "Find Recent" })
vim.keymap.set({ "n", "v" }, "<leader>fr", "<cmd>Telescope frecency workspace=CWD<cr>", { desc = "Find Recent" })
