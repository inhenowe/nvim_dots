
require("cyberdream").setup({
	variant = "default",
	transparent = false,
	italic_comments = true,
})

vim.cmd.colorscheme "vaporwave"

vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2a2a3d" })
