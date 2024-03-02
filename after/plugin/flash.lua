local utils = require("utils")

vim.keymap.set({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash" })

vim.keymap.set(
  { "n", "x", "o" },
  "<C-Space>",
  function() require("flash").treesitter() end,
  { desc = "Flash Treesitter" }
)

vim.keymap.set("o", "r", function() require("flash").remote() end, { desc = "Remote Flash" })

vim.keymap.set({ "o", "x" }, "R", function() require("flash").treesitter_search() end, { desc = "Treesitter Search" })

-- in command mode toggle the Flash, helpful in case of normal search required.
vim.keymap.set("c", "<C-Space>", function() require("flash").toggle() end, { desc = "Toggle Flash Search" })

-- disable based on big file
vim.api.nvim_create_autocmd("BufReadPre", {
  group = utils.augroup("big_file_disable", false),
  pattern = "*",
  callback = function(ev)
    if utils.is_big_buffer(ev.buf) then
      vim.notify("Big File: disabling flash", vim.log.levels.WARN)
      require("flash.plugins.search").enabled = false
    end
  end,
})
