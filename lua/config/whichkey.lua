-- This is an extention to exisiting keymaps

local wk = require("which-key")

wk.setup({
  spelling = {
    enable = true,
    suggestions = 20,
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
    d = "Delete",
    n = "Next",
    p = "Previous",
  },
  d = {
    name = "Doc(s)",
    c = "Class doc",
    f = "Function doc",
    F = "File doc",
    t = "Type doc",
  },
  f = {
    name = "File(s)",
    T = "Terminal",
    f = "Find files",
    r = "Recent files",
    t = "Tree",
    z = "Zen",
  },
  g = {
    name = "Git",
    f = "Files",
    g = "Neogit",
    h = {
      name = "+Hunk",
      P = "Preview",
      R = "Reset buffer",
      b = "Blame",
      n = "Next",
      p = "previous",
      r = "Reset",
      s = "Stage",
      u = "Undo stage",
    },
  },
  l = {
    name = "LSP",
    c = "Capabilities",
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
    t = "Tags",
  },
}

wk.register(labels, opt)

local vopt = {
  mode = "v",
  prefix = " ",
}

local vlabels = {
  g = {
    name = "Git",
    h = {
      name = "+Hunk",
      r = "Reset",
      s = "Stage",
    },
  },
}

wk.register(vlabels, vopt)
