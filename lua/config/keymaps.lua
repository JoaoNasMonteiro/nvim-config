local map = vim.keymap.set

map("n", "<C-h>", "<C-w>h", { desc = "Ir para a janela da esquerda" })
map("n", "<C-j>", "<C-w>j", { desc = "Ir para a janela de baixo" })
map("n", "<C-k>", "<C-w>k", { desc = "Ir para a janela de cima" })
map("n", "<C-l>", "<C-w>l", { desc = "Ir para a janela da direita" })

map("n", "<C-Up>", ":resize +2<CR>", { desc = "Aumentar altura da janela" })
map("n", "<C-Down>", ":resize -2<CR>", { desc = "Diminuir altura da janela" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Diminuir largura da janela" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Aumentar largura da janela" })

map("n", "<leader>q", ":q<CR>", { desc = "Fechar janela" })

-- Terminal mode stuffies
map("t", "<C-Q>", "<C-\\><C-n>", { desc = "Sair do modo terminal" })

-- map("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Ir para a janela da esquerda" })
-- map("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Ir para a janela de baixo" })
-- map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Ir para a janela de cima" })
-- map("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Ir para a janela da direita" })
