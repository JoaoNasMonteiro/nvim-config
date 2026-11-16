return {
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		event = "VeryLazy",

		dependencies = {
			"williamboman/mason.nvim",
		},

		opts = {
			ensure_installed = {
				"stylua",
				"black",
				"isort",
				"clang-format",
			},

			run_on_start = true,
			start_delay = 3000,
			auto_update = false,
		},
	},
}
