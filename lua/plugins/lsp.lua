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
				"stylua",
			},
		})

		vim.lsp.enable("clangd")
		vim.lsp.enable("pyright")
		vim.lsp.enable("stylua")

		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "Ações do LSP",
			callback = function(event)
				local opts = { buffer = event.buf }
				vim.keymap.set(
					"n",
					"gd",
					vim.lsp.buf.definition,
					vim.tbl_extend("force", opts, { desc = "LSP: Go to Definition" })
				)

				vim.keymap.set(
					"n",
					"<leader>cd",
					vim.lsp.buf.hover,
					vim.tbl_extend("force", opts, { desc = "LSP: Hover Documentation" })
				)

				vim.keymap.set(
					"n",
					"<leader>rn",
					vim.lsp.buf.rename,
					vim.tbl_extend("force", opts, { desc = "LSP: Rename Symbol" })
				)

				vim.keymap.set(
					"n",
					"<leader>ca",
					vim.lsp.buf.code_action,
					vim.tbl_extend("force", opts, { desc = "LSP: Code Action" })
				)
			end,
		})
	end,
}
