return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	ft = "markdown",

	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	opts = {

		templates = {
			folder = "Templates",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M",
		},

		workspaces = {
			{
				name = "personal",
				path = "~/life-organizer/",
			},
		},

		completion = {
			nvim_cmp = true,
			min_chars = 2,
		},

		new_notes_location = "notes_subdir",

		notes_subdir = "Zettlekasten",

		note_id_func = function(title)
			local id = ""
			if title ~= nil then
				id = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
			else
				id = tostring(os.time())
			end
			return id
		end,

		ui = {
			enable = false,
		},
	},

	keys = {
		{ "<leader>on", "<cmd>ObsidianNew<CR>", desc = "New Obsidian Note" },
		{ "<leader>os", "<cmd>ObsidianSearch<CR>", desc = "Search Obsidian Vault" },
		{ "<leader>ob", "<cmd>ObsidianBacklinks<CR>", desc = "Show Backlinks" },
		{ "<leader>ot", "<cmd>ObsidianTags<CR>", desc = "Search Obsidian Tags" },
		{
			"<leader>oN",
			function()
				vim.ui.input({ prompt = "New Obsidian Note Name:" }, function(title)
					if not title or title == "" then
						return
					end

					vim.cmd("ObsidianNew " .. title)

					vim.defer_fn(function()
						vim.cmd("ObsidianTemplate base_note")
						vim.cmd("normal! k")
					end, 50)
				end)
			end,
			desc = "New Obsidian Note (with Template)",
		},
		{ "<leader>oT", "<cmd>ObsidianNewFromTemplate<CR>", desc = "New Obsidian Note From Template" },
	},
}
