---
name: git commits
interaction: inline
description: Generate git commit for staged changes
opts:
  alias: orion_commit
  placement: replace
  auto_submit: true
  adapter:
    name: copilot
    model: gpt-4.1
---

## user

You are an expert at writing git commit messages that strictly follow the
Conventional Commits 1.0.0 specification.

Given the git diff below, generate a single commit message using this exact format:

```gitcommit
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

**REQUIREMENTS:**

**Type (REQUIRED):**

- Use appropriate type: `feat`, `fix`, `docs`, `style`, `refactor`, `test`,
  `chore`, `perf`, `ci`, `build`, `revert`
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

**Footers (CRITICAL RULES):**

- DO NOT include footers like `Refs:`, `Closes:`, `Reviewed-by:`, or
  `Co-authored-by:` unless explicitly required
- ONLY add footers if the information is clearly available in the diff or context
- NEVER invent or assume issue numbers, reviewer names, or references
- If adding `BREAKING CHANGE:` footer, add it after one blank line from body

**Examples:**

```gitcommit
feat(auth): add OAuth2 authentication

fix!: remove deprecated API endpoints

BREAKING CHANGE: The /v1/users endpoint has been removed

docs: update installation instructions

feat(api): add user profile endpoints

Implement CRUD operations for user profiles including
avatar upload and privacy settings.
```

**IMPORTANT:** Respond with ONLY the commit message. Do not add any footers
(Refs, Closes, etc.) unless you have explicit information from the diff. Do not
add explanations or additional text.

Here is the git diff of staged changes:

```diff
${commit.diff}
```
