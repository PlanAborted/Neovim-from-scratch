local Job = require("plenary.job")

local utility = require("user.utility")

local M = {}

M.jobs = {}

local function addJob(jobDef)
	table.insert(M.jobs, jobDef)
end

local function removeJob(jobIndex)
	table.remove(M.jobs, jobIndex)
end

local function indexOf(array, value)
	for i, v in ipairs(array) do
		if v == value then
			return i
		end
	end
	return nil
end

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
		.. " server "
		.. config.command
		.. " &"
end

local function runPnpmRunCommandKitty(config)
	io.popen(createPnpmRunCommandKitty(config))
end

local function newDcJob(args, notifConfig, timer)
	-- TODO: add name of the package in title of description
	local jobIndex = #M.jobs + 1

	local job = Job:new({
		command = "docker-compose",
		args = args,
		cwd = vim.fn.expand("%:p:h"),
		env = { PATH = vim.env.PATH },
		on_exit = function(j, result)
			timer:close()
			removeJob(jobIndex)
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

	addJob({ notifConfig.title .. " " .. notifConfig.path, job, jobIndex })

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

local function prepareDcExecArgs(path, command)
	local args
	if command == "install" then
		args = { "exec", "-T", "-w" .. path, "server", "pnpm", command }
	else
		args = { "exec", "-T", "-w" .. path, "server", "pnpm", "run", command }
	end
	return args
end

local function prepareInProgressDesc(path)
	local desc = "In Progress ..."
	if path then
		desc = desc .. "\nFolder: " .. path
	end
	return desc
end

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

M.install = function()
	local config = {
		root = false,
		command = "install",
	}

	local path = getFileDirPath(config.root)

	local args = prepareDcExecArgs(path, config.command)

	local notifConfig = {
		title = "Installing",
		description = prepareInProgressDesc(path),
		path = path,
	}
	runDcCommandJob(args, notifConfig)
end

M.installAll = function()
	local config = {
		root = true,
		command = "install",
	}

	local path = getFileDirPath(config.root)

	local args = prepareDcExecArgs(path, config.command)

	local notifConfig = {
		title = "Installing all packages",
		description = prepareInProgressDesc(path),
		path = path,
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
		path = path,
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
		path = path,
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
		path = path,
	}
	runDcCommandJob(args, notifConfig)
end

M.test = function()
	local config = {
		command = "pnpm run test",
		root = false,
		hold = true,
	}
	runPnpmRunCommandKitty(config)
end

M.watch = function()
	local config = {
		command = "pnpm run watch",
		root = false,
		hold = true,
	}
	runPnpmRunCommandKitty(config)
end

M.openBash = function()
	local config = {
		command = "bash",
		root = false,
		hold = true,
	}
	runPnpmRunCommandKitty(config)
end

M.openBashRoot = function()
	local config = {
		command = "bash",
		root = true,
		hold = true,
	}
	runPnpmRunCommandKitty(config)
end

return M
