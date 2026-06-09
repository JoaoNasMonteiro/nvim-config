local hex_group = vim.api.nvim_create_augroup("BinaryWorkflow", { clear = true })

vim.g.current_hex_cols = 16

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
		render_hex_view()
		print("Hex View: ON")
	end
end

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
	group = hex_group,
	pattern = { "*.ch8", "*.out", "*.bin", "*.rom", "*.iso", "*.dump" },
	callback = function()
		vim.bo.binary = true
		vim.bo.fileformat = "unix"
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	group = hex_group,
	pattern = { "*.ch8", "*.out", "*.bin", "*.rom", "*.iso", "*.dump" },
	callback = function()
		if vim.bo.binary then
			render_hex_view()
		end
	end,
})

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

vim.keymap.set("n", "<leader>xe", "<cmd>lua ToggleHexView()<cr>", { desc = "Toggle Hex View" })
vim.keymap.set("n", "<leader>xn", "<cmd>lua DecreaseHexColumns()<cr>", { desc = "Decrease Hex Columns (2^x)" })
vim.keymap.set("n", "<leader>xm", "<cmd>lua IncreaseHexColumns()<cr>", { desc = "Increase Hex Columns (2^x)" })
