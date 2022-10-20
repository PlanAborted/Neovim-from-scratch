-- vim.g.tokyonight_style = "night"
-- vim.g.tokyonight_transparent = true
-- vim.g.tokyonight_transparent_sidebar = true
-- vim.g.tokyonight_colors = {
-- 	bg_float = "none",
-- 	comment = "#6a739e",
-- }
local status_ok, tokyonight = pcall(require, "tokyonight")
if not status_ok then
	return
end
tokyonight.setup({

	style = "night",
	transparent = true,
	transparent_sidebar = true,
	styles = {
		sidebars = "transparent",
		floats = "transparent",
	},
})
