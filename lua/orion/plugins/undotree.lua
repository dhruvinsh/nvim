return {
  "mbbill/undotree",
  cmd = { "UndotreeToggle", "UndotreeShow" },
  keys = {
    { "<leader>cu", "<cmd>UndotreeToggle<cr>", desc = "undotree" },
  },
  config = function()
    vim.g.undotree_WindowLayout = 2
    vim.g.undotree_SplitWidth = 35
    vim.g.undotree_DiffpanelHeight = 15
    vim.g.undotree_SetFocusWhenToggle = 1
    if require("util").is_win then
      vim.g.undotree_DiffCommand = "FC"
    else
      vim.g.undotree_DiffCommand = "diff"
    end
  end,
}
