return {
{
	"williamboman/mason.nvim",
	lazy = false,
	build = ":MasonUpdate",

	keys = {
		{
			"<leader>cm",
			"<cmd>Mason<cr>",
			desc = "Abrir interface do Mason",
		},
	},

	opts = {
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	},
}
}
