-- lua/plugins/vimtex.lua
return {
	"lervag/vimtex",
	lazy = false,
	init = function()
		vim.g.vimtex_view_method = "zathura"

		vim.g.vimtex_compiler_method = "latexmk"

		vim.g.vimtex_quickfix_ignore_filters = {
			"Underfull \\hbox",
			"Overfull \\hbox",
		}
	end,
}
