local status_ok, seeker = pcall(require, "seeker")
if not status_ok then
  return
end

seeker.setup({
    -- Aquí puedes añadir las opciones personalizadas que necesites.
    -- Por defecto, seeker funciona bien sin argumentos adicionales.
})
vim.keymap.set('n', '<leader>/', '<cmd>Seeker grep<CR>', { desc = "Seeker: Buscar texto (Grep)" })
