local plugins = {
  -- Some core packages that I need it no matter what kind of setup it is
  ["wbthomason/packer.nvim"] = { config = [[ require("orion.core.plugins") ]], commit = "1d0cf98" },
  ["lewis6991/impatient.nvim"] = { commit = "c90e273" },
  ["kyazdani42/nvim-web-devicons"] = { commit = "6c38926" },
  ["kevinhwang91/promise-async"] = { commit = "842dca3" },
  ["nvim-lua/plenary.nvim"] = { commit = "1c7e3e6" },
  ["tami5/sqlite.lua"] = { commit = "53cac3f" },

  -- Code highligting
  ["nvim-treesitter/nvim-treesitter"] = { config = [[require("orion.configs.treesitter") ]], commit = "fb11ba4" },
  ["nvim-treesitter/nvim-treesitter-context"] = {
    config = [[require("orion.configs.treesitter-context") ]],
    commit = "cacee48",
  },
  ["nvim-treesitter/nvim-treesitter-textobjects"] = {
    config = [[ require("orion.configs.treesitter-objects") ]],
    commit = "2fb97bd",
  },
  ---- Playground for debugging purpose
  ["nvim-treesitter/playground"] = {
    config = [[ require("orion.configs.playground") ]],
    cmd = "TSPlaygroundToggle",
    commit = "01c27f3",
  },

  -- LSP setup
  ["neovim/nvim-lspconfig"] = { config = [[require("orion.lsp") ]], commit = "8ebe689" },
  ["williamboman/mason.nvim"] = { commit = "5e78970" },
  ["williamboman/mason-lspconfig.nvim"] = { commit = "610f591" },
  ---- LSP completion
  ["hrsh7th/nvim-cmp"] = { commit = "11a9579" },
  ["hrsh7th/cmp-buffer"] = { commit = "3022dbc" },
  ["hrsh7th/cmp-nvim-lsp"] = { commit = "5922477" },
  ["hrsh7th/cmp-path"] = { commit = "91ff86c" },
  ["hrsh7th/cmp-nvim-lsp-signature-help"] = { commit = "d2768cb" },
  ["hrsh7th/cmp-cmdline"] = { commit = "23c51b2" },
  ---- LSP diagnostics
  ["folke/trouble.nvim"] = { config = [[require("orion.configs.trouble")]], commit = "83ec606" },
  ---- LSP snippet
  ["L3MON4D3/LuaSnip"] = { commit = "4567028" },
  ["rafamadriz/friendly-snippets"] = { commit = "320865d" },
  ["saadparwaiz1/cmp_luasnip"] = { commit = "1809552" },
  ---- LSP code formatting
  ["jose-elias-alvarez/null-ls.nvim"] = { commit = "7bd74a8" },
  ---- LSP code highligting
  ["RRethy/vim-illuminate"] = { config = [[require("orion.configs.illuminate") ]], commit = "da80f38" },
  ---- LSP tool
  ["j-hui/fidget.nvim"] = { config = [[ require("orion.configs.fidget") ]], commit = "44585a0" },
  ---- LSP specific to programming
  ["b0o/SchemaStore.nvim"] = { commit = "8ec6e1b" },
  ["folke/neodev.nvim"] = { commit = "fc20483" },

  -- DAP - debbugger adapter protocol
  --- DAP Plugins
  ["mfussenegger/nvim-dap"] = { config = [[ require("orion.dap") ]], commit = "5a1479c" },
  ["rcarriga/nvim-dap-ui"] = { commit = "b80227e" },
  --- DAP Language specific
  ["mfussenegger/nvim-dap-python"] = { commit = "d4400d0" },

  -- Fuzzy Finder
  ["nvim-telescope/telescope.nvim"] = { config = [[require("orion.configs.telescope") ]], commit = "2f32775" },
  ["nvim-telescope/telescope-file-browser.nvim"] = { commit = "304508f" },
  ["nvim-telescope/telescope-fzf-native.nvim"] = { run = "make", commit = "fab3e22" },
  ["nvim-telescope/telescope-smart-history.nvim"] = { commit = "81a4cce" },

  -- Git
  ["TimUntersberger/neogit"] = { config = [[require("orion.configs.neogit") ]], cmd = "Neogit", commit = "981207e" },
  ["akinsho/git-conflict.nvim"] = { config = [[ require("orion.configs.git-conflict") ]], commit = "cbefa70" },
  ["lewis6991/gitsigns.nvim"] = { config = [[require("orion.configs.gitsigns") ]], commit = "addd6e1" },
  ["sindrets/diffview.nvim"] = { config = [[require("orion.configs.diffview") ]], commit = "5bbcf16" },

  -- Programming
  ---- Movement
  ["ggandor/flit.nvim"] = { config = [[require("orion.configs.flit") ]], commit = "be110f9" },
  ["ggandor/leap.nvim"] = { config = [[require("orion.configs.leap") ]], commit = "a968ab4" },
  ["max397574/better-escape.nvim"] = { config = [[require("orion.configs.better-escape") ]], commit = "6fed338" },
  ["stevearc/aerial.nvim"] = { config = [[require("orion.configs.aerial") ]], commit = "4c3ff75" },
  ["hinell/move.nvim"] = { commit = "0ff376a" },
  ["andymass/vim-matchup"] = { config = [[ require("orion.configs.matchup") ]], commit = "db5120d" },
  ["ThePrimeagen/harpoon"] = { config = [[ require("orion.configs.harpoon") ]], commit = "21d0d1b" },
  ---- Tools: folding, autopairs, surround, repeat, increment
  ["kevinhwang91/nvim-ufo"] = { config = [[require("orion.configs.ufo") ]], commit = "e3528c9" },
  ["kylechui/nvim-surround"] = { config = [[require("orion.configs.surround") ]], commit = "ad56e62" },
  ["tpope/vim-repeat"] = { commit = "24afe92" },
  ["windwp/nvim-autopairs"] = { config = [[require("orion.configs.autopairs") ]], commit = "f00eb3b" },
  ---- Writing
  ["danymat/neogen"] = { config = [[require("orion.configs.neogen") ]], commit = "465af9d" },
  ["numToStr/Comment.nvim"] = { config = [[require("orion.configs.comment") ]], commit = "e89df17" },
  ---- Language specific
  ["ellisonleao/glow.nvim"] = { cmd = "Glow", commit = "c88184a" },
  ["nvim-orgmode/orgmode"] = { config = [[require("orion.configs.orgmode") ]], commit = "dadf563" },
  ["phelipetls/jsonpath.nvim"] = { commit = "d52d1c1" },
  ---- Project management
  ["ahmedkhalf/project.nvim"] = { config = [[require("orion.configs.project") ]], commit = "685bc8e" },
  ["gpanders/editorconfig.nvim"] = { commit = "5b9e303" },

  -- UI
  ---- Buffer management
  ["akinsho/bufferline.nvim"] = { config = [[require("orion.configs.bufferline") ]], commit = "c7492a7" },
  ["famiu/bufdelete.nvim"] = { commit = "f79e9d1" },
  ---- Colorscheme
  ["EdenEast/nightfox.nvim"] = { commit = "925cca4" },
  ["Mofiqul/vscode.nvim"] = { commit = "fd92b55" },
  ["catppuccin/nvim"] = { as = "catppuccin", commit = "01d11b6" },
  ["ellisonleao/gruvbox.nvim"] = { commit = "e863942" },
  ["folke/tokyonight.nvim"] = { commit = "73671f5" },
  ["navarasu/onedark.nvim"] = { commit = "89dde49" },
  ["olimorris/onedarkpro.nvim"] = { commit = "8958a33" },
  ["projekt0n/github-nvim-theme"] = { commit = "24c8706" },
  ["rebelot/kanagawa.nvim"] = { commit = "4c8d487" },
  ["rose-pine/neovim"] = { as = "rose-pine", commit = "845a6ad" },
  ["shaunsingh/nord.nvim"] = { commit = "418e250" },
  ---- Dashboard
  ["goolord/alpha-nvim"] = { config = [[require("orion.configs.alpha") ]], commit = "21a0f25" },
  ---- Highlighting
  ["folke/todo-comments.nvim"] = { config = [[require("orion.configs.todo-comments") ]], commit = "077c595" },
  ["p00f/nvim-ts-rainbow"] = { config = [[ require("orion.configs.nvim-ts-rainbow") ]], commit = "ef95c15" },
  ---- Indentation
  ["lukas-reineke/indent-blankline.nvim"] = {
    config = [[require("orion.configs.indent-blankline") ]],
    commit = "c4c203c",
  },
  ---- Prductivity
  ["Pocco81/true-zen.nvim"] = { config = [[require("orion.configs.true-zen") ]], commit = "98740c7" },
  ---- Statusline
  ["nvim-lualine/lualine.nvim"] = { config = [[require("orion.configs.lualine") ]], commit = "0050b30" },
  ---- quickfix
  ["kevinhwang91/nvim-bqf"] = { config = [[ require("orion.configs.bqf") ]], ft = "qf", commit = "d15b59d" },

  -- Tool
  ["NvChad/nvim-colorizer.lua"] = { config = [[require("orion.configs.colorizer") ]], commit = "760e27d" },
  -- ["Pocco81/auto-save.nvim"] = { config = [[require("orion.configs.auto-save") ]], commit = "979b6c8" },
  ["Shatur/neovim-session-manager"] = { config = [[require("orion.configs.session") ]], commit = "afd2d69" },
  ["akinsho/toggleterm.nvim"] = { config = [[require("orion.configs.toggleterm") ]], commit = "a54e6c4" },
  ["ibhagwan/smartyank.nvim"] = { config = [[ require("orion.configs.smartyank") ]], commit = "cd191d9" },
  ["kyazdani42/nvim-tree.lua"] = {
    config = [[require("orion.configs.nvim-tree") ]],
    cmd = "NvimTree*",
    commit = "e8a89db",
  },
  ["mrjones2014/tldr.nvim"] = { config = [[require("orion.configs.tldr") ]], commit = "72af17f" },
  ---- keymappings
  ["folke/which-key.nvim"] = { config = [[require("orion.configs.which-key") ]], commit = "e4fa445" },

  -- Experimental
  ---- NOTE: disabling for now
  ---- messages, cmdline and popupmenu tweaker, Noice
  -- ["MunifTanjim/nui.nvim"] = { commit = "b99e6cb" },
  -- ["rcarriga/nvim-notify"] = { commit = "72e7709" },
  -- ["folke/noice.nvim"] = { event = "VimEnter", config = [[ require("orion.configs.noice") ]], commit = "16b6045" },
  ---- Code Map
  ["gorbit99/codewindow.nvim"] = { config = [[ require("orion.configs.codewindow") ]], commit = "816fdbf" },
  ---- Movement
  ["ggandor/leap-spooky.nvim"] = { commit = "748b261" },
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
