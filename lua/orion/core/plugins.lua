local plugins = {
  -- Some core packages that I need it no matter what kind of setup it is
  ["wbthomason/packer.nvim"] = { config = [[ require("orion.core.plugins") ]], commit = "64ae65f" },
  ["lewis6991/impatient.nvim"] = { commit = "d3dd30f" },
  ["kyazdani42/nvim-web-devicons"] = { commit = "05e1072" },
  ["kevinhwang91/promise-async"] = { commit = "70b0906" },
  ["nvim-lua/plenary.nvim"] = { commit = "4b7e520" },
  ["tami5/sqlite.lua"] = { commit = "53cac3f" },

  -- Code highligting
  ["nvim-treesitter/nvim-treesitter"] = { config = [[require("orion.configs.treesitter") ]], commit = "619f1ac" },
  ["nvim-treesitter/nvim-treesitter-context"] = {
    config = [[require("orion.configs.treesitter-context") ]],
    commit = "5fda0b9",
  },
  ["nvim-treesitter/nvim-treesitter-textobjects"] = {
    config = [[ require("orion.configs.treesitter-objects") ]],
    commit = "e8b7807",
  },
  ---- Playground for debugging purpose
  ["nvim-treesitter/playground"] = {
    config = [[ require("orion.configs.playground") ]],
    cmd = "TSPlaygroundToggle",
    commit = "1290fdf",
  },

  -- LSP setup
  ["neovim/nvim-lspconfig"] = { config = [[require("orion.lsp") ]], commit = "6eb24ef" },
  ["williamboman/mason.nvim"] = { commit = "e8bf531" },
  ["williamboman/mason-lspconfig.nvim"] = { commit = "e8bd501" },
  ---- LSP completion
  ["hrsh7th/nvim-cmp"] = { commit = "93f385c" },
  ["hrsh7th/cmp-buffer"] = { commit = "3022dbc" },
  ["hrsh7th/cmp-nvim-lsp"] = { commit = "5922477" },
  ["hrsh7th/cmp-path"] = { commit = "91ff86c" },
  ["hrsh7th/cmp-nvim-lsp-signature-help"] = { commit = "d2768cb" },
  ["hrsh7th/cmp-cmdline"] = { commit = "23c51b2" },
  ---- LSP diagnostics
  ["folke/trouble.nvim"] = { config = [[require("orion.configs.trouble")]], commit = "897542f" },
  ---- LSP snippet
  ["L3MON4D3/LuaSnip"] = { commit = "8b25e74" },
  ["rafamadriz/friendly-snippets"] = { commit = "9b3e497" },
  ["saadparwaiz1/cmp_luasnip"] = { commit = "1809552" },
  ---- LSP code formatting
  ["jose-elias-alvarez/null-ls.nvim"] = { commit = "adaa799" },
  ---- LSP code highligting
  ["RRethy/vim-illuminate"] = { config = [[require("orion.configs.illuminate") ]], commit = "a6d0b28" },
  ---- LSP tool
  ["j-hui/fidget.nvim"] = { config = [[ require("orion.configs.fidget") ]], commit = "44585a0" },
  ---- LSP specific to programming
  ["b0o/SchemaStore.nvim"] = { commit = "cb67722" },
  ["folke/neodev.nvim"] = { commit = "f353ec5" },

  -- DAP - debbugger adapter protocol
  --- DAP Plugins
  ["mfussenegger/nvim-dap"] = { config = [[ require("orion.dap") ]], commit = "a8fd28a" },
  ["rcarriga/nvim-dap-ui"] = { commit = "54365d2" },
  --- DAP Language specific
  ["mfussenegger/nvim-dap-python"] = { commit = "27a0eff" },

  -- Fuzzy Finder
  ["nvim-telescope/telescope.nvim"] = { config = [[require("orion.configs.telescope") ]], commit = "cabf991" },
  ["nvim-telescope/telescope-file-browser.nvim"] = { commit = "cad567e" },
  ["nvim-telescope/telescope-fzf-native.nvim"] = { run = "make", commit = "ae9d95d" },
  ["nvim-telescope/telescope-smart-history.nvim"] = { commit = "7eb278c" },

  -- Git
  ["TimUntersberger/neogit"] = { config = [[require("orion.configs.neogit") ]], cmd = "Neogit", commit = "19bc837" },
  ["akinsho/git-conflict.nvim"] = { config = [[ require("orion.configs.git-conflict") ]], commit = "77faa75" },
  ["lewis6991/gitsigns.nvim"] = { config = [[require("orion.configs.gitsigns") ]], commit = "d076301" },
  ["sindrets/diffview.nvim"] = { config = [[require("orion.configs.diffview") ]], commit = "85903aa" },

  -- Programming
  ---- Movement
  ["ggandor/flit.nvim"] = { config = [[require("orion.configs.flit") ]], commit = "be110f9" },
  ["ggandor/leap.nvim"] = { config = [[require("orion.configs.leap") ]], commit = "8f0d4a9" },
  ["max397574/better-escape.nvim"] = { config = [[require("orion.configs.better-escape") ]], commit = "d5ee0ce" },
  ["stevearc/aerial.nvim"] = { config = [[require("orion.configs.aerial") ]], commit = "50d28ad" },
  ["fedepujol/move.nvim"] = { commit = "2cd5335" },
  ["andymass/vim-matchup"] = { config = [[ require("orion.configs.matchup") ]], commit = "db5120d" },
  ["ThePrimeagen/harpoon"] = { config = [[ require("orion.configs.harpoon") ]], commit = "21d0d1b" },
  ---- Tools: folding, autopairs, surround, repeat, increment
  ["kevinhwang91/nvim-ufo"] = { config = [[require("orion.configs.ufo") ]], commit = "e988139" },
  ["kylechui/nvim-surround"] = { config = [[require("orion.configs.surround") ]], commit = "6b45fbf" },
  ["tpope/vim-repeat"] = { commit = "24afe92" },
  ["windwp/nvim-autopairs"] = { config = [[require("orion.configs.autopairs") ]], commit = "9fa9961" },
  ---- Writing
  ["danymat/neogen"] = { config = [[require("orion.configs.neogen") ]], commit = "91b093f" },
  ["numToStr/Comment.nvim"] = { config = [[require("orion.configs.comment") ]], commit = "5f01c1a" },
  ---- Language specific
  ["ellisonleao/glow.nvim"] = { cmd = "Glow", commit = "20d1cd0" },
  ["nvim-orgmode/orgmode"] = { config = [[require("orion.configs.orgmode") ]], commit = "aba09c5" },
  ["phelipetls/jsonpath.nvim"] = { commit = "d52d1c1" },
  ---- Project management
  ["ahmedkhalf/project.nvim"] = { config = [[require("orion.configs.project") ]], commit = "685bc8e" },
  ["gpanders/editorconfig.nvim"] = { commit = "2af8809" },

  -- UI
  ---- Buffer management
  ["akinsho/bufferline.nvim"] = { config = [[require("orion.configs.bufferline") ]], commit = "4ecfa81" },
  ["famiu/bufdelete.nvim"] = { commit = "f79e9d1" },
  ---- Colorscheme
  ["EdenEast/nightfox.nvim"] = { commit = "0903c48" },
  ["Mofiqul/vscode.nvim"] = { commit = "dabd545" },
  ["catppuccin/nvim"] = { as = "catppuccin", commit = "e7fbf24" },
  ["ellisonleao/gruvbox.nvim"] = { commit = "d2efdea" },
  ["folke/tokyonight.nvim"] = { commit = "0f7b6a5" },
  ["navarasu/onedark.nvim"] = { commit = "89dde49" },
  ["olimorris/onedarkpro.nvim"] = { commit = "ceb1ad9" },
  ["projekt0n/github-nvim-theme"] = { commit = "a0632f9" },
  ["rebelot/kanagawa.nvim"] = { commit = "fb733c1" },
  ["rose-pine/neovim"] = { as = "rose-pine", commit = "7610f24" },
  ["shaunsingh/nord.nvim"] = { commit = "4b6d407" },
  ---- Dashboard
  ["goolord/alpha-nvim"] = { config = [[require("orion.configs.alpha") ]], commit = "21a0f25" },
  ---- Highlighting
  ["folke/todo-comments.nvim"] = { config = [[require("orion.configs.todo-comments") ]], commit = "1b9df57" },
  ["p00f/nvim-ts-rainbow"] = { config = [[ require("orion.configs.nvim-ts-rainbow") ]], commit = "064fd6c" },
  ---- Indentation
  ["lukas-reineke/indent-blankline.nvim"] = {
    config = [[require("orion.configs.indent-blankline") ]],
    commit = "c4c203c",
  },
  ---- Prductivity
  ["Pocco81/true-zen.nvim"] = { config = [[require("orion.configs.true-zen") ]], commit = "98740c7" },
  ---- Statusline
  ["nvim-lualine/lualine.nvim"] = { config = [[require("orion.configs.lualine") ]], commit = "bfa0d99" },
  ---- quickfix
  ["kevinhwang91/nvim-bqf"] = { config = [[ require("orion.configs.bqf") ]], ft = "qf", commit = "3389264" },

  -- Tool
  ["NvChad/nvim-colorizer.lua"] = { config = [[require("orion.configs.colorizer") ]], commit = "760e27d" },
  -- ["Pocco81/auto-save.nvim"] = { config = [[require("orion.configs.auto-save") ]], commit = "979b6c8" },
  ["Shatur/neovim-session-manager"] = { config = [[require("orion.configs.session") ]], commit = "f8c85da" },
  ["akinsho/toggleterm.nvim"] = { config = [[require("orion.configs.toggleterm") ]], commit = "b02a167" },
  ["ibhagwan/smartyank.nvim"] = { config = [[ require("orion.configs.smartyank") ]], commit = "78de01a" },
  ["kyazdani42/nvim-tree.lua"] = {
    config = [[require("orion.configs.nvim-tree") ]],
    cmd = "NvimTree*",
    commit = "7177d95",
  },
  ["mrjones2014/tldr.nvim"] = { config = [[require("orion.configs.tldr") ]], commit = "72af17f" },
  ---- keymappings
  ["folke/which-key.nvim"] = { config = [[require("orion.configs.which-key") ]], commit = "61553ae" },

  -- Experimental
  ---- NOTE: disabling for now
  ---- messages, cmdline and popupmenu tweaker, Noice
  -- ["MunifTanjim/nui.nvim"] = { commit = "2a6533f" },
  -- ["rcarriga/nvim-notify"] = { commit = "b005821" },
  -- ["folke/noice.nvim"] = { event = "VimEnter", config = [[ require("orion.configs.noice") ]], commit = "e013b6e" },
  ---- Code Map
  ["gorbit99/codewindow.nvim"] = { config = [[ require("orion.configs.codewindow") ]], commit = "987b394" },
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
