return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		require("mason").setup()

		require("mason-lspconfig").setup({
			ensure_installed = {
				"clangd",
				"pyright",
			},
		})

		vim.lsp.enable("clangd")
		vim.lsp.enable("pyright")

		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "Ações do LSP",
			callback = function(event)
				local opts = { buffer = event.buf }

				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
			end,
		})
	end,
}
