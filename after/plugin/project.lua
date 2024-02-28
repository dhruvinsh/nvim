local project = require("project_nvim")
local utils = require("utils")

-- do not change global root_patterns
local root_patterns = vim.deepcopy(utils.root_patterns)
utils.tbl_append(root_patterns, ".hg")

project.setup({
  patterns = root_patterns,
  silent_chdir = false,
})

require("telescope").load_extension("projects")

vim.keymap.set("n", "<leader>fp", "<cmd>Telescope projects <cr>", { desc = "Projects" })
