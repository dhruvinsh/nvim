return {
  "andymass/vim-matchup",
  event = "InsertEnter",
  config = function()
    vim.g.matchup_matchparen_offscreen = { method = "popup" }

    ---@diagnostic disable-next-line
    require("nvim-treesitter.configs").setup({
      matchup = {
        enable = true,
      },
    })
  end,
}
