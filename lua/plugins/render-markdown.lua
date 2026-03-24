return {
	"MeanderingProgrammer/render-markdown.nvim",
	ft = { "markdown" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		vim.opt.conceallevel = 2
		vim.opt.concealcursor = ""

		require("render-markdown").setup({
			heading = {
				enabled = true,
				sign = false,
				icons = { "H ", "h2 ", "h3 ", "h4 ", "h5 ", "h6 " },
			},

			code = {
				enabled = true,
				sign = true,
				style = "full",
				position = "left",
			},

			pipe_table = {
				enabled = true,
				preset = "round",
				style = "full",
			},

			latex = {
				enabled = true,
				converter = "latex2text",
				highlight = "RenderMarkdownMath",
			},

			link = {
				enabled = true,
				hyperlink = "󰌹 ",
			},

			bullet = {
				enabled = true,
				icons = { "•", "◦", "▪", "▫" },
				left_pad = 0,
				right_pad = 1,
			},
		})

		vim.keymap.set("n", "<leader>m", "<cmd>RenderMarkdown toggle<CR>", { desc = "Toggle Markdown Render" })
	end,
}
