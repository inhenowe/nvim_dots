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
	"nvim-tree/nvim-web-devicons",

	--Telescope
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",

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
}
