local status_ok, autosave = pcall(require, "auto-save")

if status_ok then
  autosave.setup({
    condition = function(buf)
      local utils = require("auto-save.utils.data")

      -- certain filetype that I don't want auto-save
      local ignore_ft = { "NeogitCommitMessage", "NvimTree", "TelescopePrompt" }
      local detect_ft = vim.fn.getbufvar(buf, "&filetype")

      -- conditions where auto-save should work
      local is_modifiable = vim.fn.getbufvar(buf, "&modifiable")
      local is_ft_okay = utils.not_in(detect_ft, ignore_ft)

      if is_modifiable and is_ft_okay then
        return true
      end

      return false
    end,
  })
end
