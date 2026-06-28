
require("neo-tree").setup({
	window = {
		width = 30,
	},
	default_component_configs = {
		indent = {
			indent_size = 2,
			padding = 1,
			-- Guías visuales de niveles
			with_markers = true,
			indent_marker = "│",
			last_indent_marker = "└",
			highlight = "NeoTreeIndentMarker",
			-- Expansor de carpetas
			with_expanders = true,
			expander_collapsed = "",
			expander_expanded = "",
		},
	},
})

-- Línea de selección completa (no solo el bloque del cursor)
vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = "#2a2a3d", bold = true })
vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = "#444466" })
