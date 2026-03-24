return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = { "BufReadPost", "BufNewFile" },

	config = function()
		require("todo-comments").setup({})
	end,

	keys = {
		{
			"]t",
			function()
				require("todo-comments").jump_next()
			end,
			desc = "Saltar para o próximo TODO",
		},
		{
			"[t",
			function()
				require("todo-comments").jump_prev()
			end,
			desc = "Saltar para o TODO anterior",
		},

		{
			"<leader>tt",
			"<cmd>Trouble todo toggle<cr>",
			desc = "Painel de TODOs do Projeto (Trouble)",
		},

		{
			"<leader>tf",
			"<cmd>TodoTelescope<cr>",
			desc = "Pesquisar TODOs no Telescope",
		},
	},
}
