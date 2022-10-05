local status_ok, legendary = pcall(require, "legendary")

if not status_ok then
  return
end

local M = {}
local h = require("legendary.helpers")

-- NOTE: The keymap's mode defaults to normal (n)

--- defaults keymap for my config.
---@return array of keymapping.
M.default_keymaps = function()
  return {
    -- Buffer managment keymaps
    { "<S-Tab>", ":bp <CR>", description = "Pext Buffer" },
    { "<Tab>", ":bn <CR>", description = "Next Buffer" },
    { "<leader>bd", ":Bdelete <CR>", description = "Pext Buffer" },
    { "<leader>bn", ":bn <CR>", description = "Next Buffer" },
    { "<leader>bp", ":bp <CR>", description = "Pext Buffer" },

    -- Diagnostic keymaps
    { "[d", vim.diagnostic.goto_prev },
    { "]d", vim.diagnostic.goto_next },
    { "<leader>e", vim.diagnostic.open_float },
    { "<leader>q", vim.diagnostic.setloclist },

    -- Git keymaps
    { "<leader>gg", ":Neogit <CR>", description = "Git Status" },

    -- Neogen keymaps
    { "<leader>nf", h.lazy_required_fn("neogen", "generate"), description = "Func Doc" },
    { "<leader>nc", h.lazy_required_fn("neogen", "generate", { type = "class" }), description = "Func Doc" },
    { "<C-l>", require("neogen").jump_next, mode = { "i" } },
    { "<C-h>", require("neogen").jump_prev, mode = { "i" } },

    -- NvimTree setup
    { "<leader>fe", ":NvimTreeFocus <CR>", description = "Focus Nvim-tree" },
    { "<leader>ft", ":NvimTreeToggle <CR>", description = "Open Nvim-tree" },
    { "<leader>pt", ":NvimTreeToggle <CR>", description = "Open Nvim-tree" },
    { "<F9>", ":NvimTreeToggle <CR>", description = "Open Nvim-tree" },

    -- Packer keymaps
    { "<leader>PS", ":PackerStatus <CR>", description = "Status" },
    { "<leader>Pc", ":PackerCompile <CR>", description = "Compile" },
    { "<leader>Pi", ":PackerInstall <CR>", description = "Install" },
    { "<leader>Ps", ":PackerSync <CR>", description = "Sync" },
    { "<leader>Pu", ":PackerUpdate <CR>", description = "Update" },

    -- Project keymaps
    {
      "<leader>pp",
      function()
        require("telescope").extensions.projects.projects()
      end,
      description = "Projects",
    },

    -- Telescope keymaps
    {
      "<leader><leader>",
      function()
        require("telescope").extensions.frecency.frecency()
      end,
      description = "Rcent Files",
    },
    {
      "<leader>?",
      h.lazy_required_fn("telescope.builtin", "oldfiles"),
      description = "? Find recently opened files",
    },
    {
      "<leader>b/",
      function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require("telescope.builtin").current_buffer_fuzzy_find(
          require("telescope.themes").get_dropdown({ winblend = 10, previewer = false })
        )
      end,
      description = "/ Fuzzily search in current buffer",
    },
    { "<leader>bb", h.lazy_required_fn("telescope.builtin", "buffers"), description = "Find existing buffers" },
    { "<leader>f/", h.lazy_required_fn("telescope.builtin", "live_grep"), description = "Live Grep" },
    {
      "<leader>fa",
      h.lazy_required_fn("telescope.builtin", "find_files", { follow = true, no_ignore = true, hidden = true }),
      description = "All Files",
    },
    { "<leader>fd", h.lazy_required_fn("telescope.builtin", "diagnostics"), description = "Find Diagnostics" },
    { "<leader>ff", h.lazy_required_fn("telescope.builtin", "find_files"), description = "Find Files" },
    { "<leader>fw", h.lazy_required_fn("telescope.builtin", "grep_string"), description = "Find Word" },
    { "<leader>sh", h.lazy_required_fn("telescope.builtin", "help_tags"), description = "Search Help" },

    -- Terminal mappings
    { "<leader>ot", ":ToggleTerm <CR>", description = "Open Terminal" },
    { "<ESC>", "<C-\\><C-n>", mode = "t" },
    { "<C-w>h", "<C-\\><C-n><C-W>h", mode = "t" },
    { "<C-w>j", "<C-\\><C-n><C-W>j", mode = "t" },
    { "<C-w>k", "<C-\\><C-n><C-W>k", mode = "t" },
    { "<C-w>l", "<C-\\><C-n><C-W>l", mode = "t" },

    -- Truezen keymaps
    { "<leader>fz", ":TZAtaraxis <CR>", description = "Zen Mode" },
    { "<leader>za", ":TZAtaraxis <CR>", description = "Ataraxis Mode" },
    { "<leader>zf", ":TZFocus <CR>", description = "File Focus" },
    { "<leader>zm", ":TZMinimalist <CR>", description = "Minimal Mode" },
    { "<leader>zn", ":TZNarrow <CR>", description = "Narrow Mode" },
  }
end

legendary.setup({
  keymaps = M.default_keymaps(),
})
