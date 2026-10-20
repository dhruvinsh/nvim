return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@module "snacks"
  ---@type snacks.Config
  opts = {
    input = { enabled = true },
    picker = { enabled = true },
    image = {
      enabled = true,
      -- snacks defaults minus "pdf": pdfs open as text in lua/orion/viewer, `gp` shows the page image
      formats = {
        "png",
        "jpg",
        "jpeg",
        "gif",
        "bmp",
        "webp",
        "tiff",
        "heic",
        "avif",
        "mp4",
        "mov",
        "avi",
        "mkv",
        "webm",
        "icns",
      },
    },
  },
}
