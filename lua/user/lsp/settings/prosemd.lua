local opts = {
	-- Update the path to prosemd-lsp
	-- cmd = { "/usr/local/bin/prosemd-lsp", "--stdio" },
	filetypes = { "markdown" },
	root_dir = function(fname)
		return require("lspconfig").util.find_git_ancestor(fname) or vim.fn.getcwd()
	end,
	settings = {},
}
return opts
