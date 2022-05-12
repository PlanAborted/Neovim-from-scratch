local Job = require("plenary.job")

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

local function ternary(cond, T, F)
	if cond == true then
		return T
	else
		return F
	end
end

local function createPnpmCommandKitty(command, root, hold)
	hold = hold or true

	return "kitty"
		.. ternary(hold == true, " --hold", "")
		.. " docker-compose exec -w "
		.. getFileDirPath(root)
		.. " server pnpm run "
		.. command
		.. " &"
end

-- local function createPnpmCommand(command, root, hold)
-- 	hold = hold or true
--
-- 	return "docker-compose exec -w " .. getFileDirPath(root) .. " server pnpm run " .. command .. " &"
-- end

local function runPnpmCommandKitty(command, root, hold)
	io.popen(createPnpmCommandKitty(command, root, hold))
end

local function join(table, delimiter)
	local string = ""
	for i = 1, #table - 1 do
		if table[i] then
			local ansiEscapedString = string.gsub(table[i], "[\27\155][][()#;?%d]*[A-PRZcf-ntqry=><~]", "")
			string = string .. delimiter .. ansiEscapedString
		end
	end
	return string
end

local spinner_frames = { "◐", "◓", "◑", "◒" }

local function runDCCommandJob(command, title)
	local notification
	local index = 0
	-- local spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }
	local currentSpinner = spinner_frames[index]
	local get_next_spinner = function()
		if index < #spinner_frames then
			index = index + 1
		else
			index = 1
		end
		return spinner_frames[index]
	end
	local timer = vim.loop.new_timer()
	timer:start(
		0,
		150,
		vim.schedule_wrap(function()
			currentSpinner = get_next_spinner()
			print(index)
			notification = vim.notify("In progress ...", vim.log.levels.WARN, {
				title = title,
				icon = currentSpinner,
				replace = notification,
				hide_from_history = true,
			})
		end)
	)
	local args
	if command == "down" then
		args = { "down" }
	else
		args = { "up", "-d" }
	end

	local job = Job:new({
		command = "docker-compose",
		args = args,
		cwd = vim.fn.expand("%:p:h"),
		env = { PATH = vim.env.PATH },
		on_exit = function(j, result)
			timer:close()
			if tonumber(vim.inspect(result)) == 0 then
				vim.notify("Finished with success !", vim.log.levels.INFO, {
					title = title,
					replace = notification,
					icon = "✓",
					timeout = 3000,
					hide_from_history = false,
				})
			else
				vim.notify("Finished with errors ! \n" .. join(j:result(), "\n"), vim.log.levels.ERROR, {
					title = title,
					icon = "✗",
					replace = notification,
					timeout = 10000,
					hide_from_history = false,
					on_open = function(win)
						local buf = vim.api.nvim_win_get_buf(win)
						vim.api.nvim_buf_set_option(buf, "filetype", "bash")
					end,
				})
			end
		end,
	})

	job:start()
end

local function runPnpmCommandJob(command, root, title)
	root = root or false
	local notification
	local index = 0
	local currentSpinner = spinner_frames[index]

	local get_next_spinner = function()
		if index < #spinner_frames then
			index = index + 1
		else
			index = 1
		end
		return spinner_frames[index]
	end

	local timer = vim.loop.new_timer()
	timer:start(
		0,
		150,
		vim.schedule_wrap(function()
			currentSpinner = get_next_spinner()
			notification = vim.notify("In progress ...\nFolder : " .. getFileDirPath(root), vim.log.levels.WARN, {
				title = title,
				icon = currentSpinner,
				replace = notification,
				hide_from_history = true,
			})
		end)
	)

	-- TODO: add name of the package in title of description
	local job = Job:new({
		command = "docker-compose",
		args = { "exec", "-T", "-w" .. getFileDirPath(root), "server", "pnpm", "run", command },
		cwd = vim.fn.expand("%:p:h"),
		env = { PATH = vim.env.PATH },
		on_exit = function(j, result)
			timer:close()
			if tonumber(vim.inspect(result)) == 0 then
				vim.notify("Finished with success !", vim.log.levels.INFO, {
					title = title,
					icon = "✓",
					timeout = 3000,
					hide_from_history = false,
				})
			else
				vim.notify("Finished with errors ! \n" .. join(j:result(), "\n"), vim.log.levels.ERROR, {
					title = title,
					icon = "✗",
					timeout = 10000,
					hide_from_history = false,
					on_open = function(win)
						local buf = vim.api.nvim_win_get_buf(win)
						vim.api.nvim_buf_set_option(buf, "filetype", "bash")
					end,
				})
			end
		end,
	})

	job:start()
end

function _PNPM_BUILD_TOGGLE()
	runPnpmCommandJob("build", false, "Building")
end

function _PNPM_TEST_TOGGLE()
	runPnpmCommandKitty("test", false, true)
end

function _PNPM_WATCH_TOGGLE()
	runPnpmCommandKitty("watch", false, true)
end

function _PNPM_PLUGINS_PACKAGE_TOGGLE()
	runPnpmCommandJob("plugins:package", true, "Packaging Plugins")
end

function _DC_DOWN()
	runDCCommandJob("down", "Shutting Docker containers down")
end

function _DC_UP()
	runDCCommandJob("up -d", "Spinning Docker containers up")
end
