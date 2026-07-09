require('blink.cmp').setup({
	-- Usa los atajos de teclado por defecto (Ctrl+N, Ctrl+P, Enter, Tab)
	keymap = { preset = 'default' },

appearance = {
		-- Si tienes una Nerd Font (la instalamos al principio), esto mostrará iconos bonitos
		use_nvim_cmp_as_default = true,
		nerd_font_variant = 'mono'
	},

	-- De dónde saca la información para autocompletar
	sources = {
		default = { 'lsp', 'path', 'snippets', 'buffer' },
	},

	-- Configuración de cómo se ve la ventana
	completion = {
		menu = { border = 'rounded' },
		documentation = { auto_show = true, window = { border = 'rounded' } }
	},

	-- Opcional: Integración para que tus firmas de funciones de LSP funcionen bien
	signature = { enabled = true }
})
