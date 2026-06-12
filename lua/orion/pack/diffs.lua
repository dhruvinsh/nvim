-- diffs.nvim — unified/stacked/split diffs against revisions (:Diff, :Diff review)
-- https://github.com/barrettruth/diffs.nvim

-- Configured via vim.g.diffs (no setup() call). Integrations auto-detect, so
-- this is optional — uncomment to override. See the README for all options.
vim.g.diffs = {
  integrations = { fugitive = true, gitsigns = true },
}

vim.pack.add({
  { src = "https://github.com/barrettruth/diffs.nvim" },
}, { load = true })
