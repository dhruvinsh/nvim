-- It all begins here

require("orion.config.options")
require("orion.config.autocmds")
require("orion.config.keymaps")
require("orion.config.lazy")

-- ---A function that allow to set color scheme
-- ---@param scheme? string or it uses vim.g.orion_color_scheme
-- ---| "'rose-pine'"
-- ---| "'onedark'"
-- ---| "'catppuccin'"
-- ---| "'gruvbox-material'"
-- ---| "'hybrid'"
-- local function SetColorscheme(scheme)
--   local color_scheme = scheme or vim.g.orion_color_scheme
--   vim.cmd.colorscheme(color_scheme)
-- end
--
-- SetColorscheme()
