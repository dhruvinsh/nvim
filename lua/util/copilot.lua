local M = require("lualine.component"):extend()

M.spinner_index = 1

local spinner_symbols = {
  "◜",
  "◠",
  "◝",
  "◞",
  "◡",
  "◟",
}
local spinner_symbols_len = 6

-- Initialize
function M:init(options)
  M.super.init(self, options)

  local group = vim.api.nvim_create_augroup("CopilotHook", {})
  vim.api.nvim_create_autocmd("LspAttach", {
    desc = "Copilot Status",
    group = group,
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      if client and client.name == "copilot" then
        require("copilot.status").register_status_notification_handler(function()
          require("lualine").refresh()
        end)
      end
    end,
  })
end

-- Function that runs every time status line is updated
function M:update_status()
  local status = require("copilot.status").data.status
  if (status == "InProgress") or (status == "Warning") then
    self.spinner_index = (self.spinner_index % spinner_symbols_len) + 1
    return spinner_symbols[self.spinner_index]
  else
    return nil
  end
end

return M
