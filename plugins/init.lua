return {
    ["folke/which-key.nvim"] = {
        disable = false,
    },
    ["max397574/better-escape.nvim"] = {
        event = "InsertEnter",
        config = function()
            require("better_escape").setup()
        end,
    },
    ["TimUntersberger/neogit"] = {
        cmd = require("custom.lazy_load").neogit_cmds,
        requires = "nvim-lua/plenary.nvim",
    },
   ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
       require "custom.plugins.null-ls"
    end,
   },
}
