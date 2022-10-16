local plugins = {
  -- Some core packages that I need it no matter what kind of setup it is
  ["wbthomason/packer.nvim"] = { config = [[ require("orion.core.plugins") ]], commit = "6afb674" },
  ["lewis6991/impatient.nvim"] = { commit = "b842e16" },
  ["kyazdani42/nvim-web-devicons"] = { commit = "a8cf88c" },
  ["kevinhwang91/promise-async"] = { commit = "70b0906" },
  ["nvim-lua/plenary.nvim"] = { commit = "4b7e520" },
  ["tami5/sqlite.lua"] = { commit = "47685f0" },

  -- Code highligting
  ["nvim-treesitter/nvim-treesitter"] = { config = [[require("orion.configs.treesitter") ]], commit = "82767f3" },
  ["nvim-treesitter/nvim-treesitter-context"] = {
    config = [[require("orion.configs.treesitter-context") ]],
    commit = "c46a8a0",
  },
  ["nvim-treesitter/nvim-treesitter-textobjects"] = {
    config = [[ require("orion.configs.treesitter-objects") ]],
    commit = "3c394d8",
  },

  -- LSP setup
  ["neovim/nvim-lspconfig"] = { config = [[require("orion.lsp") ]], commit = "28ec7c4" },
  ["williamboman/mason.nvim"] = { commit = "2cd60f6" },
  ["williamboman/mason-lspconfig.nvim"] = { commit = "d2bcb38" },
  ---- LSP completion
  ["hrsh7th/nvim-cmp"] = { config = [[require("orion.lsp.cmp") ]], commit = "714ccb7" },
  ["hrsh7th/cmp-buffer"] = { commit = "3022dbc" },
  ["hrsh7th/cmp-nvim-lsp"] = { commit = "affe808" },
  ["hrsh7th/cmp-path"] = { commit = "91ff86c" },
  ["hrsh7th/cmp-nvim-lsp-signature-help"] = { commit = "3dd4009" },
  ---- LSP diagnostics
  ["folke/trouble.nvim"] = { config = [[require("orion.configs.trouble")]], commit = "929315e" },
  ---- LSP snippet
  ["L3MON4D3/LuaSnip"] = { commit = "80df282" },
  ["rafamadriz/friendly-snippets"] = { commit = "fd16b4d" },
  ["saadparwaiz1/cmp_luasnip"] = { commit = "a9de941" },
  ---- LSP code formatting
  ["jose-elias-alvarez/null-ls.nvim"] = { config = [[require("orion.lsp.null-ls") ]], commit = "3d9e5f6" },
  ---- LSP code highligting
  ["RRethy/vim-illuminate"] = { config = [[require("orion.configs.illuminate") ]], commit = "0603e75" },
  ---- LSP tool
  ["j-hui/fidget.nvim"] = { config = [[ require("orion.configs.fidget") ]], commit = "1097a86" },

  -- Fuzzy Finder
  ["nvim-telescope/telescope.nvim"] = { config = [[require("orion.configs.telescope") ]], commit = "f174a03" },
  ["nvim-telescope/telescope-file-browser.nvim"] = { commit = "6b4e227" },
  ["nvim-telescope/telescope-frecency.nvim"] = { commit = "9634c35" },
  ["nvim-telescope/telescope-fzf-native.nvim"] = {
    commit = "65c0ee3",
    run = "make",
    cond = vim.fn.executable("make") == 1,
  },
  ["nvim-telescope/telescope-smart-history.nvim"] = { commit = "7eb278c" },

  -- Git
  ["TimUntersberger/neogit"] = {
    config = [[require("orion.configs.neogit") ]],
    cmd = "Neogit",
    commit = "74c9e29",
  },
  ["lewis6991/gitsigns.nvim"] = { config = [[require("orion.configs.gitsigns") ]], commit = "9d18976" },
  ["sindrets/diffview.nvim"] = {
    config = [[require("orion.configs.diffview") ]],
    cmd = "DiffViewOpen",
    commit = "a1fbcaa",
  },

  -- Programming
  ---- Movement
  ["chaoren/vim-wordmotion"] = { commit = "5dd613e" },
  ["ggandor/flit.nvim"] = { config = [[require("orion.configs.flit") ]], commit = "dd43846" },
  ["ggandor/leap.nvim"] = { config = [[require("orion.configs.leap") ]], commit = "ef9d346" },
  ["max397574/better-escape.nvim"] = { config = [[require("orion.configs.better-escape") ]], commit = "d5ee0ce" },
  ["stevearc/aerial.nvim"] = { config = [[require("orion.configs.aerial") ]], commit = "89a61da" },
  ["fedepujol/move.nvim"] = { commit = "2cd5335" },
  ["andymass/vim-matchup"] = { config = [[ require("orion.configs.matchup") ]], commit = "3fa1b22" },
  ---- Tools: folding, autopairs, indent, surround, repeat, increment
  ["Darazaki/indent-o-matic"] = { config = [[require("orion.configs.indent-o-matic") ]], commit = "68f19ea" },
  ["kevinhwang91/nvim-ufo"] = { config = [[require("orion.configs.ufo") ]], commit = "cf3b26a" },
  ["kylechui/nvim-surround"] = { config = [[require("orion.configs.surround") ]], commit = "faf9ffe" },
  ["tpope/vim-repeat"] = { commit = "24afe92" },
  ["windwp/nvim-autopairs"] = { config = [[require("orion.configs.autopairs") ]], commit = "4fc96c8" },
  ---- Writing
  ["danymat/neogen"] = { config = [[require("orion.configs.neogen") ]], commit = "967b280" },
  ["numToStr/Comment.nvim"] = { config = [[require("orion.configs.comment") ]], commit = "250bbc5" },
  ---- Language specific
  ["folke/lua-dev.nvim"] = { commit = "f3efc5f" },
  ["ellisonleao/glow.nvim"] = { cmd = "Glow", commit = "9038d7c" },
  ["nvim-orgmode/orgmode"] = { config = [[require("orion.configs.orgmode") ]], commit = "d2919c7" },
  ["phelipetls/jsonpath.nvim"] = { commit = "bf06f0a" },
  ---- Project management
  ["ahmedkhalf/project.nvim"] = { config = [[require("orion.configs.project") ]], commit = "628de7e" },
  ["gpanders/editorconfig.nvim"] = { commit = "7d10fe6" },

  -- UI
  ---- Buffer management
  ["akinsho/bufferline.nvim"] = { config = [[require("orion.configs.bufferline") ]], commit = "0606cee" },
  ["famiu/bufdelete.nvim"] = { commit = "e88dbe0" },
  ---- Colorscheme
  ["Mofiqul/vscode.nvim"] = { commit = "c512582" },
  ["catppuccin/nvim"] = { commit = "4878d6e" },
  ["ellisonleao/gruvbox.nvim"] = { commit = "24f9e79" },
  ["folke/tokyonight.nvim"] = { commit = "6ffb157" },
  ["navarasu/onedark.nvim"] = { commit = "6c72a9c" },
  ["olimorris/onedarkpro.nvim"] = { commit = "1b07362" },
  ["projekt0n/github-nvim-theme"] = { commit = "a0632f9" },
  ["rebelot/kanagawa.nvim"] = { commit = "dda1b8c" },
  ["shaunsingh/nord.nvim"] = { commit = "78f5f00" },
  ---- Dashboard
  ["goolord/alpha-nvim"] = { config = [[require("orion.configs.alpha") ]], commit = "0bb6fc0" },
  ---- Highlighting
  ["folke/todo-comments.nvim"] = { config = [[require("orion.configs.todo-comments") ]], commit = "8df75db" },
  ["p00f/nvim-ts-rainbow"] = { config = [[ require("orion.configs.nvim-ts-rainbow") ]], commit = "1ec3f88" },
  ---- Indentation
  ["lukas-reineke/indent-blankline.nvim"] = {
    config = [[require("orion.configs.indent-blankline") ]],
    commit = "db7cbcb",
  },
  ---- Prductivity
  ["Pocco81/true-zen.nvim"] = { config = [[require("orion.configs.true-zen") ]], commit = "98740c7" },
  ---- Statusline
  ["nvim-lualine/lualine.nvim"] = { config = [[require("orion.configs.lualine") ]], commit = "edca2b0" },
  ---- quickfix
  ["kevinhwang91/nvim-bqf"] = { config = [[ require("orion.configs.bqf") ]], ft = "qf", commit = "c33b5c5" },

  -- Tool
  ["NvChad/nvim-colorizer.lua"] = { config = [[require("orion.configs.colorizer") ]], commit = "9dd7ecd" },
  ["Pocco81/auto-save.nvim"] = { config = [[require("orion.configs.auto-save") ]], commit = "2c7a294" },
  ["Shatur/neovim-session-manager"] = { config = [[require("orion.configs.session") ]], commit = "4005dac" },
  ["akinsho/toggleterm.nvim"] = { config = [[require("orion.configs.toggleterm") ]], commit = "2a787c4" },
  ["ibhagwan/smartyank.nvim"] = { config = [[ require("orion.configs.smartyank") ]], commit = "c655893" },
  ["kyazdani42/nvim-tree.lua"] = {
    config = [[require("orion.configs.nvim-tree") ]],
    cmd = "NvimTree*",
    commit = "b01e7be",
  },
  ["mrjones2014/tldr.nvim"] = { config = [[require("orion.configs.tldr") ]], commit = "72af17f" },
  ---- keymappings
  ["folke/which-key.nvim"] = { config = [[require("orion.configs.which-key") ]], commit = "6885b66" },

  -- Experimental
  ---- NOTE: disabling for now
  ---- messages, cmdline and popupmenu tweaker, Noice
  -- ["MunifTanjim/nui.nvim"] = { commit = "4715f60" },
  -- ["rcarriga/nvim-notify"] = { commit = "56f65a9" },
  -- ["folke/noice.nvim"] = { event = "VimEnter", config = [[ require("orion.configs.noice") ]], commit = "be8cd5d" },
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

