local status_ok, legendary = pcall(require, "legendary")

if not status_ok then
  return
end

local h = require("legendary.helpers")

-- NOTE: The keymap's mode defaults to normal (n)

--- defaults keymap for my config.
---@return array of keymapping.
local default_keymaps = function()
  return {
    -- Buffer managment keymaps
    { "<S-Tab>", ":bp <CR>", description = "[P]ext [B]uffer" },
    { "<Tab>", ":bn <CR>", description = "[N]ext [B]uffer" },
    { "<leader>bd", ":Bdelete <CR>", description = "[P]ext [B]uffer" },
    { "<leader>bn", ":bn <CR>", description = "[N]ext [B]uffer" },
    { "<leader>bp", ":bp <CR>", description = "[P]ext [B]uffer" },

    -- Diagnostic keymaps
    { "[d", vim.diagnostic.goto_prev },
    { "]d", vim.diagnostic.goto_next },
    { "<leader>e", vim.diagnostic.open_float },
    { "<leader>q", vim.diagnostic.setloclist },

    -- Git keymaps
    { "<leader>gg", ":Neogit <CR>", description = "[G]it [S]tatus" },

    -- Neogen keymaps
    { "<leader>nf", h.lazy_required_fn("neogen", "generate"), description = "[F]unc [D]oc" },
    { "<leader>nc", h.lazy_required_fn("neogen", "generate", { type = "class" }), description = "[F]unc [D]oc" },
    { "<C-l>", require("neogen").jump_next, mode = { "i" } },
    { "<C-h>", require("neogen").jump_prev, mode = { "i" } },

    -- NvimTree setup
    { "<leader>fe", ":NvimTreeFocus <CR>", description = "[F]ocus [N]vim-tree" },
    { "<leader>ft", ":NvimTreeToggle <CR>", description = "[O]pen [N]vim-tree" },
    { "<leader>pt", ":NvimTreeToggle <CR>", description = "[O]pen [N]vim-tree" },

    -- Packer keymaps
    { "<leader>PS", ":PackerStatus <CR>", description = "[S]tatus" },
    { "<leader>Pc", ":PackerCompile <CR>", description = "[C]ompile" },
    { "<leader>Pi", ":PackerInstall <CR>", description = "[I]nstall" },
    { "<leader>Ps", ":PackerSync <CR>", description = "[S]ync" },
    { "<leader>Pu", ":PackerUpdate <CR>", description = "[U]pdate" },

    -- Project keymaps
    {
      "<leader>pp",
      function()
        require("telescope").extensions.projects.projects()
      end,
      description = "[P]rojects",
    },

    -- Telescope keymaps
    {
      "<leader><leader>",
      function()
        require("telescope").extensions.frecency.frecency()
      end,
      description = "[R]cent [F]iles",
    },
    {
      "<leader>?",
      h.lazy_required_fn("telescope.builtin", "oldfiles"),
      description = "[?] Find recently opened files",
    },
    {
      "<leader>b/",
      function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require("telescope.builtin").current_buffer_fuzzy_find(
          require("telescope.themes").get_dropdown({ winblend = 10, previewer = false })
        )
      end,
      description = "[/] Fuzzily search in current buffer]",
    },
    { "<leader>bb", h.lazy_required_fn("telescope.builtin", "buffers"), description = "[F]ind existing buffers" },
    { "<leader>f/", h.lazy_required_fn("telescope.builtin", "live_grep"), description = "[L]ive [G]rep" },
    {
      "<leader>fa",
      h.lazy_required_fn("telescope.builtin", "find_files", { follow = true, no_ignore = true, hidden = true }),
      description = "[A]ll [F]iles",
    },
    { "<leader>fd", h.lazy_required_fn("telescope.builtin", "diagnostics"), description = "[F]ind [D]iagnostics" },
    { "<leader>ff", h.lazy_required_fn("telescope.builtin", "find_files"), description = "[F]ind [F]iles" },
    { "<leader>fw", h.lazy_required_fn("telescope.builtin", "grep_string"), description = "[F]ind [W]ord" },
    { "<leader>sh", h.lazy_required_fn("telescope.builtin", "help_tags"), description = "[S]earch [H]elp" },

    -- Terminal mappings
    { "<ESC>", "<C-\\><C-n>", mode = "t" },
    { "<C-w>h", "<C-\\><C-n><C-W>h", mode = "t" },
    { "<C-w>j", "<C-\\><C-n><C-W>j", mode = "t" },
    { "<C-w>k", "<C-\\><C-n><C-W>k", mode = "t" },
    { "<C-w>l", "<C-\\><C-n><C-W>l", mode = "t" },

    -- Truezen keymaps
    { "<leader>fz", ":TZAtaraxis <CR>", description = "[Z]en [M]ode" },
    { "<leader>za", ":TZAtaraxis <CR>", description = "[A]taraxis [M]ode" },
    { "<leader>zf", ":TZFocus <CR>", description = "[F]ile [F]ocus" },
    { "<leader>zm", ":TZMinimalist <CR>", description = "[M]inimal [M]ode" },
    { "<leader>zn", ":TZNarrow <CR>", description = "[N]arrow [M]ode" },
  }
end

legendary.setup({
  keymaps = default_keymaps(),
})
