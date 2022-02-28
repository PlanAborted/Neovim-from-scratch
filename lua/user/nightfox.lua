local status_ok, nightfox = pcall(require, "nightfox")
if not status_ok then
	return
end

-- This function set the configuration of nightfox. If a value is not passed in the setup function
-- it will be taken from the default configuration above
nightfox.setup({
	fox = "nightfox", -- change the colorscheme to use nordfox
	transparent = "true",
	styles = {
		comments = "italic", -- change style of comments to be italic
		keywords = "bold", -- change style of keywords to be bold
		functions = "italic,bold", -- styles can be a comma separated list
	},
	colors = {
		red = "#FF000", -- Override the red color for MAX POWER
		bg_alt = "#000000",
	},
	hlgroups = {
		TSPunctDelimiter = { fg = "${red}" }, -- Override a highlight group with the color red
		LspCodeLens = { bg = "#000000", style = "italic" },
	},
})

nightfox.load()
