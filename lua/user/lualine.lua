local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local hide_in_width = function(width)
	return function()
		return vim.fn.winwidth(0) > width
	end
end

local components = {
	mode = {
		"mode",
		padding = 1,
		icons_enabled = true,
	},
	branch = {
		"branch",
		icons_enabled = true,
		icon = "",
		cond = hide_in_width(60),
	},
	filename = {
		"filename",
		path = 1,
	},
	filetype = {
		"filetype",
		cond = hide_in_width(80),
	},
	location = {
		"location",
	},
	overseer = {
		"overseer",
	},
	progress = {
		"progress",
		left_padding = 2,
	},
}

lualine.setup({
	options = {
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		icons_enabled = true,
		theme = "auto",
		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
		always_divide_middle = false,
	},
	sections = {
		lualine_a = { components.mode },
		lualine_b = { components.branch },
		lualine_c = { components.filename },
		lualine_x = { components.overseer },
		lualine_y = { components.filetype, components.location },
		lualine_z = { components.progress },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { components.filename },
		lualine_x = { components.location },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
