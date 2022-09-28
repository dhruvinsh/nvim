local status_ok, wk = pcall(require, "which-key")

if status_ok then
  wk.setup()
  -- See `:help telescope.builtin`
  vim.api.nvim_set_keymap(
    "n",
    "<leader><leader>",
    "<Cmd>lua require('telescope').extensions.frecency.frecency()<CR>",
    { noremap = true, silent = true }
  )
  vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
  vim.keymap.set("n", "<leader>bb", require("telescope.builtin").buffers, { desc = "[F]ind existing buffers" })
  vim.keymap.set("n", "<leader>f/", require("telescope.builtin").live_grep, { desc = "[L]ive [G]rep" })
  vim.keymap.set(
    "n",
    "<leader>fa",
    "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>",
    { desc = "[A]ll [F]iles" }
  )
  vim.keymap.set("n", "<leader>fd", require("telescope.builtin").diagnostics, { desc = "[F]ind [D]iagnostics" })
  vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "[F]ind [F]iles" })
  vim.keymap.set("n", "<leader>fw", require("telescope.builtin").grep_string, { desc = "[F]ind [W]ord" })
  vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
  vim.keymap.set("n", "<leader>b/", function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
      winblend = 10,
      previewer = false,
    }))
  end, { desc = "[/] Fuzzily search in current buffer]" })

  -- nvim-tree setup
  vim.keymap.set("n", "<leader>ft", "<cmd>NvimTreeToggle <CR>", { desc = "[O]pen [N]vim-tree" })
  vim.keymap.set("n", "<leader>pt", "<cmd>NvimTreeToggle <CR>", { desc = "[O]pen [N]vim-tree" })
  vim.keymap.set("n", "<leader>fe", "<cmd>NvimTreeFocus <CR>", { desc = "[F]ocus [N]vim-tree" })

  -- neogit keymaps
  vim.keymap.set("n", "<leader>gg", "<cmd>Neogit <CR>", { desc = "[G]it [S]tatus" })

  -- buffer managment keymaps
  vim.keymap.set("n", "<Tab>", "<cmd>bnext <CR>", { desc = "[N]ext [B]uffer" })
  vim.keymap.set("n", "<leader>bn", "<cmd>bnext <CR>", { desc = "[N]ext [B]uffer" })
  vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious <CR>", { desc = "[P]ext [B]uffer" })
  vim.keymap.set("n", "<leader>bp", "<cmd>bprevious <CR>", { desc = "[P]ext [B]uffer" })
  vim.keymap.set("n", "<leader>bd", "<cmd>bdelete <CR>", { desc = "[P]ext [B]uffer" })

  -- packer keymaps
  vim.keymap.set("n", "<leader>PS", "<cmd>PackerStatus <CR>", { desc = "[S]tatus" })
  vim.keymap.set("n", "<leader>Pc", "<cmd>PackerCompile <CR>", { desc = "[C]ompile" })
  vim.keymap.set("n", "<leader>Pi", "<cmd>PackerInstall <CR>", { desc = "[I]nstall" })
  vim.keymap.set("n", "<leader>Ps", "<cmd>PackerSync <CR>", { desc = "[S]ync" })
  vim.keymap.set("n", "<leader>Pu", "<cmd>PackerUpdate <CR>", { desc = "[U]pdate" })

  -- project keymaps
  vim.keymap.set("n", "<leader>pp", "<cmd>Telescope projects <CR>", { desc = "[P]rojects" })

  -- neogen keymaps
  vim.keymap.set("n", "<leader>nf", ":lua require('neogen').generate() <CR>", { desc = "[F]unc [D]oc" })
  vim.keymap.set("n", "<leader>nc", ":lua require('neogen').generate({type='class'}) <CR>", { desc = "[F]unc [D]oc" })
  vim.keymap.set("i", "<C-l>", ":lua require('neogen').jump_next<CR>")
  vim.keymap.set("i", "<C-h>", ":lua require('neogen').jump_prev<CR>")

  -- terminal keymaps
  vim.keymap.set("n", "<C-w>h", "<C-\\><C-n><C-W>h")
  vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
  vim.keymap.set("t", "<C-w>h", "<C-\\><C-n><C-W>h")
  vim.keymap.set("t", "<C-w>j", "<C-\\><C-n><C-W>j")
  vim.keymap.set("t", "<C-w>k", "<C-\\><C-n><C-W>k")
  vim.keymap.set("t", "<C-w>l", "<C-\\><C-n><C-W>l")

  -- truezen keymaps
  vim.keymap.set("n", "<leader>fz", "<cmd>TZAtaraxis <CR>", { desc = "[Z]en [M]ode" })
  vim.keymap.set("n", "<leader>za", "<cmd>TZAtaraxis <CR>", { desc = "[A]taraxis [M]ode" })
  vim.keymap.set("n", "<leader>zf", "<cmd>TZFocus <CR>", { desc = "[F]ile [F]ocus" })
  vim.keymap.set("n", "<leader>zm", "<cmd>TZMinimalist <CR>", { desc = "[M]inimal [M]ode" })
  vim.keymap.set("n", "<leader>zn", "<cmd>TZNarrow <CR>", { desc = "[N]arrow [M]ode" })

  -- windows keymap
  vim.keymap.set("n", "<leader>w", "<C-w>", { desc = "[W]indows" })

  -- Diagnostic keymaps
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
  vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
  vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
end
