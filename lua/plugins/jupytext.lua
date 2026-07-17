return {
	"goerz/jupytext.vim",
	config = function()
		vim.g.jupytext_fmt = "py:percent"

		vim.g.jupytext_to_ipynb_opts = "--update"
	end,
}
