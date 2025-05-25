return {
  "HakonHarnes/img-clip.nvim",
  cmd = { "PasteImage" },
  keys = {
    { "<leader>cp", "<cmd>PasteImage<cr>", desc = "paste image" },
  },
  opts = {
    filetypes = {
      codecompanion = {
        prompt_for_file_name = false,
        template = "[Image]($FILE_PATH)",
        use_absolute_path = true,
      },
    },
  },
}
