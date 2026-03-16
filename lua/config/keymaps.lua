local map = vim.keymap.set

map("n", "<C-h>", "<C-w>h", { desc = "Move cursor a window Left" })
map("n", "<C-j>", "<C-w>j", { desc = "Move cursor a window Down" })
map("n", "<C-k>", "<C-w>k", { desc = "Move cursor a window Up" })
map("n", "<c-l>", "<c-w>l", { desc = "Move cursor a window RIght" })

map("n", "<c-up>", ":resize +2<cr>", { desc = "Increase window height" })
map("n", "<c-down>", ":resize -2<cr>", { desc = "Decrease window height" })
map("n", "<c-left>", ":vertical resize -2<cr>", { desc = "Increase window Lenght" })
map("n", "<c-right>", ":vertical resize +2<cr>", { desc = "Decrease window Lenght" })

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
map('n', '<leader>D', vim.diagnostic.setloclist, { desc = 'Open Error List' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Next Error' })
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev Error' })

map("v", "p", '"_dP', { desc = "Paste without overwriting clipboard" })
map({"n", "v"}, "x", '"_x', { desc = "Delete character without copying" })

-- Terminal mode stuffies
map("t", "<C-Q>", "<C-\\><C-n>", { desc = "Exit terminal mode" })


-- To search for tasks
map('n', '<leader>tp', function()
    require('telescope.builtin').grep_string({
        prompt_title = "Todas as Tarefas Pendentes",
        search = "- \\[ \\]",
        use_regex = true,
    })
end, { desc = "Search for all pending tasks (- [ ])" })

map('n', '<leader>td', function()
    require('telescope.builtin').grep_string({
        prompt_title = "Agenda (Tarefas com Data)",
        search = "- \\[ \\].*📅",
        use_regex = true,
    })
end, { desc = "Search for pending tasks with deadline" })


