---------------------------------
-- Packer Bootstraping
---------------------------------
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
  execute("packadd packer.nvim")
end
local packer = require("packer")

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd FileType lua autocmd BufWritePost $HOME/.config/nvim/* PackerCompile
  augroup end
]],
  false
)

---------------
-- Plugins list
---------------
local plugins = {
  -- Tools
  { "lewis6991/impatient.nvim" },
  { "wbthomason/packer.nvim" },
  { "nathom/filetype.nvim" },
  { "nvim-lua/plenary.nvim" },
  {
    "kyazdani42/nvim-web-devicons",
    config = [[ require('config.icons') ]],
  },
  {
    "nvim-telescope/telescope.nvim",
    config = [[ require('config.telescope') ]],
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",
  },
  {
    "ahmedkhalf/project.nvim",
    config = [[ require("config.project") ]],
  },
  {
    "kyazdani42/nvim-tree.lua",
    cmd = "NvimTree*",
    config = [[ require('config.nvimtree') ]],
  },
  {
    "akinsho/bufferline.nvim",
    config = [[ require('config.bufferline') ]],
  },
  {
    "folke/which-key.nvim",
    config = [[ require('config.whichkey') ]],
  },
  {
    "npxbr/glow.nvim",
    run = "GlowInstall",
    ft = "markdown",
  },
  {
    "nvim-neorg/neorg",
    ft = "norg",
    config = [[ require('config.neorg') ]],
  },
  {
    "danymat/neogen",
    after = "nvim-treesitter",
    cmd = "Neogen",
    config = [[ require('config.neogen') ]],
  },
  {
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
    config = [[ require("toggleterm").setup() ]],
  },

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    config = [[ require('config.gitsigns') ]],
    event = "BufRead",
  },
  {
    "TimUntersberger/neogit",
    cmd = "Neogit",
  },
  {
    "sindrets/diffview.nvim",
    cmd = "Diffview*",
  },

  -- UI
  {
    "mjlbach/onedark.nvim",
    config = [[ require('config.onedark') ]],
  },
  {
    "nvim-lualine/lualine.nvim",
    config = [[ require('config.lualine') ]],
  },
  -- indent lines
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    config = [[ require('config.indentline') ]],
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = [[ require('colorizer').setup() ]],
  },
  {
    "p00f/nvim-ts-rainbow",
    after = "nvim-treesitter",
    config = [[ require('config.rainbow') ]],
  },

  -- Editor
  {
    "numToStr/Comment.nvim",
    event = "BufReadPost",
    config = [[ require('Comment').setup() ]],
  },
  {
    "ggandor/lightspeed.nvim",
    event = "BufReadPost",
    config = [[ require('config.lightspeed') ]],
  },
  {
    "Pocco81/TrueZen.nvim",
    cmd = "TZAtaraxis",
    config = [[ require("true-zen").setup() ]],
  },

  -- Programming
  {
    "simrat39/symbols-outline.nvim",
    cmd = { "SymbolsOutline" },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = [[ require('config.treesitter') ]],
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
  },
  {
    "windwp/nvim-autopairs",
    after = "nvim-cmp",
    config = [[ require('config.autopairs') ]],
  },
  {
    "windwp/nvim-ts-autotag",
    after = "nvim-autopairs",
    config = [[ require("nvim-ts-autotag").setup() ]],
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    config = [[ require('config.lsp') ]],
  },
  {
    "hrsh7th/nvim-cmp",
    config = [[ require('config.cmp') ]],
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "onsails/lspkind-nvim",
    },
  },
  {
    "L3MON4D3/LuaSnip",
    config = [[ require('config.luasnip') ]],
    requires = {
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
    },
  },
  { "williamboman/nvim-lsp-installer" },
  { "ray-x/lsp_signature.nvim" },
  { "jose-elias-alvarez/null-ls.nvim" },
  {
    "kosayoda/nvim-lightbulb",
    config = [[ require('config.lightbulb') ]],
  },
}

return packer.startup({
  function(use)
    for _, p in pairs(plugins) do
      use(p)
    end
  end,
  config = {
    max_jobs = 20,
    git = {
      clone_timeout = 10,
    },
  },
})
