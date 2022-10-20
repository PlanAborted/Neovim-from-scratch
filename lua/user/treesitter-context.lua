local status_ok, nvim_treesitter_context = pcall(require, "nvim-treesitter-context")
if not status_ok then
	return
end

nvim_treesitter_context.setup()
