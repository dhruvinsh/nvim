local plugins = {
  -- Some core packages that I need it no matter what kind of setup it is
  ["wbthomason/packer.nvim"] = { config = [[ require("plugins") ]], commit = "6afb674" },
  ["lewis6991/impatient.nvim"] = { commit = "b842e16" },
  ["kyazdani42/nvim-web-devicons"] = { commit = "a8cf88c" },
  ["kevinhwang91/promise-async"] = { commit = "70b0906" },
  ["nvim-lua/plenary.nvim"] = { commit = "4b7e520" },
  ["tami5/sqlite.lua"] = { commit = "47685f0" },

  -- Code highligting
  ["nvim-treesitter/nvim-treesitter"] = { config = [[require("plugins.config.treesitter") ]], commit = "7ccb9a0" },
  ["nvim-treesitter/nvim-treesitter-context"] = {
    config = [[require("plugins.config.treesitter-context") ]],
    commit = "8d0759e",
  },
  ["nvim-treesitter/nvim-treesitter-textobjects"] = {
    config = [[ require("plugins.config.treesitter-objects") ]],
    commit = "41e8d89",
  },

  -- LSP setup
  ["neovim/nvim-lspconfig"] = { config = [[require("plugins.config.lsp") ]], commit = "fc2f44d" },
  ["williamboman/mason.nvim"] = { commit = "a01073d" },
  ["williamboman/mason-lspconfig.nvim"] = { commit = "38ab1f3" },
  ["j-hui/fidget.nvim"] = { config = [[ require("plugins.config.fidget") ]], commit = "1097a86" },
  ---- LSP completion
  ["hrsh7th/nvim-cmp"] = { config = [[require("plugins.config.cmp") ]], commit = "b0dff0e" },
  ["hrsh7th/cmp-buffer"] = { commit = "3022dbc" },
  ["hrsh7th/cmp-nvim-lsp"] = { commit = "affe808" },
  ["hrsh7th/cmp-path"] = { commit = "91ff86c" },
  ["hrsh7th/cmp-nvim-lsp-signature-help"] = { commit = "3dd4009" },
  ---- LSP diagnostics
  ["folke/trouble.nvim"] = { config = [[require("plugins.config.trouble")]], commit = "929315e" },
  ---- LSP snippet
  ["L3MON4D3/LuaSnip"] = { commit = "8f8d493" },
  ["rafamadriz/friendly-snippets"] = { commit = "9f4ffd1" },
  ["saadparwaiz1/cmp_luasnip"] = { commit = "a9de941" },
  ---- LSP code formatting
  ["jose-elias-alvarez/null-ls.nvim"] = { config = [[require("plugins.config.null-ls") ]], commit = "c0c19f3" },
  ---- LSP code highligting
  ["RRethy/vim-illuminate"] = { config = [[require("plugins.config.illuminate") ]], commit = "ea170c1" },

  -- Fuzzy Finder
  ["nvim-telescope/telescope.nvim"] = { config = [[require("plugins.config.telescope") ]], commit = "76ea9a8" },
  ["nvim-telescope/telescope-file-browser.nvim"] = { commit = "b1bc53e" },
  ["nvim-telescope/telescope-frecency.nvim"] = { commit = "9634c35" },
  ["nvim-telescope/telescope-fzf-native.nvim"] = {
    commit = "65c0ee3",
    run = "make",
    cond = vim.fn.executable("make") == 1,
  },
  ["nvim-telescope/telescope-smart-history.nvim"] = { commit = "7eb278c" },

  -- Git
  ["TimUntersberger/neogit"] = { config = [[require("plugins.config.neogit") ]], cmd = "Neogit", commit = "74c9e29" },
  ["lewis6991/gitsigns.nvim"] = { config = [[require("plugins.config.gitsigns") ]], commit = "f98c85e" },
  ["sindrets/diffview.nvim"] = {
    config = [[require("plugins.config.diffview") ]],
    cmd = "DiffViewOpen",
    commit = "6baa30d",
  },

  -- Programming
  ---- Movement
  ["chaoren/vim-wordmotion"] = { commit = "5dd613e" },
  ["ggandor/flit.nvim"] = { config = [[require("plugins.config.flit") ]], commit = "dd43846" },
  ["ggandor/leap.nvim"] = { config = [[require("plugins.config.leap") ]], commit = "5a09c30" },
  ["max397574/better-escape.nvim"] = { config = [[require("plugins.config.better-escape") ]], commit = "d5ee0ce" },
  ["stevearc/aerial.nvim"] = { config = [[require("plugins.config.aerial") ]], commit = "6f1b28b" },
  ["fedepujol/move.nvim"] = { commit = "2cd5335" },
  ["andymass/vim-matchup"] = { config = [[ require("plugins.config.matchup") ]], commit = "3fa1b22" },
  ---- Tools: folding, autopairs, indent, surround, repeat
  ["Darazaki/indent-o-matic"] = { config = [[require("plugins.config.indent-o-matic") ]], commit = "bf37c6e" },
  ["kevinhwang91/nvim-ufo"] = { config = [[require("plugins.config.ufo") ]], commit = "bf40cd0" },
  ["kylechui/nvim-surround"] = { config = [[require("plugins.config.surround") ]], commit = "1719167" },
  ["tpope/vim-repeat"] = { commit = "24afe92" },
  ["windwp/nvim-autopairs"] = { config = [[require("plugins.config.autopairs") ]], commit = "4fc96c8" },
  ---- Writing
  ["danymat/neogen"] = { config = [[require("plugins.config.neogen") ]], commit = "967b280" },
  ["numToStr/Comment.nvim"] = { config = [[require("plugins.config.comment") ]], commit = "97a188a" },
  ---- Language specific
  ["folke/lua-dev.nvim"] = { commit = "e651a72" },
  ["ellisonleao/glow.nvim"] = { cmd = "Glow", commit = "b6b9972" },
  ["nvim-orgmode/orgmode"] = { config = [[require("plugins.config.orgmode") ]], commit = "1adb0cb" },
  ---- Project management
  ["ahmedkhalf/project.nvim"] = { config = [[require("plugins.config.project") ]], commit = "628de7e" },
  ["gpanders/editorconfig.nvim"] = { commit = "7d10fe6" },

  -- UI
  ---- Buffer management
  ["akinsho/bufferline.nvim"] = { config = [[require("plugins.config.bufferline") ]], commit = "5aa803a" },
  ["famiu/bufdelete.nvim"] = { commit = "46255e4" },
  ---- Colorscheme
  ["Mofiqul/vscode.nvim"] = { commit = "c512582" },
  ["catppuccin/nvim"] = { run = ":CatppuccinCompile", commit = "8deefde" },
  ["ellisonleao/gruvbox.nvim"] = { commit = "24f9e79" },
  ["folke/tokyonight.nvim"] = { commit = "66bfc2e" },
  ["navarasu/onedark.nvim"] = { commit = "6c72a9c" },
  ["olimorris/onedarkpro.nvim"] = { commit = "9a0cccb" },
  ["projekt0n/github-nvim-theme"] = { commit = "b3f1519" },
  ["rebelot/kanagawa.nvim"] = { commit = "dda1b8c" },
  ["shaunsingh/nord.nvim"] = { commit = "78f5f00" },
  ---- Dashboard
  ["goolord/alpha-nvim"] = { config = [[require("plugins.config.alpha") ]], commit = "0bb6fc0" },
  ---- Highlighting
  ["folke/todo-comments.nvim"] = { config = [[require("plugins.config.todo-comments") ]], commit = "8df75db" },
  ["p00f/nvim-ts-rainbow"] = { config = [[ require("plugins.config.nvim-ts-rainbow") ]], commit = "1ec3f88" },
  ---- Indentation
  ["lukas-reineke/indent-blankline.nvim"] = {
    config = [[require("plugins.config.indent-blankline") ]],
    commit = "db7cbcb",
  },
  ---- Prductivity
  ["Pocco81/true-zen.nvim"] = { config = [[require("plugins.config.true-zen") ]], commit = "98740c7" },
  ---- Statusline
  ["nvim-lualine/lualine.nvim"] = { config = [[require("plugins.config.lualine") ]], commit = "a52f078" },

  -- Tool
  ["NvChad/nvim-colorizer.lua"] = { config = [[require("plugins.config.colorizer") ]], commit = "9dd7ecd" },
  ["Pocco81/auto-save.nvim"] = { config = [[require("plugins.config.auto-save") ]], commit = "2c7a294" },
  ["Shatur/neovim-session-manager"] = { config = [[require("plugins.config.session") ]], commit = "4005dac" },
  ["akinsho/toggleterm.nvim"] = { config = [[require("plugins.config.toggleterm") ]], commit = "2a787c4" },
  ["kyazdani42/nvim-tree.lua"] = {
    config = [[require("plugins.config.nvim-tree") ]],
    cmd = "NvimTree*",
    commit = "7282f7d",
  },
  ["mrjones2014/tldr.nvim"] = { config = [[require("plugins.config.tldr") ]], commit = "72af17f" },
  ---- keymappings
  ["folke/which-key.nvim"] = { config = [[require("plugins.config.which-key") ]], commit = "6885b66" },

  -- Experimental
  ---- NOTE: disabling for now
  ---- messages, cmdline and popupmenu tweaker, Noice
  -- ["MunifTanjim/nui.nvim"] = { commit = "4715f60" },
  -- ["rcarriga/nvim-notify"] = { commit = "4144654" },
  -- ["folke/noice.nvim"] = { event = "VimEnter", config = [[ require("plugins.config.noice") ]], commit = "3a23308" },
}

-- Load the plugins
local status_ok, packer = pcall(require, "packer")

if status_ok then
  vim.cmd([[packadd packer.nvim]])
  local packer_init = require("plugins.config.packer")
  packer.init(packer_init)

  for key, plugin in pairs(plugins) do
    if type(key) == "string" and not plugin[1] then
      plugin[1] = key
    end
    packer.use(plugin)
  end
end
