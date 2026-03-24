return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	lazy = false,

	config = function()
		local ts = require("nvim-treesitter")

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
			"latex",
			"ledger",
			"bash",
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "*",
			callback = function(args)
				local ok = pcall(vim.treesitter.start, args.buf)

				if ok then
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
