return {
	"benlubas/molten-nvim",
	version = "^1.0.0",
	dependencies = { "3rd/image.nvim" },
	build = ":UpdateRemotePlugins",
	init = function()
		vim.g.molten_image_provider = "image.nvim"
		vim.g.molten_output_win_max_height = 20
	end,
	keys = {
		{ "<leader>mi", ":MoltenInit<CR>", desc = "Iniciar Kernel Jupyter" },
		{ "<leader>me", ":MoltenEvaluateOperator<CR>", desc = "Avaliar Célula" },
		{ "<leader>ml", ":MoltenEvaluateLine<CR>", desc = "Avaliar Linha" },
		{ "<leader>mv", ":<C-u>MoltenEvaluateVisual<CR>m", mode = "v", desc = "Avaliar Visual" },
		{ "<leader>md", ":MoltenDelete<CR>", desc = "Deletar Output" },
	},
}
