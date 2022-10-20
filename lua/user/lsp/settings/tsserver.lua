local opts = {
	settings = {
		completions = {
			completeFunctionCalls = true,
		},
	},
	root_dir = function(fname)
		return require("lspconfig").util.find_git_ancestor(fname) or vim.fn.getcwd()
	end,
}
return opts
