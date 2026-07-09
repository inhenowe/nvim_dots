local status_ok, runner = pcall(require, "runner-nvim")
if not status_ok then
  return
end

-- Equivalente a "opts = {}" -> hay que llamar setup() manualmente con paq
runner.setup({})

-- Equivalente a la sección "keys"
local map = vim.keymap.set

map("n", "<leader>r", function()
  require("runner-nvim").runLast()
end, { desc = "Run last cmd" })

map("n", "<leader>o", function()
  require("runner-nvim").run()
end, { desc = "Run cmd" })

map("n", "<leader>t", function()
  require("runner-nvim").toggle()
end, { desc = "Toggle terminal" })
