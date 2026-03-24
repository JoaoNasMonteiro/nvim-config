return {
	"srcery-colors/srcery-vim",
	lazy = false,
	priority = 1000,

	config = function()
		vim.g.srcery_italic = 1

		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "srcery",
			callback = function()
				local srcery_bright_red = "#F75341"
				local srcery_red = "#EF2F27"
				local srcery_bright_orange = "#FF8700"
				local srcery_orange = "#FF5F00"
				local srcery_yellow = "#FBB829"
				local srcery_bright_yellow = "#FED06E"
				local srcery_bright_black = "#2D2C29"

				vim.api.nvim_set_hl(0, "@markup.heading.1.markdown", { fg = srcery_red, bold = true })
				vim.api.nvim_set_hl(0, "@markup.heading.2.markdown", { fg = srcery_orange, bold = true })
				vim.api.nvim_set_hl(0, "@markup.heading.3.markdown", { fg = srcery_yellow, bold = true })
				vim.api.nvim_set_hl(0, "@markup.heading.4.markdown", { fg = srcery_bright_yellow, bold = true })

				vim.api.nvim_set_hl(0, "markdownH1", { fg = srcery_red, bold = true })
				vim.api.nvim_set_hl(0, "markdownH2", { fg = srcery_orange, bold = true })
				vim.api.nvim_set_hl(0, "markdownH3", { fg = srcery_yellow, bold = true })
				vim.api.nvim_set_hl(0, "markdownH4", { fg = srcery_bright_yellow, bold = true })

				vim.api.nvim_set_hl(0, "RenderMarkdownH1Bg", { fg = srcery_red })
				vim.api.nvim_set_hl(0, "RenderMarkdownH2Bg", { fg = srcery_orange })
				vim.api.nvim_set_hl(0, "RenderMarkdownH3Bg", { fg = srcery_yellow })
				vim.api.nvim_set_hl(0, "RenderMarkdownH4Bg", { fg = srcery_bright_yellow })

				vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = srcery_bright_black })
				vim.api.nvim_set_hl(0, "RenderMarkdownCodeInline", { bg = srcery_bright_black })
			end,
		})

		vim.cmd.colorscheme("srcery")
	end,
}
