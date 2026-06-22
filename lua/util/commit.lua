local M = {}

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

  vim.notify("Generating commit message...", vim.log.levels.INFO)
  vim.system(
    { "claude", "--model", "sonnet", "-p", prompt },
    { text = true },
    vim.schedule_wrap(function(result)
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
