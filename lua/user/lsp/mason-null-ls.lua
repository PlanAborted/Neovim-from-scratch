local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
	return
end

require("mason-null-ls").setup({
	ensure_installed = { "prettierd", "eslint_d", "stylua", "jq" },
})

require("mason-null-ls").setup_handlers({
	prettierd = function()
		null_ls.register(null_ls.builtins.formatting.prettierd)
	end,
	eslint_d = function()
		null_ls.register(null_ls.builtins.formatting.eslint_d)
	end,
})
