require("which-key").setup({
  icons = {
    separator = " ",
  },
})

require("which-key").register({
  ["<leader>b"] = { name = "[B]uffers", _ = "which_key_ignore" },
  ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
  ["<leader>f"] = { name = "[F]iles", _ = "which_key_ignore" },
  ["<leader>d"] = { name = "[D]ebug", _ = "which_key_ignore" },
  ["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
  ["<leader>l"] = { name = "[L]sp", _ = "which_key_ignore" },
  ["<leader>q"] = { name = "[S]ession", _ = "which_key_ignore" },
  ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
  ["<leader>t"] = { name = "[T]oggle", _ = "which_key_ignore" },
  ["<leader>w"] = { name = "[W]indows", _ = "which_key_ignore" },
  ["<leader>x"] = { name = "[T]roubles", _ = "which_key_ignore" },
})
