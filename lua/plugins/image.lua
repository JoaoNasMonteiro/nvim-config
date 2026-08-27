-- lua/plugins/image.lua
return {
	"3rd/image.nvim",
	build = false,
	opts = {
		processor = "magick_cli",
		backend = "kitty",
		max_width = 100,
		max_height = 12,
		max_width_window_percentage = math.huge,
		max_height_window_percentage = math.huge,
		window_overlap_clear_enabled = true,
		window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
		editor_only_render_when_focused = false,
		tmux_show_only_in_active_window = false,
		hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
	},
	config = function(_, opts)
		require("image").setup(opts)
	end,
}
