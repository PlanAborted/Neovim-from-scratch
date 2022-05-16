local Job = require("plenary.job")

local utility = require("user.utility")

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

local function createPnpmRunCommandKitty(config)
	config.hold = config.hold or true

	return "kitty"
		.. utility.ternary(config.hold == true, " --hold", "")
		.. " docker-compose exec -w "
		.. getFileDirPath(config.root)
		.. " server pnpm run "
		.. config.command
		.. " &"
end

local function runPnpmRunCommandKitty(config)
	io.popen(createPnpmRunCommandKitty(config))
end

local function newDcJob(args, notifConfig, timer)
	-- TODO: add name of the package in title of description
	local job = Job:new({
		command = "docker-compose",
		args = args,
		cwd = vim.fn.expand("%:p:h"),
		env = { PATH = vim.env.PATH },
		on_exit = function(j, result)
			timer:close()
			-- vim.api.nvim_win_close()
			if tonumber(vim.inspect(result)) == 0 then
				vim.notify("Finished with success !", vim.log.levels.INFO, {
					title = notifConfig.title,
					icon = utility.icons.success,
					timeout = 3000,
					hide_from_history = false,
				})
			else
				vim.notify(
					"Finished with errors ! \n" .. utility.joinAndEscapeAnsi(j:result(), "\n"),
					vim.log.levels.ERROR,
					{
						title = notifConfig.title,
						icon = utility.icons.error,
						timeout = 10000,
						hide_from_history = false,
						on_open = function(win)
							local buf = vim.api.nvim_win_get_buf(win)
							vim.api.nvim_buf_set_option(buf, "filetype", "bash")
						end,
					}
				)
			end
		end,
	})

	return {
		start = function()
			job:start()
		end,
	}
end

local function getNextSpinner(data)
	if data.index < #utility.icons.spinner then
		data.index = data.index + 1
	else
		data.index = 1
	end
	return utility.icons.spinner[data.index]
end

local function runDcCommandJob(args, notifConfig)
	local notification
	local spinnerData = { index = 0 }
	local timer = vim.loop.new_timer()
	timer:start(
		0,
		150,
		vim.schedule_wrap(function()
			notification = vim.notify(notifConfig.description, vim.log.levels.WARN, {
				title = notifConfig.title,
				icon = getNextSpinner(spinnerData),
				replace = notification,
				timeout = 300,
				hide_from_history = true,
			})
		end)
	)

	local newDCJob = newDcJob(args, notifConfig, timer)
	newDCJob.start()
end

local function runPnpmRunCommandJob(command, root, title)
	root = root or false
	local notification
	local data = { index = 0 }

	local timer = vim.loop.new_timer()
	timer:start(
		0,
		150,
		vim.schedule_wrap(function()
			notification = vim.notify("In progress ...\nFolder : " .. getFileDirPath(root), vim.log.levels.WARN, {
				title = title,
				icon = getNextSpinner(data),
				replace = notification,
				hide_from_history = true,
			})
		end)
	)
	local args = { "exec", "-T", "-w" .. getFileDirPath(root), "server", "pnpm", "run", command }

	local newDCJob = newDcJob(args, { title, notification }, timer)
	newDCJob.start()
end

local function prepareDcExecArgs(path, command)
	local args = { "exec", "-T", "-w" .. path, "server", "pnpm", "run", command }
	return args
end

local function prepareInProgressDesc(path)
	local desc = "In Progress ..."
	if path then
		desc = desc .. "\nFolder: " .. path
	end
	return desc
end

local M = {}

M.dcDown = function()
	local args = { "down" }
	local notifConfig = {
		title = "Shutting Docker containers down",
		description = prepareInProgressDesc(),
	}
	runDcCommandJob(args, notifConfig)
end

M.dcUp = function()
	local args = { "up", "-d" }
	local notifConfig = {
		title = "Spinning Docker containers up",
		description = prepareInProgressDesc(),
	}
	runDcCommandJob(args, notifConfig)
end

M.build = function()
	local config = {
		root = false,
		command = "build",
	}

	local path = getFileDirPath(config.root)

	local args = prepareDcExecArgs(path, config.command)

	local notifConfig = {
		title = "Building",
		description = prepareInProgressDesc(path),
	}
	runDcCommandJob(args, notifConfig)
end

M.buildAll = function()
	local config = {
		root = true,
		command = "build",
	}

	local path = getFileDirPath(config.root)

	local args = prepareDcExecArgs(path, config.command)

	local notifConfig = {
		title = "Building all packages",
		description = prepareInProgressDesc(path),
	}
	runDcCommandJob(args, notifConfig)
end

M.pluginsPackage = function()
	local config = {
		root = true,
		command = "plugins:package",
	}

	local path = getFileDirPath(config.root)

	local args = prepareDcExecArgs(path, config.command)

	local notifConfig = {
		title = "Packaging Plugins",
		description = prepareInProgressDesc(path),
	}
	runDcCommandJob(args, notifConfig)
end

M.test = function()
	local config = {
		command = "test",
		root = false,
		hold = true,
	}
	runPnpmRunCommandKitty(config)
end

M.watch = function()
	local config = {
		command = "watch",
		root = false,
		hold = true,
	}
	runPnpmRunCommandKitty(config)
end

return M
