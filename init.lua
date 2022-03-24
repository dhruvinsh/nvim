local present, impatient = pcall(require, "impatient")

if present then
   impatient.enable_profile()
end

local core_modules = {
  "core",
  "plugins",
}

for _, m in ipairs(core_modules) do
  local ok, err = pcall(require, m)
  if not ok then
    error("Error loading" .. m .."\n\n" .. err)
  end
end
