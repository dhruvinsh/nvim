-- nvim-tree requirements
vim.g.loaded = 1

-- disable some built-in plugins
-- reference: https://github.com/mrjones2014/dotfiles/blob/master/.config/nvim/lua/disable-builtins.lua
local built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit",
}

vim.tbl_map(function(plugin)
  vim.g["loaded_" .. plugin] = 1
end, built_ins)

-- Main config starts here
-- Install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  vim.cmd([[packadd packer.nvim]])
end

require("packer").startup({
  function(use)
    use("wbthomason/packer.nvim") -- Package manager

    use({ "lewis6991/impatient.nvim" })

    -- Git
    use({
      {
        "TimUntersberger/neogit",
        cmd = "Neogit",
      },
      {
        "lewis6991/gitsigns.nvim",
        requires = { "nvim-lua/plenary.nvim" },
      },
    })

    -- programming
    use("numToStr/Comment.nvim")
    use({
      "danymat/neogen",
      config = function()
        require("neogen").setup({
          snippet_engine = "luasnip",
          enabled = true,
          languages = {
            python = {
              template = {
                annotation_convention = "reST",
              },
            },
          },
        })
      end,
      requires = "nvim-treesitter/nvim-treesitter",
    })
    use({
      "windwp/nvim-autopairs",
      config = [[ require("nvim-autopairs").setup() ]],
    })
    use({
      "kylechui/nvim-surround",
      tag = "*",
      config = [[ require("nvim-surround").setup() ]],
    })
    use({
      "kevinhwang91/nvim-ufo",
      requires = "kevinhwang91/promise-async",
      config = function()
        local ufo = require("ufo")

        vim.keymap.set("n", "zR", ufo.openAllFolds)
        vim.keymap.set("n", "zM", ufo.closeAllFolds)
        vim.keymap.set("n", "zr", ufo.openFoldsExceptKinds)
        vim.keymap.set("n", "zm", ufo.closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
        vim.keymap.set("n", "K", function()
          local winid = ufo.peekFoldedLinesUnderCursor()
          if not winid then
            vim.lsp.buf.hover()
          end
        end)
        ufo.setup({
          provider_selector = function(bufnr, filetype, buftype)
            return { "treesitter", "indent" }
          end,
        })
      end,
      setup = function()
        vim.o.foldcolumn = "1"
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true
      end,
    })

    -- Movement
    use({
      {
        "ggandor/leap.nvim",
        requires = { "tpope/vim-repeat" },
      },
      { "ggandor/flit.nvim", config = [[require('flit').setup { labeled_modes = 'nvm' }]] },
    })
    use({ "chaoren/vim-wordmotion" })
    use({
      "max397574/better-escape.nvim",
      config = [[ require("better_escape").setup() ]],
    })

    -- Highlight, edit, and navigate code
    use({
      "nvim-treesitter/nvim-treesitter",
      requires = {
        { "nvim-treesitter/nvim-treesitter-textobjects" }, -- Additional textobjects for treesitter
        {
          "nvim-treesitter/nvim-treesitter-context",
          -- default setup is good enough
          config = [[ require("treesitter-context").setup() ]],
        },
      },
    })

    -- lsp setup
    use("neovim/nvim-lspconfig") -- Collection of configurations for built-in LSP client
    use("williamboman/mason.nvim") -- Manage external editor tooling i.e LSP servers
    use("williamboman/mason-lspconfig.nvim") -- Automatically install language servers to stdpath
    use({
      "hrsh7th/nvim-cmp", -- Autocompletion
      requires = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
      },
    })
    use({ "L3MON4D3/LuaSnip", requires = { "saadparwaiz1/cmp_luasnip" } }) -- Snippet Engine and Snippet Expansion
    use({ "jose-elias-alvarez/null-ls.nvim" })

    -- colorscheme
    use("navarasu/onedark.nvim") -- Theme inspired by Atom
    use("ellisonleao/gruvbox.nvim")

    -- UI
    use("nvim-lualine/lualine.nvim") -- Fancier statusline

    -- Highlights
    use("lukas-reineke/indent-blankline.nvim") -- Add indentation guides even on blank lines
    use({
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = [[require("todo-comments").setup() ]],
    })

    use("tpope/vim-sleuth") -- Detect tabstop and shiftwidth automatically

    -- Fuzzy Finder (files, lsp, etc)
    use({
      "nvim-telescope/telescope.nvim",
      branch = "0.1.x",
      requires = {
        { "nvim-lua/plenary.nvim" },
        {
          -- Fuzzy Finder Algorithm
          "nvim-telescope/telescope-fzf-native.nvim",
          run = "make",
          cond = vim.fn.executable("make") == 1,
        },
        {
          "nvim-telescope/telescope-frecency.nvim",
          requires = "tami5/sqlite.lua",
        },
        {
          "nvim-telescope/telescope-smart-history.nvim",
        },
      },
    })

    use({ "folke/which-key.nvim" })

    use({ "kyazdani42/nvim-tree.lua", requires = { "kyazdani42/nvim-web-devicons" } })

    -- buffer managment
    use({
      "akinsho/bufferline.nvim",
      config = [[require("bufferline").setup()]],
      requires = "kyazdani42/nvim-web-devicons",
      tag = "v2.*",
    })

    -- terminal
    use({
      "akinsho/toggleterm.nvim",
      config = [[ require("toggleterm").setup() ]],
      cmd = "ToggleTerm",
      tag = "*",
    })

    -- project
    use({
      "ahmedkhalf/project.nvim",
      config = function()
        require("project_nvim").setup({
          patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "pyproject.toml", "Pipfile" },
          ignore_lsp = { "null-ls" },
          show_hidden = true,
        })
      end,
    })

    -- tool
    use("mrjones2014/tldr.nvim")

    use({
      "Pocco81/auto-save.nvim",
      event = "InsertEnter",
      config = function()
        require("auto-save").setup({
          condition = function(buf)
            local utils = require("auto-save.utils.data")

            -- certain filetype that I don't want auto-save
            local ignore_ft = { "NeogitCommitMessage", "NvimTree", "TelescopePrompt" }
            local detect_ft = vim.fn.getbufvar(buf, "&filetype")

            -- conditions where auto-save should work
            local is_modifiable = vim.fn.getbufvar(buf, "&modifiable")
            local is_ft_okay = utils.not_in(detect_ft, ignore_ft)

            if is_modifiable and is_ft_okay then
              return true
            end

            return false
          end,
        })
      end,
    })

    if is_bootstrap then
      require("packer").sync()
    end
  end,
  config = {
    display = {
      open_fn = function()
        local result, win, buf = require("packer.util").float({
          border = {
            { "╭", "FloatBorder" },
            { "─", "FloatBorder" },
            { "╮", "FloatBorder" },
            { "│", "FloatBorder" },
            { "╯", "FloatBorder" },
            { "─", "FloatBorder" },
            { "╰", "FloatBorder" },
            { "│", "FloatBorder" },
          },
        })
        vim.api.nvim_win_set_option(win, "winhighlight", "NormalFloat:Normal")
        return result, win, buf
      end,
    },
  },
})

require("impatient")
-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print("==================================")
  print("    Plugins are being installed")
  print("    Wait until Packer completes,")
  print("       then restart nvim")
  print("==================================")
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  command = "source <afile> | PackerCompile",
  group = packer_group,
  pattern = vim.fn.expand("$MYVIMRC"),
})

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set clipboard
vim.o.clipboard = "unnamedplus"

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

-- Set colorscheme
vim.o.termguicolors = true
-- require("onedark").load()
vim.o.background = "dark"
vim.cmd([[ colorscheme gruvbox ]])

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- Set lualine as statusline
-- See `:help lualine.txt`
require("lualine").setup({
  options = {
    icons_enabled = false,
    theme = "auto",
    component_separators = "|",
    section_separators = "",
  },
})

-- Enable Comment.nvim
require("Comment").setup()

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
require("indent_blankline").setup({
  char = "┊",
  show_trailing_blankline_indent = false,
})

-- Gitsigns
-- See `:help gitsigns.txt`
require("gitsigns").setup({
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
})

-- which-key
require("which-key").setup()

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require("telescope").setup({
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
pcall(require("telescope").load_extension, "frecency")
pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "projects")
pcall(require("telescope").load_extension, "smart_history")
pcall(require("telescope").load_extension, "tldr")

-- See `:help telescope.builtin`
vim.api.nvim_set_keymap("n", "<leader><leader>", "<Cmd>lua require('telescope').extensions.frecency.frecency()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader>bb", require("telescope.builtin").buffers, { desc = "[F]ind existing buffers" })
vim.keymap.set("n", "<leader>f/", require("telescope.builtin").live_grep, { desc = "[L]ive [G]rep" })
vim.keymap.set("n", "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", { desc = "[A]ll [F]iles" })
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

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require("nvim-treesitter.configs").setup({
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = {
    "c",
    "cpp",
    "go",
    "json",
    "lua",
    "python",
    "rust",
    "toml",
    "typescript",
  },

  highlight = { enable = true },
  indent = { enable = true, disable = { "python", "yaml" } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<c-space>",
      node_incremental = "<c-space>",
      -- TODO: I'm not sure for this one.
      scope_incremental = "<c-s>",
      node_decremental = "<c-backspace>",
    },
  },
  -- some external plugins config for treesitter
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
  },
})

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

  nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
  nmap("gr", require("telescope.builtin").lsp_references)
  nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
  nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

  -- See `:help K` for why this keymap
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

  -- Lesser used LSP functionality
  nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
  nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
  nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
  nmap("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "[W]orkspace [L]ist Folders")

  -- Create a command `:Format` local to the LSP buffer and add keymaps
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    if vim.lsp.buf.format then
      vim.lsp.buf.format({ async = true })
    elseif vim.lsp.buf.formatting then
      vim.lsp.buf.formatting()
    end
  end, { desc = "Format current buffer with LSP" })
end
vim.keymap.set("n", "<leader>bf", "<cmd>Format <CR>", { desc = "[F]ormat" })

-- nvim-cmp supports additional completion capabilities
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Setup mason so it can manage external tooling
require("mason").setup()

-- Enable the following language servers
local servers = { "clangd", "rust_analyzer", "pyright", "tsserver", "sumneko_lua" }

-- Ensure the servers above are installed
require("mason-lspconfig").setup({
  ensure_installed = servers,
})

for _, lsp in ipairs(servers) do
  require("lspconfig")[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

-- Example custom configuration for lua
--
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require("lspconfig").sumneko_lua.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT)
        version = "LuaJIT",
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = { library = vim.api.nvim_get_runtime_file("", true) },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = { enable = false },
    },
  },
})

-- nvim-cmp setup
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif require("neogen").jumpable() then
        require("neogen").jump_next()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      elseif require("neogen").jumpable(true) then
        require("neogen").jump_prev()
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
    { name = "nvim_lua" },
  },
})

-- nvim-autopairs and nvim-cmp <CR> mapping
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

-- null-ls setup
local nbuiltins = require("null-ls").builtins
require("null-ls").setup({
  debug = true,
  sources = {
    -- webdev stuff
    nbuiltins.formatting.prettier,

    -- Lua
    nbuiltins.formatting.stylua,
    nbuiltins.diagnostics.selene,

    -- Shell
    nbuiltins.formatting.shfmt,
    nbuiltins.diagnostics.shellcheck,

    -- python
    nbuiltins.formatting.black,
    nbuiltins.formatting.isort,
    nbuiltins.diagnostics.mypy,
    nbuiltins.diagnostics.pylint,
  },
})

-- nvim-tree setup
require("nvim-tree").setup()
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

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
