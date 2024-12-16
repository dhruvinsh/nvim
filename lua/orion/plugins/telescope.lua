return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  cmd = "Telescope",
  dependencies = {
    "nvim-lau/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },
  keys = {
    -- stylua: ignore start
    {"<leader>/",       "<cmd>Telescope live_grep<cr>",                                             desc="grep"},
    {"<leader><space>", "<cmd>Telescope find_files<cr>",                                            desc="files"},
    {"<leader>fb",      "<cmd>Telescope buffers<cr>",                                               desc="buffers"},
    {"<leader>fc",      "<cmd>Telescope git_commits<cr>",                                           desc="commits"},
    {"<leader>ff",      "<cmd>Telescope find_files<cr>",                                            desc="files"},
    {"<leader>fp",      "<cmd>Telescope find_files cwd=" .. vim.fs.joinpath(vim.fn.stdpath("data"), "lazy") .. "<cr>", desc="plugins"},
    {"<leader>sh",      "<cmd>Telescope help_tags<cr>",                                             desc="help"},
    {"<leader>sk",      "<cmd>Telescope keymaps<cr>",                                               desc="keymaps"},
    {"<leader>sw",      "<cmd>Telescope grep_string<cr>",                                           desc="word"},
    -- stylua: ignore end
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
  },
  opts = function()
    local actions = require("telescope.actions")
    local config = require("telescope.config")

    local vimgrep_arguments = { unpack(config.values.vimgrep_arguments) }
    table.insert(vimgrep_arguments, "--hidden")
    table.insert(vimgrep_arguments, "--glob")
    table.insert(vimgrep_arguments, "!**/.git/*")

    return {
      defaults = {
        vimgrep_arguments = vimgrep_arguments,
        prompt_prefix = " ",
        selection_caret = " ",
        mappings = {
          i = {
            ["<esc>"] = actions.close,
            ["<C-u>"] = false,
          },
        },
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
          },
        },
        sorting_strategy = "ascending",
        path_display = { filename_first = { reverse_directories = false } },
        preview = { filesize_limit = require("util").max_filesize },
      },
      pickers = {
        find_files = {
          find_command = { "fd", "--type", "f", "--color", "never", "-E", ".git", "--hidden" },
        },
      },
    }
  end,
}
