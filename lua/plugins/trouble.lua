return {
	"folke/trouble.nvim",
	cmd = "Trouble",

	opts = {},

	keys = {
		{
			"<leader>Ee",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Painel de Diagnósticos do Projeto (Trouble)",
		},
		{
			"<leader>Ed",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Diagnósticos Apenas do Buffer Atual",
		},
		{
			"<leader>Eq",
			"<cmd>Trouble qflist toggle<cr>",
			desc = "Quickfix List (Trouble)",
		},
	},
}
