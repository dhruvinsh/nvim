vim.filetype.add({
  extension = {
    jsonl = "jsonl",
    jsonlines = "jsonl",
  },
  pattern = {
    ["%.vscode/.+%.json"] = "json5",
  },
})
