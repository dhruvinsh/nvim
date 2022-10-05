-- n, v, i, t = mode names

local function termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local M = {}

-- Buffer managment keymaps
M.buffer = {
  n = {
    ["<S-Tab>"] = { ":bp <CR>", description = "Pext Buffer" },
    ["<Tab>"] = { ":bn <CR>", description = "Next Buffer" },
    ["<leader>bd"] = { ":Bdelete <CR>", description = "Pext Buffer" },
    ["<leader>bn"] = { ":bn <CR>", description = "Next Buffer" },
    ["<leader>bp"] = { ":bp <CR>", description = "Pext Buffer" },
  }
}

-- Diagnostic keymaps
M.diagnostic = {
  n = {
    ["[d"] = { vim.diagnostic.goto_prev },
    ["]d"] = { vim.diagnostic.goto_next },
    ["<leader>e"] = { vim.diagnostic.open_float },
    ["<leader>q"] = { vim.diagnostic.setloclist },
  }
}

-- Git keymaps
M.git = {
  n = {
    ["<leader>gg"] = { ":Neogit <CR>", description = "Git Status" },
  },
}

-- Move keymaps
M.move = {
  n = {
    ["<A-h>"] = { ":MoveHChar(-1)<CR>", description = "Move text left" },
    ["<A-j>"] = { ":MoveLine(1)<CR>", description = "Move text down" },
    ["<A-k>"] = { ":MoveLine(-1)<CR>", description = "Move text up" },
    ["<A- l>"] = { ":MoveHChar(1)<CR>", description = "Move text right" },
  },
  v = {
    ["<A-h>"] = { ":MoveHBlock(-1)<CR>", description = "Move text left" },
    ["<A-j>"] = { ":MoveBlock(1)<CR>", description = "Move text down" },
    ["<A-k>"] = { ":MoveBlock(-1)<CR>", description = "Move text up" },
    ["<A- l>"] = { ":MoveHBlock(1)<CR>", description = "Move text right" },
  },
}

-- Neogen keymaps
M.neogen = {
  n = {
    ["<leader>nf"] = { require("neogen").generate(), description = "Func Doc" },
    ["<leader>nc"] = { require("neogen").generate({ type = "class" }), description = "Func Doc" },
  },
  i = {
    ["<C-l>"] = { require("neogen").jump_next },
    ["<C-h>"] = { require("neogen").jump_prev },
  },
}

-- NvimTree setup
M.nvimtree = {
  ["<leader>fe"] = { ":NvimTreeFocus <CR>", description = "Focus Nvim-tree" },
  ["<leader>ft"] = { ":NvimTreeToggle <CR>", description = "Open Nvim-tree" },
  ["<leader>pt"] = { ":NvimTreeToggle <CR>", description = "Open Nvim-tree" },
  ["<F9>"] = { ":NvimTreeToggle <CR>", description = "Open Nvim-tree" },
}

local defaults = {

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

M.general = {
  i = {
    -- go to  beginning and end
    ["<C-b>"] = { "<ESC>^i", "beginning of line" },
    ["<C-e>"] = { "<End>", "end of line" },

    -- navigate within insert mode
    ["<C-h>"] = { "<Left>", "move left" },
    ["<C-l>"] = { "<Right>", "move right" },
    ["<C-j>"] = { "<Down>", "move down" },
    ["<C-k>"] = { "<Up>", "move up" },
  },

  n = {
    ["<ESC>"] = { "<cmd> noh <CR>", "no highlight" },

    -- switch between windows
    ["<C-h>"] = { "<C-w>h", "window left" },
    ["<C-l>"] = { "<C-w>l", "window right" },
    ["<C-j>"] = { "<C-w>j", "window down" },
    ["<C-k>"] = { "<C-w>k", "window up" },

    -- save
    ["<C-s>"] = { "<cmd> w <CR>", "save file" },

    -- Copy all
    ["<C-c>"] = { "<cmd> %y+ <CR>", "copy whole file" },

    -- line numbers
    ["<leader>n"] = { "<cmd> set nu! <CR>", "toggle line number" },
    ["<leader>rn"] = { "<cmd> set rnu! <CR>", "toggle relative number" },

    -- update nvchad
    ["<leader>uu"] = { "<cmd> :NvChadUpdate <CR>", "update nvchad" },

    ["<leader>tt"] = {
      function()
        require("base46").toggle_theme()
      end,
      "toggle theme",
    },

    -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
    -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
    -- empty mode is same as using <cmd> :map
    -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },

    -- new buffer
    ["<leader>b"] = { "<cmd> enew <CR>", "new buffer" },
  },

  t = { ["<C-x>"] = { termcodes "<C-\\><C-N>", "escape terminal mode" } },

  v = {
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
  },

  x = {
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    -- Don't copy the replaced text after pasting in visual mode
    -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
    ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', opts = { silent = true } },
  },
}

M.tabufline = {
  plugin = true,

  n = {
    -- cycle through buffers
    ["<TAB>"] = {
      function()
        require("nvchad_ui.tabufline").tabuflineNext()
      end,
      "goto next buffer",
    },

    ["<S-Tab>"] = {
      function()
        require("nvchad_ui.tabufline").tabuflinePrev()
      end,
      "goto prev buffer",
    },

    -- pick buffers via numbers
    ["<Bslash>"] = { "<cmd> TbufPick <CR>", "Pick buffer" },

    -- close buffer + hide terminal buffer
    ["<leader>x"] = {
      function()
        require("nvchad_ui.tabufline").close_buffer()
      end,
      "close buffer",
    },
  },
}

M.comment = {
  plugin = true,

  -- toggle comment in both modes
  n = {
    ["<leader>/"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "toggle comment",
    },
  },

  v = {
    ["<leader>/"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "toggle comment",
    },
  },
}

M.lspconfig = {
  plugin = true,

  -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

  n = {
    ["gD"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      "lsp declaration",
    },

    ["gd"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "lsp definition",
    },

    ["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "lsp hover",
    },

    ["gi"] = {
      function()
        vim.lsp.buf.implementation()
      end,
      "lsp implementation",
    },

    ["<leader>ls"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "lsp signature_help",
    },

    ["<leader>D"] = {
      function()
        vim.lsp.buf.type_definition()
      end,
      "lsp definition type",
    },

    ["<leader>ra"] = {
      function()
        require("nvchad_ui.renamer").open()
      end,
      "lsp rename",
    },

    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "lsp code_action",
    },

    ["gr"] = {
      function()
        vim.lsp.buf.references()
      end,
      "lsp references",
    },

    ["<leader>f"] = {
      function()
        vim.diagnostic.open_float()
      end,
      "floating diagnostic",
    },

    ["[d"] = {
      function()
        vim.diagnostic.goto_prev()
      end,
      "goto prev",
    },

    ["d]"] = {
      function()
        vim.diagnostic.goto_next()
      end,
      "goto_next",
    },

    ["<leader>q"] = {
      function()
        vim.diagnostic.setloclist()
      end,
      "diagnostic setloclist",
    },

    ["<leader>fm"] = {
      function()
        vim.lsp.buf.formatting {}
      end,
      "lsp formatting",
    },

    ["<leader>wa"] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      "add workspace folder",
    },

    ["<leader>wr"] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      "remove workspace folder",
    },

    ["<leader>wl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "list workspace folders",
    },
  },
}

M.nvimtree = {
  plugin = true,

  n = {
    -- toggle
    ["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },

    -- focus
    ["<leader>e"] = { "<cmd> NvimTreeFocus <CR>", "focus nvimtree" },
  },
}

M.telescope = {
  plugin = true,

  n = {
    -- find
    ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "find files" },
    ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "find all" },
    ["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "live grep" },
    ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "find buffers" },
    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "help page" },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "find oldfiles" },
    ["<leader>tk"] = { "<cmd> Telescope keymaps <CR>", "show keys" },

    -- git
    ["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "git commits" },
    ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "git status" },

    -- pick a hidden term
    ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "pick hidden term" },

    -- theme switcher
    ["<leader>th"] = { "<cmd> Telescope themes <CR>", "nvchad themes" },
  },
}

M.nvterm = {
  plugin = true,

  t = {
    -- toggle in terminal mode
    ["<A-i>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "toggle floating term",
    },

    ["<A-h>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "toggle horizontal term",
    },

    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "toggle vertical term",
    },
  },

  n = {
    -- toggle in normal mode
    ["<A-i>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "toggle floating term",
    },

    ["<A-h>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "toggle horizontal term",
    },

    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "toggle vertical term",
    },

    -- new

    ["<leader>h"] = {
      function()
        require("nvterm.terminal").new "horizontal"
      end,
      "new horizontal term",
    },

    ["<leader>v"] = {
      function()
        require("nvterm.terminal").new "vertical"
      end,
      "new vertical term",
    },
  },
}

M.whichkey = {
  plugin = true,

  n = {
    ["<leader>wK"] = {
      function()
        vim.cmd "WhichKey"
      end,
      "which-key all keymaps",
    },
    ["<leader>wk"] = {
      function()
        local input = vim.fn.input "WhichKey: "
        vim.cmd("WhichKey " .. input)
      end,
      "which-key query lookup",
    },
  },
}

M.blankline = {
  plugin = true,

  n = {
    ["<leader>cc"] = {
      function()
        local ok, start = require("indent_blankline.utils").get_current_context(
          vim.g.indent_blankline_context_patterns,
          vim.g.indent_blankline_use_treesitter_scope
        )

        if ok then
          vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
          vim.cmd [[normal! _]]
        end
      end,

      "Jump to current_context",
    },
  },
}

return M


local h = require("legendary.helpers")

-- NOTE: The keymap's mode defaults to normal (n)

--- defaults keymap for my config.
---@return array of keymapping.
M.default_keymaps = function()
  return {

  }
end

-- Some keymaps that being used for LSP
M.lsp_keymaps = function(bufnr)
  -- if the buffer already has LSP keymaps bound, do nothing
  if #vim.tbl_filter(function(keymap)
    return (keymap.desc or ""):lower() == "rename symbol"
  end, vim.api.nvim_buf_get_keymap(bufnr, "n")) > 0
  then
    return {}
  end

  return {
    {
      "gh",
      function()
        -- I have diagnostics float on CursorHold,
        -- disable that if I've manually shown the hover window
        -- see autocmds.lua, lsp_autocmds()
        vim.cmd.set("eventignore=CursorHold")
        vim.lsp.buf.hover()
        require("legendary").bind_autocmds({
          "CursorMoved",
          ":set eventignore=\"\"",
          opts = { pattern = "<buffer>", once = true },
        })
      end,
      description = "Show hover information",
      opts = { buffer = bufnr },
    },
    { "gs", vim.lsp.buf.signature_help, description = "Show signature help", opts = { buffer = bufnr } },
    {
      "gr",
      h.lazy_required_fn("telescope.builtin", "lsp_references"),
      description = "Find references",
      opts = { buffer = bufnr },
    },
    { "gd", vim.lsp.buf.definition, description = "Go to definition", opts = { buffer = bufnr } },
    { "gi", vim.lsp.buf.implementation, description = "Go to implementation", opts = { buffer = bufnr } },
    { "gt", vim.lsp.buf.type_definition, description = "Go to type definition", opts = { buffer = bufnr } },
    { "<leader>rn", vim.lsp.buf.rename, description = "Rename symbol", opts = { buffer = bufnr } },
    {
      "gpd",
      h.lazy_required_fn("goto-preview", "goto_preview_definition"),
      description = "Peek definition",
      opts = { buffer = bufnr },
    },
    {
      "gpi",
      h.lazy_required_fn("goto-preview", "goto_preview_implementation"),
      description = "Peek implementation",
      opts = { buffer = bufnr },
    },
    {
      "<leader>gd",
      h.vsplit_then(vim.lsp.buf.definition),
      description = "Go to definition in split",
      opts = { buffer = bufnr },
    },
    {
      "<leader>gi",
      h.vsplit_then(vim.lsp.buf.implementation),
      description = "Go to implementation in split",
      opts = { buffer = bufnr },
    },
    {
      "<leader>gt",
      h.vsplit_then(vim.lsp.buf.type_definition),
      description = "Go to type definition in split",
      opts = { buffer = bufnr },
    },
    { "F", vim.lsp.buf.code_action, description = "Show code actions", opts = { buffer = bufnr } },
    {
      "<leader>p",
      vim.diagnostic.goto_prev,
      description = "Go to previous diagnostic item",
      opts = { buffer = bufnr },
    },
    { "<leader>n", vim.diagnostic.goto_next, description = "Go to next diagnostic item", opts = { buffer = bufnr } },
  }
end

M.aerial = function(bufnr)
  return {
    -- Jump forwards/backwards with '{' and '}'
    { "{", "<cmd>AerialPrev<cr>", description = "Jump backwards in Aerial", opts = { buffer = bufnr } },
    { "}", "<cmd>AerialNext<cr>", description = "Jump forwards in Aerial", opts = { buffer = bufnr } },
    -- Jump up the tree with '[[' or ']]'
    { "[[", "<cmd>AerialPrevUp<cr>", description = "Jump up and backwards in Aerial", opts = { buffer = bufnr } },
    { "]]", "<cmd>AerialNextUp<cr>", description = "Jump up and forwards in Aerial", opts = { buffer = bufnr } },
  }
end
print(defaults)
return M
