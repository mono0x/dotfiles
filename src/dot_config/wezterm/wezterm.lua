---@type Wezterm
local wezterm = require 'wezterm'

local config = wezterm.config_builder()
---@diagnostic disable-next-line: undefined-field
config:set_strict_mode(true)

-- Preferences
config.check_for_updates = false
config.window_close_confirmation = "NeverPrompt"

-- Appearances
config.color_scheme = "Builtin Solarized Light"
config.initial_cols = 120
config.initial_rows = 40
config.font = wezterm.font_with_fallback {
  'HackGen Console NF',
}
config.font_size = 14.0

return config
