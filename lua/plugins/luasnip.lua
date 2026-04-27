return {
	"L3MON4D3/LuaSnip",
	build = "make install_jsregexp",
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	config = function()
		local ls = require("luasnip")

		require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip.loaders.from_vscode").load({ include = { "tex" } })

		require("luasnip.loaders.from_lua").load({
			paths = { vim.fn.stdpath("config") .. "/snippets" },
		})

		local function in_mathzone()
			local has_ts, ts = pcall(require, "vim.treesitter")
			if not has_ts then
				return false
			end

			local cursor = vim.api.nvim_win_get_cursor(0)
			local row, col = cursor[1] - 1, cursor[2]

			if vim.api.nvim_get_mode().mode == "i" and col > 0 then
				col = col - 1
			end

			local ok, parser = pcall(ts.get_parser, 0)
			if ok and parser then
				local lang_tree = parser:language_for_range({ row, col, row, col })
				if lang_tree and (lang_tree:lang() == "latex" or lang_tree:lang() == "tex") then
					return true
				end
			end

			local node = ts.get_node({ ignore_injections = false })
			while node do
				local node_type = node:type()
				if
					node_type == "inline_formula"
					or node_type == "displayed_equation"
					or node_type == "math_environment"
					or node_type == "math_block"
					or node_type == "math"
				then
					return true
				end
				node = node:parent()
			end

			return false
		end

		ls.config.set_config({
			history = true,
			update_events = "TextChanged,TextChangedI",
			enable_autosnippets = true,
			ft_func = function()
				local current_ft = vim.bo.filetype
				if current_ft == "markdown" and in_mathzone() then
					return { "tex", "latex", "markdown" }
				end
				return { current_ft }
			end,
		})
	end,
}
