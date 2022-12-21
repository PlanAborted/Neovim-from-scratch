local status_ok, autosession = pcall(require, "auto-session")
if not status_ok then
	return
end

function _G.close_all_floating_wins()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local config = vim.api.nvim_win_get_config(win)
		if config.relative ~= "" then
			vim.api.nvim_win_close(win, false)
		end
	end
end

autosession.setup({
	log_level = "error",
	pre_save_cmds = {
		"lua require'nvim-tree'.setup()",
		"tabdo NvimTreeClose",
		"tabdo MindClose",
		_G.close_all_floating_wins,
	},
})
