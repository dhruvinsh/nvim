-- This is an extention to exisiting keymaps

local wk = require("which-key")

wk.setup({
  spelling = {
    enable = true,
    suggestions = 20
  },
  window = {
    border = "single",
    margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 0, 0, 1, 0 }, -- extra window padding [top, right, bottom, left]
  },
})

local opt = { prefix = "<leader>" }

-- just the labels holder, for some existing keymaps
local labels = {
  b = {
    name = "Buffer(s)",
    b = "Buffers",
  },
  f = {
    name = "File(s)",
    f = "Find files",
    r = "Recent files",
  },
  g = {
    name = "Git",
    g = "Git files",
  },
  l = {
    name = "LSP",
    i = "Info",
    r = "Restart",
    s = "Start",
    t = "Terminate",
  },
  s = {
    name = "Search",
    C = "Color Schemes",
    c = "Commands",
    f = "Find files",
    g = "Grep Live",
    h = "Helps",
    k = "Keymaps",
    s = "String grep",
    t = "Tags"
  },
}

wk.register(labels, opt)
