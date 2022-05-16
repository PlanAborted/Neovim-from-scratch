local status_ok, lsp_signature = pcall(require, "lsp_signature")
if not status_ok then
	return
end

lsp_signature.setup({
	bind = true, -- This is mandatory, otherwise border config won't get registered.
	hint_enable = false,
	handler_opts = {
		border = "rounded",
	},
})
