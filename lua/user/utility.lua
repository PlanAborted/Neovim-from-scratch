local M = {}

-- Custom functions and constants used project wise

M.icons = {
	success = "",
	error = "",
	info = "",
	question = "",
	warning = "",
	spinner = { "◐", "◓", "◑", "◒" },
}

M.ternary = function(cond, T, F)
	if cond == true then
		return T
	else
		return F
	end
end

M.joinAndEscapeAnsi = function(table, delimiter)
	local string = ""
	for i = 1, #table - 1 do
		if table[i] then
			local ansiEscapedString = string.gsub(table[i], "[\27\155][][()#;?%d]*[A-PRZcf-ntqry=><~]", "")
			string = string .. delimiter .. ansiEscapedString
		end
	end
	return string
end

-- LSP integration (NVIM Notify)
-- Utility functions shared between progress reports for LSP and DAP

local client_notifs = {}

M.get_notif_data = function(client_id, token)
	if not client_notifs[client_id] then
		client_notifs[client_id] = {}
	end

	if not client_notifs[client_id][token] then
		client_notifs[client_id][token] = {}
	end

	return client_notifs[client_id][token]
end

M.update_spinner = function(client_id, token)
	local notif_data = M.get_notif_data(client_id, token)

	if notif_data.spinner then
		local new_spinner = (notif_data.spinner + 1) % #M.icons.spinner
		notif_data.spinner = new_spinner

		notif_data.notification = vim.notify(nil, nil, {
			hide_from_history = true,
			icon = M.icons.spinner[new_spinner],
			replace = notif_data.notification,
		})

		vim.defer_fn(function()
			M.update_spinner(client_id, token)
		end, 100)
	end
end

M.format_title = function(title, client_name)
	return client_name .. (#title > 0 and ": " .. title or "")
end

M.format_message = function(message, percentage)
	return (percentage and percentage .. "%\t" or "") .. (message or "")
end

return M
