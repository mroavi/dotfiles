-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

local act = wezterm.action

-- This is where you actually apply your config choices

config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("MesloLGLDZ Nerd Font Mono")
config.font_size = 11
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.8
config.window_close_confirmation = "NeverPrompt"
config.front_end = "WebGpu"

-- NOTE: Fonts are different compared to other terminals (https://github.com/wez/wezterm/issues/5331)

-- Customize the copy mode selection colors
config.colors = {
  selection_fg = "#1E1E2E",  -- Color for the selected text (foreground)
  selection_bg = "#F5E0DC",  -- Color for the selection background
}

-- Add key binding for CTRL-[ to exit copy mode
local default_key_tables = wezterm.gui.default_key_tables()
table.insert(default_key_tables.copy_mode, { key = '[', mods = 'CTRL', action = act.CopyMode 'Close' })
config.key_tables = default_key_tables

-- and finally, return the configuration to wezterm
return config
