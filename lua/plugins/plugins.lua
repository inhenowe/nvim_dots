require "paq"
{
	"savq/paq-nvim";

	--Neotree plugins
	"nvim-lua/plenary.nvim",
	"MunifTanjim/nui.nvim",
	"nvim-tree/nvim-web-devicons",
	"nvim-neo-tree/neo-tree.nvim",

	--Treesitter (resaltado de sintaxis)
	{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},

	-- Color schemes
	"scottmckendry/cyberdream.nvim",
	"olimorris/onedarkpro.nvim",

	--Barra de estado e iconos
	"nvim-lualine/lualine.nvim",

	--Telescope
	"nvim-telescope/telescope.nvim",
	
	--Búsqueda y salto (Seeker)
	"2kabhishek/seeker.nvim",
	"folke/snacks.nvim",
	
	--Auto completado
	"windwp/nvim-autopairs",

	--comentarios
	"numToStr/Comment.nvim",

	--LSP y dependencias
	"neovim/nvim-lspconfig",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",

	--Autocompletado
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",

	--Markdown visualizer
	"MeanderingProgrammer/render-markdown.nvim",

	--Header 42 (opcional para proyectos que no son de 42)
	"Diogo-ss/42-header.nvim",

	--Neogen, comentarios de documentacion de funciones
	"danymat/neogen",

	--which-key ayuda de atajos de teclado
	"folke/which-key.nvim",

	--Plugins para el uso de git :)
	"lewis6991/gitsigns.nvim",

	--Smooth
	"sphamba/smear-cursor.nvim",
	"y3owk1n/undo-glow.nvim",

	--terminal flotante
	"TheLazyCat00/runner-nvim",
	
	-- Dependencia para la UI de Minty
	"nvzone/volt",

	-- Color picker
	"nvzone/minty",

	-- Biscuits (ayuda visual para cierre de bloques)
	"code-biscuits/nvim-biscuits",
}

--lista de las configuraciones de cada plugin istalado
require("plugins.indconfg.colors")
require("plugins.indconfg.autopairs")
require("plugins.indconfg.lualine")
require("plugins.indconfg.lsp")
require("plugins.indconfg.neotree")
require("plugins.indconfg.render-markdown")
require("plugins.indconfg.42Header")
require("plugins.indconfg.NeogenConf")
require("plugins.indconfg.gitsigns")
require("plugins.indconfg.whichKey")
require("plugins.indconfg.undoglow")
require("plugins.indconfg.runner")
require("plugins.indconfg.seeker")
require("plugins.indconfg.biscuits")
require("smear_cursor").setup()
