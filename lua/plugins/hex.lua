return {
	"RaafatTurki/hex.nvim",
	cmd = {
		"HexToggle",
		"HexDump",
		"HexAssemble",
	},
	keys = {
		{ "<leader>hx", "<cmd>HexToggle<cr>", desc = "Toggle Hex Editor" },
	},
	config = function()
		require("hex").setup({
			-- dump_cmd = 'xxd -g 1 -u',
			-- assemble_cmd = 'xxd -r',
		})
	end,
}
