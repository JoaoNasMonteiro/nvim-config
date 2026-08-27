return {
	"hat0uma/csvview.nvim",
	cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
	config = function()
		require("csvview").setup({
			view = {
				display_mode = "border",
			},
		})
	end,
}
