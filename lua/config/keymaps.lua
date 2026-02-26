local map = vim.keymap.set

map("n", "<C-h>", "<C-w>h", { desc = "Ir para a janela da esquerda" })
map("n", "<C-j>", "<C-w>j", { desc = "Ir para a janela de baixo" })
map("n", "<C-k>", "<C-w>k", { desc = "Ir para a janela de cima" })
map("n", "<C-l>", "<C-w>l", { desc = "Ir para a janela da direita" })

map("n", "<Up>", ":resize +2<CR>", { desc = "Aumentar altura da janela" })
map("n", "<Down>", ":resize -2<CR>", { desc = "Diminuir altura da janela" })
map("n", "<Left>", ":vertical resize -2<CR>", { desc = "Diminuir largura da janela" })
map("n", "<Right>", ":vertical resize +2<CR>", { desc = "Aumentar largura da janela" })

map("n", "<leader>q", ":q<CR>", { desc = "Fechar janela" })
