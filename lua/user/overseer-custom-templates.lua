local status_ok, overseer = pcall(require, "overseer")
if not status_ok then
	return
end
local utility = require("user.utility")
local ternary = utility.ternary

local function getFileDirPath(root)
	root = root or false

	local baseDir = "/home/app/"

	if root == true then
		return baseDir
	else
		local fileDirPath = tostring(vim.fn.expand("%:p:h"))
		return baseDir .. string.sub(fileDirPath, 39)
	end
end

overseer.register_template({
	-- Required fields
	name = "run",
	builder = function(params)
		-- This must return an overseer.TaskDefinition
		return {
			cmd = {
				"docker-compose",
				"exec",
				"-w",
				getFileDirPath(params.root),
				"server",
				"pnpm",
				ternary(params.command == "install", "", "run"),
				params.command,
			},
			components = {
				-- {
				-- 	"on_output_parse",
				-- 	parser = {
				-- 		-- Put the parser results into the 'diagnostics' field on the task result
				-- 		diagnostics = {
				-- 			-- Extract fields using lua patterns
				-- 			{ "extract", "^([^%s].+):(%d+):(%d+) - (.+)", "filename", "lnum", "col", "text" },
				-- 		},
				-- 	},
				-- 	-- on_result = function(self, task, result)
				-- 	-- 	-- Called when a component has results to set. Usually this is after the command has completed, but certain types of tasks may wish to set a result while still running.
				-- 	-- 	vim.diagnostic.set("test", 0, result.diagnostic)
				-- 	-- 	vim.diagnostic.setloclist()
				-- 	-- end,
				-- },

				"on_output_summarize",
				-- { "on_result_diagnostics_quickfix", use_loclist = true },
				"on_exit_set_status",
				"on_complete_notify",
				"on_complete_dispose",
			},
		}
	end,
	-- Optional fields
	desc = "Optional description of task",
	params = {
		-- See :help overseer.params
	},
	-- Determines sort order when choosing tasks. Lower comes first.
	priority = 50,
	-- Add requirements for this template. If they are not met, the template will not be visible.
	-- All fields are optional.
	condition = {
		-- A string or list of strings
		-- Only matches when current buffer is one of the listed filetypes
		filetype = { "typescript" },
		-- A string or list of strings
		-- Only matches when cwd is inside one of the listed dirs
		dir = "~/code/pro/plankton",
		-- Arbitrary logic for determining if task is available
		callback = function(search)
			print(vim.inspect(search))
			return true
		end,
	},
})
local M = {}

M.run = function(command, root)
	overseer.run_template({ name = "run", params = { command = command, root = root } })
end

return M
