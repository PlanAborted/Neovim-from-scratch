local status_ok, notify = pcall(require, "notify")
if not status_ok then
	return
end

notify.setup({
	fps = 60,
	stages = "slide",
	top_down = false,
})
