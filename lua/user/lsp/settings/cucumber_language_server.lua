local opts = {
	cmd = { "cucumber-language-server", "--stdio" },
	filetypes = { "cucumber", "feature" },
	root_dir = require("lspconfig").util.find_git_ancestor,
	settings = {
		features = { "e2e/plankton-e2e/src/**/*.feature" },
		glue = { "e2e/plankton-e2e/src/**/*.ts" },
	},
}

return opts
