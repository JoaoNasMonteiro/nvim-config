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
-- map('n', '<leader>d', function()
--   local win_id = vim.api.nvim_get_current_win()
--   local config = vim.api.nvim_win_get_config(win_id)
--   if config.relative ~= "" then
--     vim.api.nvim_win_close(win_id, false)
--   else
--     vim.diagnostic.open_float()
--   end
-- end, { desc = 'Toggle/Focus Diagnostic Float' })
-- map('n', '<leader>D', vim.diagnostic.setloclist, { desc = 'Open Error List' })

map("n", "]e", vim.diagnostic.goto_next, { desc = "Next Error" })
map("n", "[e", vim.diagnostic.goto_prev, { desc = "Prev Error" })

map("v", "p", '"_dP', { desc = "Paste without overwriting clipboard" })
map({ "n", "v" }, "x", '"_x', { desc = "Delete character without copying" })

-- Terminal mode stuffies
map("t", "<C-Q>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- To search for tasks
map("n", "<leader>tp", function()
	require("telescope.builtin").grep_string({
		prompt_title = "Todas as Tarefas Pendentes",
		search = "- \\[ \\]",
		use_regex = true,
	})
end, { desc = "Search for all pending tasks (- [ ])" })

map("n", "<leader>td", function()
	require("telescope.builtin").grep_string({
		prompt_title = "Agenda (Tarefas com Data)",
		search = "- \\[ \\].*📅",
		use_regex = true,
	})
end, { desc = "Search for pending tasks with deadline" })

-- scratchpad buffer toggle
local function toggle_scratchpad()
	local scratch_file = vim.fn.expand("~/.scratchpad.md")

	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		local buf_name = vim.api.nvim_buf_get_name(buf)

		if buf_name == scratch_file then
			vim.api.nvim_win_close(win, false)
			return
		end
	end

	vim.cmd("botright vsplit " .. scratch_file)

	vim.cmd("vertical resize 40")

	vim.opt_local.number = false
	vim.opt_local.relativenumber = false
	vim.opt_local.signcolumn = "no"
	vim.opt_local.wrap = true
end

map("n", "<leader>n", toggle_scratchpad, { desc = "Toggle Lateral Scratchpad" })

-- Hex visualization stuff
map("n", "<leader>xx", ":%!xxd<CR>", { desc = "View File as Hex" })
map("n", "<leader>xr", ":%!xxd -r<CR>", { desc = "Revert View File As Hex" })

-- Auto Edit nvim config

local function edit_config_on_new_tab()
	vim.cmd("tabnew")
	vim.cmd("tcd " .. vim.fn.stdpath("config"))
	require("telescope.builtin").find_files()
end

map("n", "<leader>C", edit_config_on_new_tab, { desc = "Open Config" })

-- Disassembler
local function disasm_buffer(arch_type)
	if vim.fn.executable("llvm-objdump") == 0 then
		vim.notify(
			"Missing dependency: 'llvm-objdump' was not found in your $PATH.\n"
				.. "Please install the LLVM package on your system (e.g., sudo apt install llvm / brew install llvm).",
			vim.log.levels.ERROR
		)
		return
	end

	local target_file = vim.fn.expand("%:p")

	if target_file == "" or vim.fn.filereadable(target_file) == 0 then
		vim.notify("File not found or invalid for disassembly.", vim.log.levels.ERROR)
		return
	end

	local cmd = ""

	if arch_type == "intel" then
		cmd = string.format("llvm-objdump -d --x86-asm-syntax=intel %s", vim.fn.shellescape(target_file))
	elseif arch_type == "arm" or arch_type == "auto" then
		cmd = string.format("llvm-objdump -d %s", vim.fn.shellescape(target_file))
	else
		vim.notify("Arch not found or not configured.", vim.log.levels.ERROR)
		return
	end

	vim.cmd("vnew")
	local buf = vim.api.nvim_get_current_buf()

	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].swapfile = false
	vim.bo[buf].filetype = "asm"

	vim.fn.jobstart(cmd, {
		stdout_buffered = true,
		on_stdout = function(_, data)
			if data then
				vim.api.nvim_buf_set_lines(buf, 0, -1, false, data)
			end
		end,
		on_exit = function(_, code)
			if code ~= 0 then
				vim.notify("Error executing llvm-objdump. Is the file a valid binary?", vim.log.levels.ERROR)
			else
				vim.bo[buf].readonly = true
				vim.bo[buf].modifiable = false
			end
		end,
	})
end

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>di", function()
	disasm_buffer("intel")
end, vim.tbl_extend("force", opts, { desc = "Disassemble: x86_64 (Intel Syntax)" }))

vim.keymap.set("n", "<leader>da", function()
	disasm_buffer("arm")
end, vim.tbl_extend("force", opts, { desc = "Disassemble: ARM (Auto-detect)" }))
