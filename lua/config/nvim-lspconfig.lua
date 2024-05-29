return {
  "neovim/nvim-lspconfig",
  init = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    -- disable a keymap
    keys[#keys + 1] = { "<leader>cl", false }
    -- change a keymap
    keys[#keys + 1] = { "<leader>ll", "<cmd>LspInfo<cr>" }
  end,
}
