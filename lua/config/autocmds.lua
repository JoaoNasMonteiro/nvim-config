-- Create a general augroup to prevent duplicate autocmds on reload
local general_group = vim.api.nvim_create_augroup("GeneralAutocmds", { clear = true })

-- custom indentation for specific languages
local indent_group = vim.api.nvim_create_augroup("CustomIndent", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = indent_group,
	pattern = { "c", "cpp", "python", "rust" },
	callback = function()
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
		vim.opt_local.expandtab = true
	end,
})

-- Habilita spellcheck multilíngue estritamente para arquivos de texto e markdown
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "text", "gitcommit" },
	callback = function()
		vim.opt_local.spell = true

		vim.opt_local.spelllang = "pt_br,en_us"
	end,
})

-- remove trailing whitespaces on save
vim.api.nvim_create_autocmd("BufWritePre", {
	group = general_group,
	pattern = "*",
	callback = function()
		if not vim.bo.binary then
			local save_cursor = vim.fn.getpos(".")
			vim.cmd([[%s/\s\+$//e]])
			vim.fn.setpos(".", save_cursor)
		end
	end,
})

-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({
			higroup = "Visual",
			timeout = 200,
		})
	end,
})

-- open neotree on startup if no arguments are passed
vim.api.nvim_create_autocmd("VimEnter", {
	group = general_group,
	callback = function()
		if vim.fn.argc() == 0 then
			vim.cmd("Neotree current")
		end
	end,
})

-- autosave on insert leave or focus lost
vim.api.nvim_create_autocmd({ "InsertLeave", "FocusLost" }, {
	group = general_group,
	pattern = "*",
	callback = function()
		if not vim.bo.binary and vim.bo.modified and vim.bo.modifiable and vim.fn.expand("%") ~= "" then
			vim.cmd("silent! wall")
		end
	end,
})
