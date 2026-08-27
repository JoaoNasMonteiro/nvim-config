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

-- Desabilita o wrap por padrão para todos os arquivos
vim.opt.wrap = false

local wrap_group = vim.api.nvim_create_augroup("WordWrapConfig", { clear = true })

-- Habilita para md e txt
vim.api.nvim_create_autocmd("FileType", {
	group = wrap_group,
	pattern = { "markdown", "text" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
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
		vim.hl.on_yank({
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

-- autosave .ipynb fix (Blindado e Unificado)
-- local jupytext_group = vim.api.nvim_create_augroup("Jupytext", { clear = true })
--
-- -- Intercepta a ABERTURA do arquivo .ipynb
-- vim.api.nvim_create_autocmd("BufReadCmd", {
-- 	pattern = "*.ipynb",
-- 	group = jupytext_group,
-- 	desc = "Lê o JSON do ipynb e converte para texto Python em memória",
-- 	callback = function(opts)
-- 		local filepath = vim.fn.expand("<afile>")
-- 		local cmd = string.format("jupytext --to py:percent --output - '%s'", filepath)
-- 		local output = vim.fn.systemlist(cmd)
--
-- 		if vim.v.shell_error ~= 0 then
-- 			vim.notify("Erro ao ler ipynb via Jupytext", vim.log.levels.ERROR)
-- 			return
-- 		end
--
-- 		vim.api.nvim_buf_set_lines(opts.buf, 0, -1, false, output)
-- 		vim.bo[opts.buf].filetype = "python"
-- 		vim.bo[opts.buf].modified = false
-- 	end,
-- })
--
-- -- Intercepta o SALVAMENTO do arquivo .ipynb
-- vim.api.nvim_create_autocmd("BufWriteCmd", {
-- 	pattern = "*.ipynb",
-- 	group = jupytext_group,
-- 	desc = "Lê o texto Python da tela e atualiza o JSON do ipynb no disco",
-- 	callback = function(opts)
-- 		-- Pega o caminho real do arquivo do buffer atual de forma segura
-- 		local filepath = vim.api.nvim_buf_get_name(opts.buf)
-- 		local lines = vim.api.nvim_buf_get_lines(opts.buf, 0, -1, false)
--
-- 		-- Passa o caminho do arquivo .ipynb explicitamente no output
-- 		local cmd = string.format("jupytext --from py:percent --to ipynb --output '%s' -", filepath)
-- 		local result = vim.fn.system(cmd, lines)
--
-- 		if vim.v.shell_error == 0 then
-- 			vim.bo[opts.buf].modified = false
-- 			vim.notify("Notebook sincronizado com sucesso!", vim.log.levels.INFO, { title = "Automator" })
-- 		else
-- 			vim.notify("Erro ao salvar: " .. tostring(result), vim.log.levels.ERROR, { title = "Automator" })
-- 		end
-- 	end,
-- })
