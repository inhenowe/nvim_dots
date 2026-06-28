--[[
	Configuracion de nvim simple con plugins minimos
	y estilo minimalista.
	Realizado por={
		github := inhenowe,
		gmail := inhenowe@gmail.com,
	}
]]--

--| Atajos de teclado, funciones y config de vim |--
require("core.options")
require("core.keymaps")
require("core.functions")

--|Plugins y configuraciones de plugins |----------
require("plugins.plugins")

vim.env.QML_IMPORT_PATH = "/usr/lib/qt6/qml"
vim.env.QML2_IMPORT_PATH = "/usr/lib/qt6/qml"
