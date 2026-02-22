local ok_mason, mason = pcall(require, "mason")
if not ok_mason then return end
mason.setup()

local ok_mason_lsp, mason_lspconfig = pcall(require, "mason-lspconfig")
if not ok_mason_lsp then return end

local ok_cmp_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local capabilities = ok_cmp_lsp
	and cmp_nvim_lsp.default_capabilities()
	or vim.lsp.protocol.make_client_capabilities()

local on_attach = function(_, bufnr)
	local opts = { buffer = bufnr, silent = true }
	vim.keymap.set("n", "gd",         vim.lsp.buf.definition,  vim.tbl_extend("force", opts, { desc = "Ir a definición" }))
	vim.keymap.set("n", "gr",         vim.lsp.buf.references,   vim.tbl_extend("force", opts, { desc = "Referencias" }))
	vim.keymap.set("n", "K",          vim.lsp.buf.hover,        vim.tbl_extend("force", opts, { desc = "Hover" }))
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,       vim.tbl_extend("force", opts, { desc = "Renombrar" }))
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,  vim.tbl_extend("force", opts, { desc = "Code actions" }))
	vim.keymap.set("n", "[d",         function() vim.diagnostic.jump({ count = -1 }) end, vim.tbl_extend("force", opts, { desc = "Diagnóstico anterior" }))
	vim.keymap.set("n", "]d",         function() vim.diagnostic.jump({ count =  1 }) end, vim.tbl_extend("force", opts, { desc = "Diagnóstico siguiente" }))
end

local ok_lspconfig = pcall(require, "lspconfig")
if ok_lspconfig then
	mason_lspconfig.setup({
		ensure_installed = {},
		automatic_installation = true,
		handlers = {
			function(server_name)
				require("lspconfig")[server_name].setup({
					capabilities = capabilities,
					on_attach = on_attach,
				})
			end,
		},
	})
end

-- Diagnósticos: mostrar mensaje inline y popup al hacer hover
vim.diagnostic.config({
	virtual_text = { prefix = "●" },  -- mensaje al lado de la línea
	signs = true,
	underline = true,
	update_in_insert = false,
	float = { border = "rounded", source = true },  -- muestra origen del error
})

-- Autocompletado con nvim-cmp
local ok_cmp, cmp = pcall(require, "cmp")
local ok_snip, luasnip = pcall(require, "luasnip")
if not ok_cmp or not ok_snip then return end

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered({ border = "rounded" }),
    	documentation = cmp.config.window.bordered({ border = "rounded" }),
  	},
	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"]      = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-e>"] = cmp.mapping.abort(),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	}, {
		{ name = "buffer" },
	}),
})
