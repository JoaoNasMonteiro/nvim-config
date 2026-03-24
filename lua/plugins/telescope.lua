return {
	"nvim-telescope/telescope.nvim",
	branch = "master",

	dependencies = { "nvim-lua/plenary.nvim" },

	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")

		telescope.setup({
			defaults = {
				file_ignore_patterns = { ".git/", "node_modules/", "build/" },
			},
		})

		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files in cwd" })

		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep in cwd" })

		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find in Buffer" })

		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help" })

		vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Grep word under cursor" })
	end,
}
