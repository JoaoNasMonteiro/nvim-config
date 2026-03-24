return {
	{
		"ledger/vim-ledger",
		ft = "ledger",
		config = function()
			vim.filetype.add({
				extension = {
					journal = "ledger",
				},
			})

			vim.g.ledger_maxwidth = 80

			vim.g.ledger_align_at = 60

			vim.g.ledger_default_acct_file = vim.fn.expand("~/Caminho/Para/O/Seu/Vault/Finances/accounts.journal")
		end,
	},
}
