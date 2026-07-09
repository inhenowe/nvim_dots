local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
	return
end

gitsigns.setup({
	signs = {
		add			 = { text = "│" },
		change		 = { text = "│" },
		delete		 = { text = "_" },
		opdelete	 = { text = "‾" },
		changedelete = { text = "~" },
		untracked	 = { text = "┆" },
	},
	current_line_blame = false, 
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, desc)
			vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
		end

	 map("n", "]c", function()
		if vim.wo.diff then return "]c" end
		vim.schedule(function() gs.next_hunk() end)
		return "<Ignore>"
	 end, "Next git hunk")

	 map("n", "[c", function()
		if vim.wo.diff then return "[c" end
		vim.schedule(function() gs.prev_hunk() end)
		return "<Ignore>"
	 end, "Prev git hunk")

	 map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
	 map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
	 map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
	 map("n", "<leader>hb", gs.toggle_current_line_blame, "Toggle line blame")
  end,
})
