local status_ok, fidget = pcall(require, "fidget")
if not status_ok then
	return
end

local config = {
	text = {
		spinner = "circle_halves", -- animation shown when tasks are ongoing
	},
	window = {
		blend = 0, -- &winblend for the window
	},
}

fidget.setup(config)
