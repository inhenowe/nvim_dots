local status_ok, biscuits = pcall(require, "nvim-biscuits")
if not status_ok then
	return
end

biscuits.setup({
	default_config = {
		prefix_string = " ✨ ",
		min_distance = 5,
		highlight = "Comment",
	},
})
