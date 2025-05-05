local M = {}

--- Injects a component into a lualine section.
--- @param section table {string, string} The path to the section (e.g., {"sections", "lualine_x"}).
--- @param position integer The 1-based index to insert the component at.
--- @param component table|function|string The lualine component to inject.
function M.inject_component(section, position, component)
  -- Validate section input
  if type(section) ~= "table" or #section ~= 2 or type(section[1]) ~= "string" or type(section[2]) ~= "string" then
    vim.notify('Invalid section format. Expected table like {"sections", "lualine_x"}', vim.log.levels.ERROR)
    return
  end
  local section_type = section[1] -- e.g., "sections" or "inactive_sections"
  local section_name = section[2] -- e.g., "lualine_x"

  local ok, lualine = pcall(require, "lualine")
  if not ok then
    vim.notify("Lualine not found, cannot inject component.", vim.log.levels.WARN)
    return
  end

  -- Ensure lualine.setup has been called and config is available
  local lualine_cfg = lualine.get_config and lualine.get_config()
  if not lualine_cfg then
    vim.notify("Lualine config not found.", vim.log.levels.WARN)
    return
  end

  -- Check if the top-level key exists (e.g., lualine_cfg.sections)
  if not lualine_cfg[section_type] then
    vim.notify("Lualine config key '" .. section_type .. "' not found.", vim.log.levels.WARN)
    return
  end

  -- Check if the specific section list exists (e.g., lualine_cfg.sections.lualine_x)
  local target_section_list = lualine_cfg[section_type][section_name]
  if not target_section_list then
    vim.notify(
      "Lualine section '" .. section_name .. "' not found within '" .. section_type .. "'.",
      vim.log.levels.WARN
    )
    return
  end

  -- Ensure the position is valid
  local section_len = #target_section_list
  position = math.max(1, math.min(position, section_len + 1))

  table.insert(target_section_list, position, component)
  lualine.setup(lualine_cfg) -- Reapply the configuration
end

return M
