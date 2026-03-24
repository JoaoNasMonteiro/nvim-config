return {
	"folke/trouble.nvim",
	cmd = "Trouble",

	opts = {},

	keys = {
		{
			"<leader>D",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Painel de Diagnósticos do Projeto (Trouble)",
		},
		{
			"<leader>dd",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Diagnósticos Apenas do Buffer Atual",
		},
		{
			"<leader>dq",
			"<cmd>Trouble qflist toggle<cr>",
			desc = "Quickfix List (Trouble)",
		},
	},
}
