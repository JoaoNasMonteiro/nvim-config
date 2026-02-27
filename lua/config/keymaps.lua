local map = vim.keymap.set

map("n", "<C-h>", "<C-w>h", { desc = "Ir para a janela da esquerda" })
map("n", "<C-j>", "<C-w>j", { desc = "Ir para a janela de baixo" })
map("n", "<C-k>", "<C-w>k", { desc = "Ir para a janela de cima" })
map("n", "<C-l>", "<C-w>l", { desc = "Ir para a janela da direita" })

map("n", "<C-Up>", ":resize +2<CR>", { desc = "Aumentar altura da janela" })
map("n", "<C-Down>", ":resize -2<CR>", { desc = "Diminuir altura da janela" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Diminuir largura da janela" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Aumentar largura da janela" })

--error handling stuff
map('n', '<leader>d', function()
  local win_id = vim.api.nvim_get_current_win()
  local config = vim.api.nvim_win_get_config(win_id)
  if config.relative ~= "" then
    vim.api.nvim_win_close(win_id, false)
  else
    vim.diagnostic.open_float()
  end
end, { desc = 'Toggle/Focus Diagnostic Float' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open Error List' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Next Error' })
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev Error' })

map("v", "p", '"_dP', { desc = "Paste without overwriting clipboard" })
map({"n", "v"}, "x", '"_x', { desc = "Delete character without copying" })

-- Terminal mode stuffies
map("t", "<C-Q>", "<C-\\><C-n>", { desc = "Sair do modo terminal" })

