local present, icons = pcall(require, "nvim-web-devicons")
if not present then
  return
end

local colors = require("config.colors")

icons.setup({
  override = {
    xlsx = {
      icon = " ",
      color = colors.vibrant_green,
      name = "Xlsx",
    },
    docx = {
      icon = " ",
      color = colors.blue,
      name = "Docx",
    },
    [".gitignore"] = {
      icon = " ",
      color = colors.white,
      name = "GitIgnore",
    },
    markdown = {
      icon = " ",
      color = colors.teal,
      name = "Markdown",
    },
    md = {
      icon = " ",
      color = colors.teal,
      name = "Md",
    },
    mdx = {
      icon = " ",
      color = colors.teal,
      name = "Mdx",
    },
    html = {
      icon = " ",
      color = colors.baby_pink,
      name = "html",
    },
    css = {
      icon = " ",
      color = colors.blue,
      name = "css",
    },
    js = {
      icon = " ",
      color = colors.sun,
      name = "js",
    },
    ts = {
      icon = "ﯤ ",
      color = colors.teal,
      name = "ts",
    },
    kt = {
      icon = "󱈙 ",
      color = colors.orange,
      name = "kt",
    },
    png = {
      icon = " ",
      color = colors.dark_purple,
      name = "png",
    },
    jpg = {
      icon = " ",
      color = colors.dark_purple,
      name = "jpg",
    },
    jpeg = {
      icon = " ",
      color = colors.dark_purple,
      name = "jpeg",
    },
    mp3 = {
      icon = " ",
      color = colors.white,
      name = "mp3",
    },
    mp4 = {
      icon = " ",
      color = colors.white,
      name = "mp4",
    },
    out = {
      icon = " ",
      color = colors.white,
      name = "out",
    },
    Dockerfile = {
      icon = " ",
      color = colors.cyan,
      name = "Dockerfile",
    },
    rb = {
      icon = " ",
      color = colors.pink,
      name = "rb",
    },
    vue = {
      icon = "﵂",
      color = colors.vibrant_green,
      name = "vue",
    },
    py = {
      icon = " ",
      color = colors.blue,
      name = "py",
    },
    deb = {
      icon = " ",
      color = colors.cyan,
      name = "deb",
    },
    lock = {
      icon = " ",
      color = colors.red,
      name = "lock",
    },
    lua = {
      icon = " ",
      color = colors.blue,
      name = "lua",
    },
    rpm = {
      icon = " ",
      color = colors.orange,
      name = "rpm",
    },
    toml = {
      icon = " ",
      color = colors.blue,
      name = "toml",
    },
    xz = {
      icon = " ",
      color = colors.sun,
      name = "xz",
    },
    yaml = {
      icon = " ",
      color = colors.red,
      name = "Yaml",
    },
    yml = {
      icon = " ",
      color = colors.red,
      name = "Yml",
    },
    zip = {
      icon = " ",
      color = colors.sun,
      name = "zip",
    },
  },
})
