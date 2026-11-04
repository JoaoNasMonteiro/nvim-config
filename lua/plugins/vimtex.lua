-- lua/plugins/vimtex.lua
return {
	"lervag/vimtex",
	lazy = false,
	init = function()
		vim.g.vimtex_syntax_conceal_disable = 1
		vim.g.vimtex_version_check = 0
		vim.g.vimtex_view_method = "zathura_simple"

		-- O método de compilação deve ser o gerenciador de build (latexmk)
		vim.g.vimtex_compiler_method = "latexmk"
		vim.g.vimtex_compiler_latexmk_engines = {
			_ = "-lualatex",
		}

		-- Define o motor padrão do latexmk como -lualatex
		vim.g.vimtex_compiler_latexmk_engines = {
			_ = "-lualatex",
		}

		vim.g.vimtex_quickfix_ignore_filters = {
			"Underfull \\hbox",
			"Overfull \\hbox",
		}
	end,
}
