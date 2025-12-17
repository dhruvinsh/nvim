return {
  "olimorris/codecompanion.nvim",
  version = "*", -- tagging to latest version
  cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    { "<leader>ac", "<cmd>CodeCompanionActions<cr>", desc = "action", mode = { "n", "v" } },
    { "<leader>at", "<cmd>CodeCompanionChat Toggle<cr>", desc = "toggle", mode = { "n", "v" } },
    { "<leader>gm", "<cmd>lua require('codecompanion').prompt('orion_commit') <cr>", desc = "message" },
  },
  opts = function()
    local component = require("util.codecompanion")
    require("util.lualine").inject_component({ "sections", "lualine_x" }, 1, component)

    return {
      adapters = {
        http = {
          opts = {
            show_model_choices = true,
          },
        },
      },
      strategies = {
        -- setting provider till snacks.nvim related PR gets merged
        chat = { adapter = "copilot" },
        inline = { adapter = "copilot" },
        agent = { adapter = "copilot" },
      },
      prompt_library = {
        ["git commits"] = {
          strategy = "inline",
          description = "Generate git commit for staged changes",
          opts = {
            placement = "replace",
            alias = "orion_commit",
            auto_submit = true,
            adapter = {
              name = "copilot",
              model = "gpt-4.1",
            },
          },
          prompts = {
            {
              role = "user",
              content = function()
                return string.format(
                  [[
You are an expert at writing git commit messages that strictly follow the Conventional Commits 1.0.0 specification.

Given the git diff below, generate a single commit message using this exact format:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

**REQUIREMENTS:**

**Type (REQUIRED):**
- Use appropriate type: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`, `perf`, `ci`, `build`, `revert`
- `feat` MUST be used for new features
- `fix` MUST be used for bug fixes
- Use lowercase for type

**Scope (OPTIONAL):**
- Add scope in parentheses if it helps clarify the change: `feat(api):`, `fix(parser):`
- Use nouns describing the affected codebase section

**Description (REQUIRED):**
- Write in imperative mood (e.g., "add feature" not "added feature")
- Keep concise and clear
- No period at the end
- Immediately follow the colon and space
- Keep the line length under 72 characters

**Breaking Changes:**
- Add `!` before colon for breaking changes: `feat!:` or `feat(scope)!:`
- OR add `BREAKING CHANGE:` footer (uppercase required)
- Use both if you want to emphasize the breaking change

**Body (OPTIONAL):**
- Add after one blank line from description
- Provide additional context, motivation, or implementation details
- Use free-form text, multiple paragraphs allowed
- Keep the line length under 72 characters

**Footers (OPTIONAL):**
- Add after one blank line from body (or description if no body)
- Format: `Token: value` or `Token #value`
- Use hyphens instead of spaces in tokens: `Reviewed-by:`, `Co-authored-by:`
- Exception: `BREAKING CHANGE:` can use spaces
- Common footers: `Refs:`, `Closes:`, `Reviewed-by:`, `Co-authored-by:`

**Examples:**
```
feat(auth): add OAuth2 authentication

fix!: remove deprecated API endpoints

BREAKING CHANGE: The /v1/users endpoint has been removed

docs: update installation instructions

feat(api): add user profile endpoints

Implement CRUD operations for user profiles including
avatar upload and privacy settings.

Refs: #123
Reviewed-by: John Doe
```

Respond with ONLY the commit message, no explanations or additional text.

Here is the git diff of staged changes:
```diff
%s
```
]],
                  vim.fn.system("git diff --no-ext-diff --staged")
                )
              end,
              opts = {
                contains_code = true,
              },
            },
          },
        },
      },
    }
  end,
}
