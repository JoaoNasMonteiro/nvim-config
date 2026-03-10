return {
    "epwalsh/obsidian.nvim",
    version = "*",  -- recommended, use latest release instead of latest commit
    lazy = true,
    -- Only load it for markdown files to keep your startup time fast
    ft = "markdown",
    
    dependencies = {
        "nvim-lua/plenary.nvim",
        -- It will automatically detect and use your existing Telescope setup
    },

    opts = {
        workspaces = {
            {
                name = "personal",
                path = "~/life-organizer/", -- CHANGE THIS to your actual vault path
            },
        },

        -- Integrates with your existing nvim-cmp setup
        completion = {
            nvim_cmp = true,
            min_chars = 2, -- Start suggesting links after typing '[[ab'
        },

        -- Where to put new notes. Options: "current_dir" or "notes_subdir"
        new_notes_location = "notes_subdir",
        
        notes_subdir = "Zettlekasten",

        -- Customize how note IDs are generated when you make a new note
        -- This disables the default Zettelkasten ID prefix (e.g. 16535234-my-note) 
        -- and just uses the title you provide.
        note_id_func = function(title)
            local id = ""
            if title ~= nil then
                id = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
            else
                id = tostring(os.time())
            end
            return id
        end,

        -- UI configuration (integrates perfectly with render-markdown)
        ui = {
            enable = false, -- Set to false because your render-markdown.nvim handles the UI now!
        },
    },

    keys = {
        { "<leader>on", "<cmd>ObsidianNew<CR>", desc = "New Obsidian Note" },
        { "<leader>os", "<cmd>ObsidianSearch<CR>", desc = "Search Obsidian Vault" },
        { "<leader>ob", "<cmd>ObsidianBacklinks<CR>", desc = "Show Backlinks" },
        { "<leader>ot", "<cmd>ObsidianTags<CR>", desc = "Search Obsidian Tags" },
    },
}
