
local opt = vim.opt

-- Numeros lateral absolutos como relativos
opt.number = true
opt.relativenumber = true

-- Tabulaciones
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = false
opt.smartindent = true

-- Interfaz
opt.termguicolors = true
opt.mouse = "a"
opt.cursorline = true
opt.wrap = false
opt.splitright = true

--lista caracteres
opt.list = true
opt.listchars = {
	space = ".",
	tab = "→ ",
	eol = "¶",
}
