local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	return
end

bufferline.setup({
	highlights = {
		buffer_selected = {
			bold = true,
		},
		indicator_selected = {
			fg = { attribute = "fg", highlight = "LspDiagnosticsDefaultHint" },
			bg = { attribute = "bg", highlight = "Normal" },
		},
		separator_selected = {
			fg = "none",
			bg = "none",
		},
		separator_visible = {
			fg = "none",
			bg = "none",
		},
		separator = {
			fg = "none",
			bg = "none",
		},
	},
	options = {
		show_close_icon = false,
		diagnostics = "nvim_lsp",
		always_show_bufferline = false,
		separator_style = { "", "" },
		left_trunc_marker = "",
		right_trunc_marker = "",
		indicator = {
			style = "underline",
		},
		diagnostics_indicator = function(_, _, diag)
			local s = {}
			return table.concat(s, " ")
		end,
		show_buffer_close_icons = false,
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				highlight = "Directory",
				text_align = "left",
			},
		},
	},
})
