local hex_group = vim.api.nvim_create_augroup("BinaryWorkflow", { clear = true })

-- Configurações
vim.g.current_hex_cols = 16
local MAX_HEX_FILE_SIZE = 2097152 -- 2MB (2 * 1024 * 1024 bytes)

-- Função para testar se o arquivo é binário buscando pelo byte NUL
local function is_binary_file(filepath)
	local f = io.open(filepath, "rb")
	if not f then
		return false
	end

	local chunk = f:read(1024)
	f:close()

	if not chunk then
		return false
	end

	-- Retorna true se encontrar o byte NUL (%z em Lua)
	return chunk:find("%z") ~= nil
end

local function render_hex_view()
	local save_cursor = vim.fn.getpos(".")
	local cmd = string.format("silent %%!xxd -g 2 -u -c %d", vim.g.current_hex_cols)
	vim.cmd(cmd)

	vim.bo.filetype = "xxd"
	vim.b.is_hex_view = true
	vim.bo.modified = false
	vim.fn.setpos(".", save_cursor)
end

local function revert_hex_view()
	local save_cursor = vim.fn.getpos(".")
	local cmd = string.format("silent %%!xxd -r -c %d", vim.g.current_hex_cols)
	vim.cmd(cmd)

	vim.bo.filetype = ""
	vim.b.is_hex_view = false
	vim.bo.modified = false
	vim.fn.setpos(".", save_cursor)
end

_G.ToggleHexView = function()
	vim.bo.binary = true
	vim.bo.fileformat = "unix"

	if vim.b.is_hex_view or vim.bo.filetype == "xxd" then
		revert_hex_view()
		print("Hex View: OFF")
	else
		-- Proteção no modo manual
		local file_size = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
		if file_size > MAX_HEX_FILE_SIZE then
			vim.notify("Este arquivo excede 2MB. Executar o xxd irá travar o Neovim.", vim.log.levels.ERROR)
			return
		end

		render_hex_view()
		print("Hex View: ON")
	end
end

-- Intercepta a abertura de arquivos para testar se são binários
vim.api.nvim_create_autocmd("BufReadPre", {
	group = hex_group,
	pattern = "*",
	callback = function(args)
		if is_binary_file(args.match) then
			-- 1. Sempre protege o arquivo setando como binário
			vim.bo[args.buf].binary = true
			vim.bo[args.buf].fileformat = "unix"

			-- 2. Checa o tamanho do arquivo
			local file_size = vim.fn.getfsize(args.match)

			if file_size > 0 and file_size <= MAX_HEX_FILE_SIZE then
				-- Arquivo leve: engatilha a renderização hexadecimal
				vim.b[args.buf].auto_hex_view = true
			else
				-- Arquivo pesado: avisa o usuário e aborta o xxd automático
				vim.schedule(function()
					vim.notify(
						"Arquivo binário > 2MB detectado. Aberto em modo binário, mas hex view automático cancelado.",
						vim.log.levels.WARN
					)
				end)
			end
		end
	end,
})

-- Aplica o modo hex se a flag foi ativada no BufReadPre
vim.api.nvim_create_autocmd("BufReadPost", {
	group = hex_group,
	pattern = "*",
	callback = function(args)
		if vim.b[args.buf].auto_hex_view then
			render_hex_view()
			vim.b[args.buf].auto_hex_view = nil
		end
	end,
})

-- Reverte o hex para binário antes de salvar
vim.api.nvim_create_autocmd("BufWritePre", {
	group = hex_group,
	pattern = "*",
	callback = function()
		if vim.bo.binary and vim.b.is_hex_view then
			local save_cursor = vim.fn.getpos(".")
			local cmd = string.format("silent %%!xxd -r -c %d", vim.g.current_hex_cols)
			vim.cmd(cmd)
			vim.fn.setpos(".", save_cursor)

			vim.b.restore_hex_after_save = true
		end
	end,
})

-- Restaura o visual hex após o salvamento ser concluído no disco
vim.api.nvim_create_autocmd("BufWritePost", {
	group = hex_group,
	pattern = "*",
	callback = function()
		if vim.b.restore_hex_after_save then
			render_hex_view()
			vim.b.restore_hex_after_save = false
		end
	end,
})

_G.DecreaseHexColumns = function()
	if not vim.b.is_hex_view then
		return
	end
	if vim.g.current_hex_cols > 2 then
		revert_hex_view()
		vim.g.current_hex_cols = vim.g.current_hex_cols / 2
		render_hex_view()
		print("Hex Columns: " .. vim.g.current_hex_cols)
	else
		print("Limite mínimo atingido (2 colunas)")
	end
end

_G.IncreaseHexColumns = function()
	if not vim.b.is_hex_view then
		return
	end
	if vim.g.current_hex_cols < 64 then
		revert_hex_view()
		vim.g.current_hex_cols = vim.g.current_hex_cols * 2
		render_hex_view()
		print("Hex Columns: " .. vim.g.current_hex_cols)
	else
		print("Limite máximo atingido (64 colunas)")
	end
end

-- Atalhos
vim.keymap.set("n", "<leader>xe", "<cmd>lua ToggleHexView()<cr>", { desc = "Toggle Hex View" })
vim.keymap.set("n", "<leader>xn", "<cmd>lua DecreaseHexColumns()<cr>", { desc = "Decrease Hex Columns (2^x)" })
vim.keymap.set("n", "<leader>xm", "<cmd>lua IncreaseHexColumns()<cr>", { desc = "Increase Hex Columns (2^x)" })
