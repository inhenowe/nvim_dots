
-- Definimos variable global
local map = vim.keymap.set

-- Definimos tecla lider
vim.g.mapleader = " "

-- Atajos convencionales
map("n", "<leader>w", "<cmd>w<cr>", {desc = "guardar"})
map("n", "<leader>x", "<cmd>wqa<cr>", {desc = "guardar y salir"})
map("n", "<leader>s", "<cmd>source %<cr>", {desc = "guardar y salir"})
map("n", "<leader>t", "<cmd>vert term<cr>", {desc = "guardar y salir"})


-- Atajos teclado telescope
map("n", "<leader><leader>", "<cmd>Telescope buffers<cr>",           {desc = "Buffers abiertos"})
map("n", "<leader>ff",       "<cmd>Telescope find_files<cr>",        {desc = "Buscar archivos"})
map("n", "<leader>fg",       "<cmd>Telescope live_grep<cr>",         {desc = "Buscar texto en proyecto"})
map("n", "<leader>fr",       "<cmd>Telescope lsp_references<cr>",    {desc = "Referencias del símbolo"})
map("n", "<leader>fd",       "<cmd>Telescope lsp_definitions<cr>",   {desc = "Ir a definición"})
map("n", "<leader>fs",       "<cmd>Telescope lsp_document_symbols<cr>", {desc = "Símbolos del archivo"})

-- Atajos teclados nerdtree
map("n", "<leader>e", "<cmd>Neotree position=float<cr>", {desc = "Abrir/Cerrar Explorador de archivos"})
map("n", "<leader>E", "<cmd>Neotree<cr>", {desc = "Abrir/Cerrar Explorador de archivos"})

-- Atajos lps diagnostic
map("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<cr>", {desc = "diagnostico"})
