return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "auto",
				icons_enabled = true,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				always_divide_middle = true,
				globalstatus = true,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
					{
						function()
							local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
							return cwd .. "/"
						end,
						padding = { left = 1, right = 0 },

						color = "Directory",

						separator = "",
					},
					{
						"filename",
						path = 1,
						padding = { left = 0, right = 1 },
						symbols = {
							modified = "",
							readonly = " ",
						},
					},
				},

				lualine_x = {
					"searchcount",
					"encoding",
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
	end,
}
