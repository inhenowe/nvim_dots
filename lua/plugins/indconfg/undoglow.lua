local status_ok, undo_glow = pcall(require, "undo-glow")
if not status_ok then
  return
end

-- Equivalente a la sección "opts" del ejemplo lazy.nvim
undo_glow.setup({
  animation = {
    enabled = true,
    duration = 300,
    animation_type = "zoom",
    window_scoped = true,
  },
  highlights = {
    undo    = { hl_color = { bg = "#693232" } },
    redo    = { hl_color = { bg = "#2F4640" } },
    yank    = { hl_color = { bg = "#7A683A" } },
    paste   = { hl_color = { bg = "#325B5B" } },
    search  = { hl_color = { bg = "#5C475C" } },
    comment = { hl_color = { bg = "#7A5A3D" } },
    cursor  = { hl_color = { bg = "#793D54" } },
  },
  priority = 2048 * 3,
})

-- Equivalente a la sección "keys"
local map = vim.keymap.set

map("n", "u", function() require("undo-glow").undo() end, { desc = "Undo with highlight" })
map("n", "U", function() require("undo-glow").redo() end, { desc = "Redo with highlight" })
map("n", "p", function() require("undo-glow").paste_below() end, { desc = "Paste below with highlight" })
map("n", "P", function() require("undo-glow").paste_above() end, { desc = "Paste above with highlight" })

map("n", "n", function()
  require("undo-glow").search_next({ animation = { animation_type = "strobe" } })
end, { desc = "Search next with highlight" })

map("n", "N", function()
  require("undo-glow").search_prev({ animation = { animation_type = "strobe" } })
end, { desc = "Search prev with highlight" })

map("n", "*", function()
  require("undo-glow").search_star({ animation = { animation_type = "strobe" } })
end, { desc = "Search star with highlight" })

map("n", "#", function()
  require("undo-glow").search_hash({ animation = { animation_type = "strobe" } })
end, { desc = "Search hash with highlight" })

-- Equivalente a la sección "init"
local augroup = vim.api.nvim_create_augroup("UndoGlow", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  desc = "Highlight when yanking (copying) text",
  callback = function()
    require("undo-glow").yank()
  end,
})

vim.api.nvim_create_autocmd("CursorMoved", {
  group = augroup,
  desc = "Highlight when cursor moved significantly",
  callback = function()
    require("undo-glow").cursor_moved({ animation = { animation_type = "slide" } })
  end,
})

vim.api.nvim_create_autocmd("FocusGained", {
  group = augroup,
  desc = "Highlight when focus gained",
  callback = function()
    local opts = { animation = { animation_type = "slide" } }
    opts = require("undo-glow.utils").merge_command_opts("UgCursor", opts)
    local pos = require("undo-glow.utils").get_current_cursor_row()
    require("undo-glow").highlight_region(vim.tbl_extend("force", opts, {
      s_row = pos.s_row,
      s_col = pos.s_col,
      e_row = pos.e_row,
      e_col = pos.e_col,
      force_edge = opts.force_edge == nil and true or opts.force_edge,
    }))
  end,
})

vim.api.nvim_create_autocmd("CmdlineLeave", {
  group = augroup,
  desc = "Highlight when search cmdline leave",
  callback = function()
    require("undo-glow").search_cmd({ animation = { animation_type = "fade" } })
  end,
})
