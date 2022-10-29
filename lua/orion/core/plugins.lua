local plugins = {
  -- Some core packages that I need it no matter what kind of setup it is
  ["wbthomason/packer.nvim"] = { config = [[ require("orion.core.plugins") ]], commit = "6afb674" },
  ["lewis6991/impatient.nvim"] = { commit = "b842e16" },
  ["kyazdani42/nvim-web-devicons"] = { commit = "9061e2d" },
  ["kevinhwang91/promise-async"] = { commit = "70b0906" },
  ["nvim-lua/plenary.nvim"] = { commit = "4b7e520" },
  ["tami5/sqlite.lua"] = { commit = "47685f0" },

  -- Code highligting
  ["nvim-treesitter/nvim-treesitter"] = { config = [[require("orion.configs.treesitter") ]], commit = "9ada5f7" },
  ["nvim-treesitter/nvim-treesitter-context"] = {
    config = [[require("orion.configs.treesitter-context") ]],
    commit = "0dd5eae",
  },
  ["nvim-treesitter/nvim-treesitter-textobjects"] = {
    config = [[ require("orion.configs.treesitter-objects") ]],
    commit = "13739a5",
  },
  ---- Playground for debugging purpose
  ["nvim-treesitter/playground"] = {
    config = [[ require("orion.configs.playground") ]],
    cmd = "TSPlaygroundToggle",
    commit = "e6a0bfa",
  },

  -- LSP setup
  ["neovim/nvim-lspconfig"] = { config = [[require("orion.lsp") ]], commit = "2315a39" },
  ["williamboman/mason.nvim"] = { commit = "311a14f" },
  ["williamboman/mason-lspconfig.nvim"] = { commit = "a910b4d" },
  ---- LSP completion
  ["hrsh7th/nvim-cmp"] = { commit = "9bb8ee6" },
  ["hrsh7th/cmp-buffer"] = { commit = "3022dbc" },
  ["hrsh7th/cmp-nvim-lsp"] = { commit = "78924d1" },
  ["hrsh7th/cmp-path"] = { commit = "91ff86c" },
  ["hrsh7th/cmp-nvim-lsp-signature-help"] = { commit = "d2768cb" },
  ["hrsh7th/cmp-cmdline"] = { commit = "c66c379" },
  ---- LSP diagnostics
  ["folke/trouble.nvim"] = { config = [[require("orion.configs.trouble")]], commit = "ed65f84" },
  ---- LSP snippet
  ["L3MON4D3/LuaSnip"] = { commit = "663d544" },
  ["rafamadriz/friendly-snippets"] = { commit = "c93311f" },
  ["saadparwaiz1/cmp_luasnip"] = { commit = "1809552" },
  ---- LSP code formatting
  ["jose-elias-alvarez/null-ls.nvim"] = { commit = "f1add23" },
  ---- LSP code highligting
  ["RRethy/vim-illuminate"] = { config = [[require("orion.configs.illuminate") ]], commit = "0603e75" },
  ---- LSP tool
  ["j-hui/fidget.nvim"] = { config = [[ require("orion.configs.fidget") ]], commit = "2cf9997" },
  ---- LSP specific to programming
  ["b0o/SchemaStore.nvim"] = { commit = "0cd69c8" },
  ["folke/neodev.nvim"] = { commit = "1d5b7f0" },

  -- DAP - debbugger adapter protocol
  --- DAP Plugins
  ["mfussenegger/nvim-dap"] = { config = [[ require("orion.dap") ]], commit = "3d0d731" },
  ["rcarriga/nvim-dap-ui"] = { commit = "f889edb" },
  --- DAP Language specific
  ["mfussenegger/nvim-dap-python"] = { commit = "408186a" },

  -- Fuzzy Finder
  ["nvim-telescope/telescope.nvim"] = { config = [[require("orion.configs.telescope") ]], commit = "9784730" },
  ["nvim-telescope/telescope-file-browser.nvim"] = { commit = "2429ecf" },
  ["nvim-telescope/telescope-fzf-native.nvim"] = { run = "make", commit = "65c0ee3" },
  ["nvim-telescope/telescope-smart-history.nvim"] = { commit = "7eb278c" },

  -- Git
  ["TimUntersberger/neogit"] = { config = [[require("orion.configs.neogit") ]], cmd = "Neogit", commit = "1acb13c" },
  ["akinsho/git-conflict.nvim"] = { config = [[ require("orion.configs.git-conflict") ]], commit = "0f87781" },
  ["lewis6991/gitsigns.nvim"] = { config = [[require("orion.configs.gitsigns") ]], commit = "9110ea1" },
  ["sindrets/diffview.nvim"] = { config = [[require("orion.configs.diffview") ]], commit = "94a3422" },

  -- Programming
  ---- Movement
  ["chaoren/vim-wordmotion"] = { commit = "5dd613e" },
  ["ggandor/flit.nvim"] = { config = [[require("orion.configs.flit") ]], commit = "be110f9" },
  ["ggandor/leap.nvim"] = { config = [[require("orion.configs.leap") ]], commit = "847a1dc" },
  ["max397574/better-escape.nvim"] = { config = [[require("orion.configs.better-escape") ]], commit = "d5ee0ce" },
  ["stevearc/aerial.nvim"] = { config = [[require("orion.configs.aerial") ]], commit = "62b6ebb" },
  ["fedepujol/move.nvim"] = { commit = "2cd5335" },
  ["andymass/vim-matchup"] = { config = [[ require("orion.configs.matchup") ]], commit = "09576fd" },
  ["ThePrimeagen/harpoon"] = { config = [[ require("orion.configs.harpoon") ]], commit = "4dfe94e" },
  ---- Tools: folding, autopairs, surround, repeat, increment
  ["kevinhwang91/nvim-ufo"] = { config = [[require("orion.configs.ufo") ]], commit = "9d59d71" },
  ["kylechui/nvim-surround"] = { config = [[require("orion.configs.surround") ]], commit = "7e5096b" },
  ["tpope/vim-repeat"] = { commit = "24afe92" },
  ["windwp/nvim-autopairs"] = { config = [[require("orion.configs.autopairs") ]], commit = "6b6e35f" },
  ---- Writing
  ["danymat/neogen"] = { config = [[require("orion.configs.neogen") ]], commit = "c9ee823" },
  ["numToStr/Comment.nvim"] = { config = [[require("orion.configs.comment") ]], commit = "ad7ffa8" },
  ---- Language specific
  ["ellisonleao/glow.nvim"] = { cmd = "Glow", commit = "9038d7c" },
  ["nvim-orgmode/orgmode"] = { config = [[require("orion.configs.orgmode") ]], commit = "2479971" },
  ["phelipetls/jsonpath.nvim"] = { commit = "d52d1c1" },
  ---- Project management
  ["ahmedkhalf/project.nvim"] = { config = [[require("orion.configs.project") ]], commit = "628de7e" },
  ["gpanders/editorconfig.nvim"] = { commit = "7d10fe6" },

  -- UI
  ---- Buffer management
  ["akinsho/bufferline.nvim"] = { config = [[require("orion.configs.bufferline") ]], commit = "028a879" },
  ["famiu/bufdelete.nvim"] = { commit = "e88dbe0" },
  ---- Colorscheme
  ["EdenEast/nightfox.nvim"] = { commit = "db26a92" },
  ["Mofiqul/vscode.nvim"] = { commit = "920145b" },
  ["catppuccin/nvim"] = { as = "catppuccin", commit = "e695645" },
  ["ellisonleao/gruvbox.nvim"] = { commit = "e9992fe" },
  ["folke/tokyonight.nvim"] = { commit = "29e2c68" },
  ["navarasu/onedark.nvim"] = { commit = "cad3d98" },
  ["olimorris/onedarkpro.nvim"] = { commit = "62b12ba" },
  ["projekt0n/github-nvim-theme"] = { commit = "a0632f9" },
  ["rebelot/kanagawa.nvim"] = { commit = "70d3139" },
  ["shaunsingh/nord.nvim"] = { commit = "c8d932b" },
  ---- Dashboard
  ["goolord/alpha-nvim"] = { config = [[require("orion.configs.alpha") ]], commit = "0bb6fc0" },
  ---- Highlighting
  ["folke/todo-comments.nvim"] = { config = [[require("orion.configs.todo-comments") ]], commit = "530eb3a" },
  ["p00f/nvim-ts-rainbow"] = { config = [[ require("orion.configs.nvim-ts-rainbow") ]], commit = "1ec3f88" },
  ---- Indentation
  ["lukas-reineke/indent-blankline.nvim"] = {
    config = [[require("orion.configs.indent-blankline") ]],
    commit = "db7cbcb",
  },
  ---- Prductivity
  ["Pocco81/true-zen.nvim"] = { config = [[require("orion.configs.true-zen") ]], commit = "98740c7" },
  ---- Statusline
  ["nvim-lualine/lualine.nvim"] = { config = [[require("orion.configs.lualine") ]], commit = "3325d5d" },
  ---- quickfix
  ["kevinhwang91/nvim-bqf"] = { config = [[ require("orion.configs.bqf") ]], ft = "qf", commit = "6ed0319" },

  -- Tool
  ["NvChad/nvim-colorizer.lua"] = { config = [[require("orion.configs.colorizer") ]], commit = "760e27d" },
  -- ["Pocco81/auto-save.nvim"] = { config = [[require("orion.configs.auto-save") ]], commit = "2c7a294" },
  ["Shatur/neovim-session-manager"] = { config = [[require("orion.configs.session") ]], commit = "4005dac" },
  ["akinsho/toggleterm.nvim"] = { config = [[require("orion.configs.toggleterm") ]], commit = "8f302c9" },
  ["ibhagwan/smartyank.nvim"] = { config = [[ require("orion.configs.smartyank") ]], commit = "66dcb60" },
  ["kyazdani42/nvim-tree.lua"] = {
    config = [[require("orion.configs.nvim-tree") ]],
    cmd = "NvimTree*",
    commit = "3845039",
  },
  ["mrjones2014/tldr.nvim"] = { config = [[require("orion.configs.tldr") ]], commit = "72af17f" },
  ---- keymappings
  ["folke/which-key.nvim"] = { config = [[require("orion.configs.which-key") ]], commit = "61553ae" },

  -- Experimental
  ---- NOTE: disabling for now
  ---- messages, cmdline and popupmenu tweaker, Noice
  -- ["MunifTanjim/nui.nvim"] = { commit = "d12a697" },
  -- ["rcarriga/nvim-notify"] = { commit = "354e0eb" },
  -- ["folke/noice.nvim"] = { event = "VimEnter", config = [[ require("orion.configs.noice") ]], commit = "7b62ccf" },

  ---- Code Map
  ["gorbit99/codewindow.nvim"] = { config = [[ require("orion.configs.codewindow") ]], commit = "7123d6f" },
}

-- Load the plugins
local status_ok, packer = pcall(require, "packer")

if status_ok then
  vim.cmd([[packadd packer.nvim]])
  local packer_init = require("orion.configs.packer")
  packer.init(packer_init)

  for key, plugin in pairs(plugins) do
    if type(key) == "string" and not plugin[1] then
      plugin[1] = key
    end
    packer.use(plugin)
  end
end
