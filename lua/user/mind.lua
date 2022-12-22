local status_ok, mind = pcall(require, "mind")
if not status_ok then
	return
end

mind.setup({
	ui = {
		width = 50,
		open_direction = "right",
		close_on_file_open = true,
	},
	keymaps = {
		normal = {
			["l"] = "toggle_node",
			["L"] = "toggle_node",
			["h"] = "toggle_node",
			["H"] = "toggle_parent",
			["y"] = "copy_node_link",
			["Y"] = "copy_node_link_index",
			["v"] = "select",
		},
		selection = {
			["l"] = "toggle_node",
			["L"] = "toggle_node",
			["h"] = "toggle_node",
			["H"] = "toggle_node",
			["v"] = "select",
		},
	},
})
