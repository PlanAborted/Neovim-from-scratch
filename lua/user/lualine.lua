local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local hide_in_width = function(width)
	return function()
		return vim.fn.winwidth(0) > width
	end
end

local mode_map = {
	["n"] = "N",
	["no"] = "OP",
	["nov"] = "OP",
	["noV"] = "OP",
	["no\22"] = "OP",
	["niI"] = "NI",
	["niR"] = "NR",
	["niV"] = "N",
	["nt"] = "NT",
	["v"] = "V",
	["vs"] = "V",
	["V"] = "VL",
	["Vs"] = "VL",
	["\22"] = "VB",
	["\22s"] = "VB",
	["s"] = "S",
	["S"] = "SL",
	["\19"] = "SB",
	["i"] = "I",
	["ic"] = "IC",
	["ix"] = "IX",
	["R"] = "R",
	["Rc"] = "RC",
	["Rx"] = "RX",
	["Rv"] = "VR",
	["Rvc"] = "RVC",
	["Rvx"] = "RVX",
	["c"] = "C",
	["cv"] = "EX",
	["ce"] = "EX",
	["r"] = "R",
	["rm"] = "M",
	["r?"] = "C",
	["!"] = "SH",
	["t"] = "T",
}

local function modes()
	return mode_map[vim.api.nvim_get_mode().mode] or "__"
end

local components = {
	mode = {
		modes,
		padding = 2,
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
