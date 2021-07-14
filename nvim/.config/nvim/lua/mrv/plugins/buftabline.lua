local options = {
	tab_format = "❙  #{n}: #{b}#{f}  ",
	-- tab_format = "❙   #{i} #{b}#{f}    ",
	buffer_id_index = false,
	icon_colors = true,
	start_hidden = false,
	auto_hide = false,
	disable_commands = false,
	go_to_maps = true,
	flags = {
		modified = "[+]",
		not_modifiable = "[-]",
		readonly = "[RO]",
	},
	hlgroup_current = "BufTabLineCurrent",
	hlgroup_normal = "BufTabLineActive",
}

require("buftabline").setup(options)

