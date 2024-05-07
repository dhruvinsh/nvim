return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    menu = {
      width = vim.api.nvim_win_get_width(0) - 4,
    },
  },
  keys = function()
    local harpoon = require("harpoon")
    local keys = {
      { "<leader>H", function() harpoon:list():add() end, desc = "Harpoon File" },
      { "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Harpoon Quick Menu" },
    }

    for i = 1, 5 do
      table.insert(keys, { "<leader>" .. i, function() harpoon:list():select(i) end, desc = "Harpoon to File " .. i })
    end
    return keys
  end,
}
