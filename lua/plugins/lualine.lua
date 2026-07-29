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
				-- Lado Esquerdo
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
					{
						-- Componente CWD
						function()
							local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
							return cwd .. "/"
						end,
						-- Removido o ícone que ficava aqui antes
						padding = { left = 1, right = 0 },

						-- Puxa a cor padrão que o seu tema usa para Diretórios.
						-- Outras opções legais do seu tema: "Statement", "Function", "String", "Keyword"
						color = "Directory",

						-- Se você preferir uma cor fixa ignorando o tema, basta comentar
						-- a linha acima e descomentar a de baixo, usando o HEX que quiser:
						-- color = { fg = '#ff9e64', gui = 'bold' },

						separator = "",
					},
					{
						"filename",
						path = 1,
						padding = { left = 0, right = 1 },
						symbols = {
							modified = "", -- Vazio para não mostrar nada quando modificado
							readonly = " ", -- Mantém o cadeado para arquivos somente leitura
						},
					},
				},

				-- Lado Direito
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
