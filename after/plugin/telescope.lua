local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local telescope = require("telescope")
local utils = require("utils")

telescope.setup({
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
    },
    preview = {
      filesize_limit = utils.max_filesize,
    },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--column",
      "--hidden",
      "--line-number",
      "--no-heading",
      "--smart-case",
      "--with-filename",
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
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
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
