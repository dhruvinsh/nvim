vim.g.loaded = 1

local status_ok, nvimtree = pcall(require, "nvim-tree")

if status_ok then
  nvimtree.setup({
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = true,
    },
  })
end
