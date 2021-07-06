local options = {
	modifier = ":t",
	index_format = "%d: ",
	buffer_id_index = false,
	padding = 2,
	icons = false,
	icon_colors = "current",
	start_hidden = false,
	auto_hide = false,
	disable_commands = false,
	go_to_maps = true,
	kill_maps = false,
	show_no_name_buffers = false,
	next_indicator = ">",
	custom_command = nil,
	custom_map_prefix = nil,
	hlgroup_current = "BufTabLineCurrent",
	hlgroup_normal = "BufTabLineActive",
}

require("buftabline").setup(options)

