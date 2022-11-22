local plugins = {
  -- Some core packages that I need it no matter what kind of setup it is
  ["wbthomason/packer.nvim"] = { config = [[ require("orion.core.plugins") ]], commit = "6afb674" },
  ["lewis6991/impatient.nvim"] = { commit = "d3dd30f" },
  ["kyazdani42/nvim-web-devicons"] = { commit = "3b1b794" },
  ["kevinhwang91/promise-async"] = { commit = "70b0906" },
  ["nvim-lua/plenary.nvim"] = { commit = "4b7e520" },
  ["tami5/sqlite.lua"] = { commit = "53cac3f" },

  -- Code highligting
  ["nvim-treesitter/nvim-treesitter"] = { config = [[require("orion.configs.treesitter") ]], commit = "be5ed65" },
  ["nvim-treesitter/nvim-treesitter-context"] = {
    config = [[require("orion.configs.treesitter-context") ]],
    commit = "0dd5eae",
  },
  ["nvim-treesitter/nvim-treesitter-textobjects"] = {
    config = [[ require("orion.configs.treesitter-objects") ]],
    commit = "1435ea5",
  },
  ---- Playground for debugging purpose
  ["nvim-treesitter/playground"] = {
    config = [[ require("orion.configs.playground") ]],
    cmd = "TSPlaygroundToggle",
    commit = "1290fdf",
  },

  -- LSP setup
  ["neovim/nvim-lspconfig"] = { config = [[require("orion.lsp") ]], commit = "ea5744f" },
  ["williamboman/mason.nvim"] = { commit = "9f84d49" },
  ["williamboman/mason-lspconfig.nvim"] = { commit = "a1e2219" },
  ---- LSP completion
  ["hrsh7th/nvim-cmp"] = { commit = "8a9e8a8" },
  ["hrsh7th/cmp-buffer"] = { commit = "3022dbc" },
  ["hrsh7th/cmp-nvim-lsp"] = { commit = "5922477" },
  ["hrsh7th/cmp-path"] = { commit = "91ff86c" },
  ["hrsh7th/cmp-nvim-lsp-signature-help"] = { commit = "d2768cb" },
  ["hrsh7th/cmp-cmdline"] = { commit = "8bc9c4a" },
  ---- LSP diagnostics
  ["folke/trouble.nvim"] = { config = [[require("orion.configs.trouble")]], commit = "897542f" },
  ---- LSP snippet
  ["L3MON4D3/LuaSnip"] = { commit = "09ce9a7" },
  ["rafamadriz/friendly-snippets"] = { commit = "ef8caa5" },
  ["saadparwaiz1/cmp_luasnip"] = { commit = "1809552" },
  ---- LSP code formatting
  ["jose-elias-alvarez/null-ls.nvim"] = { commit = "07d4ed4" },
  ---- LSP code highligting
  ["RRethy/vim-illuminate"] = { config = [[require("orion.configs.illuminate") ]], commit = "a6d0b28" },
  ---- LSP tool
  ["j-hui/fidget.nvim"] = { config = [[ require("orion.configs.fidget") ]], commit = "2cf9997" },
  ---- LSP specific to programming
  ["b0o/SchemaStore.nvim"] = { commit = "7741353" },
  ["folke/neodev.nvim"] = { commit = "071c889" },

  -- DAP - debbugger adapter protocol
  --- DAP Plugins
  ["mfussenegger/nvim-dap"] = { config = [[ require("orion.dap") ]], commit = "6164368" },
  ["rcarriga/nvim-dap-ui"] = { commit = "69a3982" },
  --- DAP Language specific
  ["mfussenegger/nvim-dap-python"] = { commit = "27a0eff" },

  -- Fuzzy Finder
  ["nvim-telescope/telescope.nvim"] = { config = [[require("orion.configs.telescope") ]], commit = "7a4ffef" },
  ["nvim-telescope/telescope-file-browser.nvim"] = { commit = "2429ecf" },
  ["nvim-telescope/telescope-fzf-native.nvim"] = { run = "make", commit = "65c0ee3" },
  ["nvim-telescope/telescope-smart-history.nvim"] = { commit = "7eb278c" },

  -- Git
  ["TimUntersberger/neogit"] = { config = [[require("orion.configs.neogit") ]], cmd = "Neogit", commit = "c1a2a1a" },
  ["akinsho/git-conflict.nvim"] = { config = [[ require("orion.configs.git-conflict") ]], commit = "0f87781" },
  ["lewis6991/gitsigns.nvim"] = { config = [[require("orion.configs.gitsigns") ]], commit = "9ff7dfb" },
  ["sindrets/diffview.nvim"] = { config = [[require("orion.configs.diffview") ]], commit = "d2d9b18" },

  -- Programming
  ---- Movement
  ["ggandor/flit.nvim"] = { config = [[require("orion.configs.flit") ]], commit = "be110f9" },
  ["ggandor/leap.nvim"] = { config = [[require("orion.configs.leap") ]], commit = "cd90202" },
  ["max397574/better-escape.nvim"] = { config = [[require("orion.configs.better-escape") ]], commit = "d5ee0ce" },
  ["stevearc/aerial.nvim"] = { config = [[require("orion.configs.aerial") ]], commit = "4b42ddb" },
  ["fedepujol/move.nvim"] = { commit = "2cd5335" },
  ["andymass/vim-matchup"] = { config = [[ require("orion.configs.matchup") ]], commit = "55e3330" },
  ["ThePrimeagen/harpoon"] = { config = [[ require("orion.configs.harpoon") ]], commit = "00f486e" },
  ---- Tools: folding, autopairs, surround, repeat, increment
  ["kevinhwang91/nvim-ufo"] = { config = [[require("orion.configs.ufo") ]], commit = "a346e88" },
  ["kylechui/nvim-surround"] = { config = [[require("orion.configs.surround") ]], commit = "9338071" },
  ["tpope/vim-repeat"] = { commit = "24afe92" },
  ["windwp/nvim-autopairs"] = { config = [[require("orion.configs.autopairs") ]], commit = "6b6e35f" },
  ---- Writing
  ["danymat/neogen"] = { config = [[require("orion.configs.neogen") ]], commit = "91b093f" },
  ["numToStr/Comment.nvim"] = { config = [[require("orion.configs.comment") ]], commit = "5f01c1a" },
  ---- Language specific
  ["ellisonleao/glow.nvim"] = { cmd = "Glow", commit = "9038d7c" },
  ["nvim-orgmode/orgmode"] = { config = [[require("orion.configs.orgmode") ]], commit = "b82cc5d" },
  ["phelipetls/jsonpath.nvim"] = { commit = "d52d1c1" },
  ---- Project management
  ["ahmedkhalf/project.nvim"] = { config = [[require("orion.configs.project") ]], commit = "685bc8e" },
  ["gpanders/editorconfig.nvim"] = { commit = "2af8809" },

  -- UI
  ---- Buffer management
  ["akinsho/bufferline.nvim"] = { config = [[require("orion.configs.bufferline") ]], commit = "4ecfa81" },
  ["famiu/bufdelete.nvim"] = { commit = "3ebf4a9" },
  ---- Colorscheme
  ["EdenEast/nightfox.nvim"] = { commit = "7413662" },
  ["Mofiqul/vscode.nvim"] = { commit = "920145b" },
  ["catppuccin/nvim"] = { as = "catppuccin", commit = "4393f2a" },
  ["ellisonleao/gruvbox.nvim"] = { commit = "5ac400b" },
  ["folke/tokyonight.nvim"] = { commit = "62b4e89" },
  ["navarasu/onedark.nvim"] = { commit = "df090f9" },
  ["olimorris/onedarkpro.nvim"] = { commit = "6f13896" },
  ["projekt0n/github-nvim-theme"] = { commit = "a0632f9" },
  ["rebelot/kanagawa.nvim"] = { commit = "52cfa27" },
  ["rose-pine/neovim"] = { as = "rose-pine", commit = "77b86d9" },
  ["shaunsingh/nord.nvim"] = { commit = "a6bb6a8" },
  ---- Dashboard
  ["goolord/alpha-nvim"] = { config = [[require("orion.configs.alpha") ]], commit = "a858e4e" },
  ---- Highlighting
  ["folke/todo-comments.nvim"] = { config = [[require("orion.configs.todo-comments") ]], commit = "1b9df57" },
  ["p00f/nvim-ts-rainbow"] = { config = [[ require("orion.configs.nvim-ts-rainbow") ]], commit = "064fd6c" },
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
  ["kevinhwang91/nvim-bqf"] = { config = [[ require("orion.configs.bqf") ]], ft = "qf", commit = "3247018" },

  -- Tool
  ["NvChad/nvim-colorizer.lua"] = { config = [[require("orion.configs.colorizer") ]], commit = "760e27d" },
  -- ["Pocco81/auto-save.nvim"] = { config = [[require("orion.configs.auto-save") ]], commit = "979b6c8" },
  ["Shatur/neovim-session-manager"] = { config = [[require("orion.configs.session") ]], commit = "24ceb4b" },
  ["akinsho/toggleterm.nvim"] = { config = [[require("orion.configs.toggleterm") ]], commit = "3ba6838" },
  ["ibhagwan/smartyank.nvim"] = { config = [[ require("orion.configs.smartyank") ]], commit = "78de01a" },
  ["kyazdani42/nvim-tree.lua"] = {
    config = [[require("orion.configs.nvim-tree") ]],
    cmd = "NvimTree*",
    commit = "68a2a09",
  },
  ["mrjones2014/tldr.nvim"] = { config = [[require("orion.configs.tldr") ]], commit = "72af17f" },
  ---- keymappings
  ["folke/which-key.nvim"] = { config = [[require("orion.configs.which-key") ]], commit = "61553ae" },

  -- Experimental
  ---- NOTE: disabling for now
  ---- messages, cmdline and popupmenu tweaker, Noice
  -- ["MunifTanjim/nui.nvim"] = { commit = "d12a697" },
  -- ["rcarriga/nvim-notify"] = { commit = "43c54ae" },
  -- ["folke/noice.nvim"] = { event = "VimEnter", config = [[ require("orion.configs.noice") ]], commit = "6f8f897" },
  ---- Code Map
  ["gorbit99/codewindow.nvim"] = { config = [[ require("orion.configs.codewindow") ]], commit = "987b394" },
  ---- Movement
  ["ggandor/leap-spooky.nvim"] = { commit = "482a945" },
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
