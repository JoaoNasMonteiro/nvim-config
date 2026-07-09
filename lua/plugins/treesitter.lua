return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	lazy = false,

	config = function()
		local ts = require("nvim-treesitter")

		-- 1. Instalação manual dos parsers que você definiu
		ts.install({
			"c",
			"cpp",
			"lua",
			"markdown",
			"markdown_inline",
			"python",
			"vim",
			"vimdoc",
			"query",
			"make",
			"ledger",
			"bash",
			"asm",
		})

		-- 2. Autocmd para ativar o Tree-sitter respeitando a regra do LaTeX
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "*",
			callback = function(args)
				-- Se o arquivo for LaTeX, aborta e deixa o VimTeX trabalhar sozinho
				if vim.bo[args.buf].filetype == "tex" or vim.bo[args.buf].filetype == "latex" then
					return
				end

				-- Ativa o Tree-sitter nos outros tipos de arquivo
				local ok = pcall(vim.treesitter.start, args.buf)
				if ok then
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
