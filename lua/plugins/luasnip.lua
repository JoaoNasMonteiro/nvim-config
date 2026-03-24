return {
	"L3MON4D3/LuaSnip",
	build = "make install_jsregexp",
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	config = function()
		local ls = require("luasnip")

		require("luasnip.loaders.from_vscode").lazy_load()

		require("luasnip.loaders.from_lua").load({
			paths = { vim.fn.stdpath("config") .. "/snippets" },
		})
		ls.config.set_config({
			history = true,
			update_events = "TextChanged,TextChangedI",
		})
	end,
}
