return {
  "letieu/jira.nvim",
  cmd = { "Jira" },
  opts = {
    jira = {
      base = vim.env.JIRA_BASE,
      email = vim.env.JIRA_EMAIL,
      token = vim.env.JIRA_API_TOKEN,
      limit = 500,
    },
  },
}
