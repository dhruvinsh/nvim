local M = {}
local util = require("orion.core.util")

M.core = {
  n = {
    ["<Space>"] = { "<Nop>" },
    ["j"] = { "v:count == 0 ? 'gj' : 'j'", "", { expr = true } },
    ["k"] = { "v:count == 0 ? 'gk' : 'k'", "", { expr = true } },
  },
  v = {
    ["<Space>"] = { "<Nop>" },
  },
}

M.autosave = {
  n = {
    ["<F3>"] = { ":ASToggle <CR>", "autosave toggle" },
  },
}

-- Buffer managment keymaps
M.buffer = {
  n = {
    ["<S-Tab>"] = { ":bp <CR>", "Next Buffer" },
    ["<Tab>"] = { ":bn <CR>", "Next Buffer" },
    ["<leader>bd"] = { ":Bdelete <CR>", "Delete Buffer" },
    ["<leader>bn"] = { ":bn <CR>", "Next Buffer" },
    ["<leader>bp"] = { ":bp <CR>", "Pext Buffer" },
  },
}

-- Codewindow keymaps
M.codewindow = {
  n = {
    ["<leader>mm"] = {
      -- FIX: once the pull request is merged this code is not require
      function()
        local ok, window = pcall(require, "codewindow.window")
        if not ok then
          return
        end

        if window.is_minimap_open() then
          util.lazy_required_fn("codewindow", "close_minimap")()
        else
          util.lazy_required_fn("codewindow", "open_minimap")()
        end
      end,
      "Minimap Toggle",
    },
    ["<leader>mf"] = { util.lazy_required_fn("codewindow", "toggle_focus"), "Focus Minimap" },
  },
}

M.dap = {
  n = {
    ["<leader>dC"] = { util.lazy_required_fn("dap", "run_to_cursor"), "Run to Cursor" },
    ["<leader>dU"] = { util.lazy_required_fn("dapui", "toggle"), "Toggle UI" },
    ["<leader>db"] = { util.lazy_required_fn("dap", "step_back"), "Step Back" },
    ["<leader>dc"] = { util.lazy_required_fn("dap", "continue"), "Continue" },
    ["<leader>dd"] = { util.lazy_required_fn("dap", "disconnect"), "Disconnect" },
    ["<leader>dg"] = { util.lazy_required_fn("dap", "session"), "Get Session" },
    ["<leader>di"] = { util.lazy_required_fn("dap", "step_into"), "Step Into" },
    ["<leader>do"] = { util.lazy_required_fn("dap", "step_over"), "Step Over" },
    ["<leader>dp"] = { util.lazy_required_fn("dap", "pause"), "Pause" },
    ["<leader>dq"] = { util.lazy_required_fn("dap", "close"), "Quit" },
    ["<leader>dr"] = { util.lazy_required_fn("dap", "repl.toggle"), "Toggle Repl" },
    ["<leader>ds"] = { util.lazy_required_fn("dap", "continue"), "Start" },
    ["<leader>dt"] = { util.lazy_required_fn("dap", "toggle_breakpoint"), "Toggle Breakpoint" },
    ["<leader>du"] = { util.lazy_required_fn("dap", "step_out"), "Step Out" },
  },
}

-- gitsigns keymaps
M.gitsigns = {
  n = {
    ["<leader>gb"] = { util.lazy_required_fn("gitsigns", "blame_line"), "Blame" },
    ["<leader>gn"] = { util.lazy_required_fn("gitsigns", "next_hunk", { navigation_message = false }), "Next Hunk" },
    ["<leader>gp"] = { util.lazy_required_fn("gitsigns", "prev_hunk", { navigation_message = false }), "Prev Hunk" },
  },
}

M.illuminate = {
  n = {
    ["<A-n>"] = { ":lua require('illuminate').next_reference{wrap=true, silent=true}<cr>" },
    ["<A-p>"] = { ":lua require('illuminate').next_reference{reverse=true,wrap=true, silent=true}<cr>" },
  },
}

-- Move keymaps
M.move = {
  n = {
    ["<A-h>"] = { ":MoveHChar(-1) <CR>", "Move text left" },
    ["<A-j>"] = { ":MoveLine(1) <CR>", "Move text down" },
    ["<A-k>"] = { ":MoveLine(-1) <CR>", "Move text up" },
    ["<A- l>"] = { ":MoveHChar(1) <CR>", "Move text right" },
  },
  v = {
    ["<A-h>"] = { ":MoveHBlock(-1) <CR>", "Move text left" },
    ["<A-j>"] = { ":MoveBlock(1) <CR>", "Move text down" },
    ["<A-k>"] = { ":MoveBlock(-1) <CR>", "Move text up" },
    ["<A- l>"] = { ":MoveHBlock(1) <CR>", "Move text right" },
  },
}

-- Neogen keymaps
M.neogen = {
  n = {
    ["<leader>nf"] = { ":Neogen func <CR>", "Func Doc" },
    ["<leader>nc"] = { ":Neogen class <CR>", "Class Doc" },
  },
  i = {
    ["<C-l>"] = { util.lazy_required_fn("neogen", "jump_next") },
    ["<C-h>"] = { util.lazy_required_fn("neogen", "jump_prev") },
  },
}

-- Neogit keymaps
M.neogit = {
  n = {
    ["<leader>gg"] = { ":Neogit <CR>", "Git Status" },
  },
}

-- NvimTree setup
M.nvimtree = {
  n = {
    ["<leader>fe"] = { ":NvimTreeFocus <CR>", "Focus Nvim-tree" },
    ["<leader>ft"] = { ":NvimTreeToggle <CR>", "Open Nvim-tree" },
    ["<leader>pt"] = { ":NvimTreeToggle <CR>", "Open Nvim-tree" },
    ["<F9>"] = { ":NvimTreeToggle <CR>", "Open Nvim-tree" },
  },
}

-- Packer keymaps
M.packer = {
  n = {
    ["<leader>Pc"] = { ":PackerCompile <CR>", "Compile" },
    ["<leader>Pi"] = { ":PackerInstall <CR>", "Install" },
    ["<leader>Ps"] = { ":PackerStatus <CR>", "Status" },
    ["<leader>Pu"] = { ":PackerUpdate <CR>", "Update" },
  },
}

-- Project keymaps
M.project = {
  n = {
    ["<leader>pp"] = { ":Telescope projects <CR>", "Projects" },
  },
}

-- Telescope keymaps
M.telescope = {
  n = {
    ["<leader><leader>"] = { ":Telescope frecency workspace=CWD <CR>", "Find Files (frecency)" },
    ["<leader>fr"] = { ":Telescope frecency <CR>", "Recent Files" },
    ["<leader>'"] = { ":Telescope current_buffer_fuzzy_find winblend=10, previewer=false <CR>", "Search in buffer" },
    ["<leader>bb"] = { ":Telescope buffers <CR>", "Find existing buffers" },
    ["<leader>/"] = { ":Telescope live_grep <CR>", "Live Grep" },

    ["<leader>fa"] = {
      ":Telescope find_files follow=true, no_ignore=true, hidden=true <CR>",
      "All Files",
    },
    ["<leader>fd"] = { ":Telescope diagnostics <CR>", "Find Diagnostics" },
    ["<leader>ff"] = { ":Telescope find_files <CR>", "Find Files" },
    ["<leader>fw"] = { ":Telescope grep_string <CR>", "Find Word" },
    ["<leader>sh"] = { ":Telescope help_tags <CR>", "Help" },
  },
}

-- Terminal mappings
M.terminal = {
  n = {
    ["<leader>ot"] = { ":ToggleTerm <CR>", "Open Terminal" },
  },
  t = {
    ["<ESC>"] = { "<C-\\><C-n>" },
    ["<C-w>h"] = { "<C-\\><C-n><C-W>h" },
    ["<C-w>j"] = { "<C-\\><C-n><C-W>j" },
    ["<C-w>k"] = { "<C-\\><C-n><C-W>k" },
    ["<C-w>l"] = { "<C-\\><C-n><C-W>l" },
  },
}

-- Truezen keymaps
M.truzen = {
  n = {
    ["<leader>fz"] = { ":TZAtaraxis <CR>", "Zen Mode" },
    ["<leader>za"] = { ":TZAtaraxis <CR>", "Ataraxis Mode" },
    ["<leader>zf"] = { ":TZFocus <CR>", "File Focus" },
    ["<leader>zm"] = { ":TZMinimalist <CR>", "Minimal Mode" },
    ["<leader>zn"] = { ":TZNarrow <CR>", "Narrow Mode" },
  },
}

M.lsp_control = {
  n = {
    ["<leader>lli"] = { ":LspInfo <CR>", "Info" },
    ["<leader>lll"] = { ":LspLog <CR>", "Log" },
    ["<leader>llr"] = { ":LspRestart <CR>", "Restart" },
    ["<leader>lls"] = { ":LspStart <CR>", "Start" },
    ["<leader>llx"] = { ":LspStop <CR>", "Stop" },
  },
}

M.lsp = function(bufnr)
  local normal_mappings = {
    -- aerial keymaps
    ["{"] = { ":AerialPrev <CR>", "AerialPrev", { buffer = bufnr } },
    ["}"] = { ":AerialNext <CR>", "AerialNext", { buffer = bufnr } },
    ["[["] = { ":AerialPrevUp <CR>", "AerialPrevUp", { buffer = bufnr } },
    ["]]"] = { ":AerialNextUp <CR>", "AerialNextUp", { buffer = bufnr } },

    ["<leader>la"] = { vim.lsp.buf.code_action, "Action", { buffer = bufnr } },
    ["<leader>ld"] = { vim.lsp.buf.type_definition, "Definition", { buffer = bufnr } },
    ["<leader>lj"] = { ":lua vim.diagnostic.goto_next({buffer=0}) <CR>", "Next Diagnostics", { buffer = bufnr } },
    ["<leader>lk"] = { ":lua vim.diagnostic.goto_prev({buffer=0}) <CR>", "Prev Diagnostics", { buffer = bufnr } },
    ["<leader>lq"] = { vim.diagnostic.setloclist, "Diagnostics Locations", { buffer = bufnr } },
    ["<leader>lr"] = { vim.lsp.buf.rename, "Rename", { buffer = bufnr } },
    ["<leader>ls"] = { ":Telescope lsp_document_symbols <CR>", "Symbols", { buffer = bufnr } },

    ["<C-k>"] = { vim.lsp.buf.signature_help, "Signature", { buffer = bufnr } },
    ["K"] = { vim.lsp.buf.hover, "Hover", { buffer = bufnr } },
    ["gD"] = { vim.lsp.buf.declaration, "Declaration", { buffer = bufnr } },
    ["gI"] = { vim.lsp.buf.implementation, "Implementation", { buffer = bufnr } },
    ["gR"] = { ":Telescope lsp_references <CR>", "Reference (Telescope)", { buffer = bufnr } },
    ["gd"] = { vim.lsp.buf.definition, "Definition", { buffer = bufnr } },
    ["gl"] = { vim.diagnostic.open_float, "Float", { buffer = bufnr } },
    ["gr"] = { vim.lsp.buf.references, "Reference", { buffer = bufnr } },

    -- workspace keymaps
    ["<leader><Tab>a"] = { vim.lsp.buf.add_workspace_folder, "Add folder", { buffer = bufnr } },
    ["<leader><Tab>r"] = { vim.lsp.buf.remove_workspace_folder, "Remove folder", { buffer = bufnr } },
    ["<leader><Tab>s"] = { ":Telescope lsp_dynamic_workspace_symbols <CR>", "Symbols", { buffer = bufnr } },
    ["<leader><Tab>l"] = {
      function()
        vim.pretty_print(vim.lsp.buf.list_workspace_folders())
      end,
      "List folders",
      { buffer = bufnr },
    },

    -- format
    ["<leader>bf"] = {
      function()
        vim.lsp.buf.format({ async = true })
      end,
      "Format",
      { buffer = bufnr },
    },
  }

  return { n = normal_mappings }
end

-- lets register all the keymaps
util.setup_groups_keymap(M)

return M
