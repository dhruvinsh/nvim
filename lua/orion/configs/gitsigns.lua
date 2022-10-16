local status_ok, gitsigns = pcall(require, "gitsigns")

if status_ok then
  gitsigns.setup({
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "▎" },
      topdelete = { text = "契" },
      changedelete = { text = "▎" },
    },
  })
end
