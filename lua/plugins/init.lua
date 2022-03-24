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
  -----------
  -- Tools
  -----------
  -- packer itself
  { "wbthomason/packer.nvim" },
  -- file manager
  {
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
      },
    },
    config = [[ require('config.telescope') ]],
  },
  -- icons
  {
    "kyazdani42/nvim-web-devicons",
    config = [[ require('config.icons') ]],
  },
  {
    "kyazdani42/nvim-tree.lua",
    cmd = "NvimTree*",
    config = [[ require('config.nvimtree') ]],
  },
  -- tablines
  {
    "akinsho/bufferline.nvim",
    config = [[ require('config.bufferline') ]],
    requires = "kyazdani42/nvim-web-devicons",
  },
  -- which-key
  {
    "folke/which-key.nvim",
    config = [[ require('config.whichkey') ]],
  },
  {
    "npxbr/glow.nvim",
    run = "GlowInstall",
    ft = "markdown",
  },
  -- note taking app
  {
    "nvim-neorg/neorg",
    ft = "norg",
    after = "nvim-treesitter",
    config = [[ require('config.neorg') ]],
    requires = { "nvim-lua/plenary.nvim" },
  },
  -- documents formating added
  {
    "danymat/neogen",
    after = "nvim-treesitter",
    config = [[ require('config.neogen') ]],
    requires = { "nvim-treesitter/nvim-treesitter" },
  },
  -- terminal app
  {
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
    config = [[ require("toggleterm").setup() ]],
  },

  -----------
  -- Git
  -----------
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = [[ require('config.gitsigns') ]],
    requires = { "nvim-lua/plenary.nvim" },
  },
  {
    "TimUntersberger/neogit",
    cmd = "Neogit",
    requires = { "nvim-lua/plenary.nvim" },
  },

  -----------
  -- UI
  -----------
  -- theme(s)
  {
    "mjlbach/onedark.nvim",
    config = [[ require('config.onedark') ]],
  },
  -- status line
  {
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = [[ require('config.lualine') ]],
  },
  -- indent lines
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    config = [[ require('config.indentline') ]],
  },
  -- todo
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "BufReadPost",
    config = [[ require("config.todo") ]],
  },
  -- colorizer
  {
    "norcalli/nvim-colorizer.lua",
    config = [[ require('colorizer').setup() ]],
  },
  -- color the brackets
  {
    "p00f/nvim-ts-rainbow",
    after = "nvim-treesitter",
    config = [[ require('config.rainbow') ]],
  },

  -----------
  -- Editor
  -----------
  -- comment plugin
  {
    "numToStr/Comment.nvim",
    event = "BufReadPost",
    config = [[ require('Comment').setup() ]],
  },
  -- motion on lightspeed
  {
    "ggandor/lightspeed.nvim",
    event = "BufReadPost",
    config = [[ require('config.lightspeed') ]],
  },
  -- autopairs
  {
    "windwp/nvim-autopairs",
    after = "nvim-cmp",
    config = [[ require('config.autopairs') ]],
    requires = { "windwp/nvim-ts-autotag" },
  },
  -- zenmode
  {
    "Pocco81/TrueZen.nvim",
    cmd = "TZFocus",
    config = [[ require("true-zen").setup() ]],
  },

  ---------------
  -- Programming
  ---------------
  -- incremental parser
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = [[ require('config.treesitter') ]],
    requires = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
  },

  -----------
  -- LSP
  -----------
  {
    "neovim/nvim-lspconfig",
    config = [[ require('config.lsp') ]],
    requires = {
      {
        "simrat39/symbols-outline.nvim",
        cmd = { "SymbolsOutline" },
      },
    },
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
  {
    "williamboman/nvim-lsp-installer",
  },
  {
    "ray-x/lsp_signature.nvim",
  },
  {
    "kosayoda/nvim-lightbulb",
    config = [[ require('config.lightbulb') ]],
  },
  {
    "folke/lsp-trouble.nvim",
    config = [[ require('config.trouble') ]],
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    requires = {
      "ThePrimeagen/refactoring.nvim",
    },
  },
  -----------
  -- Beta
  -----------
  -- all the plugins that are under beta (from my perspective) will reside here
  -- if no adverse effect found then it will move to plugins
  -- startup time
  -- {
  --   'henriquehbr/nvim-startup.lua',
  --   config = [[ require('nvim-startup') ]]
  -- },
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
