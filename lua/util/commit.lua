local M = {}

-- Lualine status component
local StatusComponent = require("lualine.component"):extend()
StatusComponent.processing = false
StatusComponent.spinner_index = 1

local spinner_symbols = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
local spinner_symbols_len = 10

function StatusComponent:init(options)
  StatusComponent.super.init(self, options)
  local group = vim.api.nvim_create_augroup("ClaudeCommitHooks", {})
  vim.api.nvim_create_autocmd("User", {
    pattern = "ClaudeCommit*",
    group = group,
    callback = function(event)
      if event.match == "ClaudeCommitStarted" then
        self.processing = true
      elseif event.match == "ClaudeCommitFinished" then
        self.processing = false
      end
    end,
  })
end

function StatusComponent:update_status()
  if self.processing then
    self.spinner_index = (self.spinner_index % spinner_symbols_len) + 1
    return spinner_symbols[self.spinner_index]
  else
    return nil
  end
end

M.status_component = StatusComponent

function M.generate()
  local diff = vim.system({ "git", "diff", "--no-ext-diff", "--staged" }, { text = true }):wait().stdout

  if not diff or diff:match("^%s*$") then
    vim.notify("No staged changes", vim.log.levels.WARN)
    return
  end

  local prompt_file = vim.fn.stdpath("config") .. "/prompts/commit.md"
  local ok, lines = pcall(vim.fn.readfile, prompt_file)
  if not ok then
    vim.notify("Could not read commit prompt", vim.log.levels.ERROR)
    return
  end

  local content = table.concat(lines, "\n")
  local user_section = content:match("## user%s*\n(.*)")
  if not user_section then
    vim.notify("Could not parse commit prompt", vim.log.levels.ERROR)
    return
  end

  local prompt = user_section:gsub("${commit%.diff}", diff)

  vim.api.nvim_exec_autocmds("User", { pattern = "ClaudeCommitStarted" })
  vim.system(
    { "claude", "--model", "sonnet", "-p", prompt },
    { text = true },
    vim.schedule_wrap(function(result)
      vim.api.nvim_exec_autocmds("User", { pattern = "ClaudeCommitFinished" })
      if result.code ~= 0 then
        vim.notify("Claude error: " .. (result.stderr or "unknown"), vim.log.levels.ERROR)
        return
      end
      local msg = vim.trim(result.stdout)
      msg = msg:gsub("^```%w*\n", ""):gsub("\n```$", "")
      msg = vim.trim(msg)
      if msg == "" then
        return
      end
      local buf_lines = vim.split(msg, "\n")
      local bufnr = vim.api.nvim_get_current_buf()
      vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, buf_lines)
      vim.api.nvim_win_set_cursor(0, { 1, 0 })
    end)
  )
end

return M
