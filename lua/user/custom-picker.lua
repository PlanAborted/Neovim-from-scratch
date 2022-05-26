local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local M = {}
-- our picker function: colors
local jobs = function(opts)
	opts = opts or {}
	pickers.new(opts, {
		prompt_title = "Running Jobs",
		finder = finders.new_table({
			results = require("user.custom").jobs,
			entry_maker = function(entry)
				return {
					value = entry,
					display = entry[1],
					ordinal = entry[1],
				}
			end,
		}),
		sorter = conf.generic_sorter(opts),
		attach_mappings = function(prompt_bufnr, map)
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
				local selection = action_state.get_selected_entry()

				-- print(vim.inspect(selection.value[2]))
				selection.value[2]:shutdown()
				-- vim.api.nvim_put({ selection[1] }, "", false, true)
			end)
			return true
		end,
	}):find()
end

M.jobs = jobs

return M
