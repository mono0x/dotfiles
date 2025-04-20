---@type Wezterm
local wezterm = require 'wezterm'
local act = wezterm.action

---@type Config
local config = wezterm.config_builder()
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

-- Keys
config.keys = {}
-- config.debug_key_events = true

local numbers_with_shift = {
  '!', '"', '#', '$', '%', '&', "'", '(', ')',
}
if config.launch_menu ~= nil then
  for i, v in ipairs(config.launch_menu) do
    table.insert(config.keys, {
      key = numbers_with_shift[i],
      mods = 'CTRL|SHIFT',
      action = act.SpawnCommandInNewTab {
        args = v.args,
      },
    })
    table.insert(config.keys, {
      key = numbers_with_shift[i],
      mods = 'SUPER|SHIFT',
      action = act.SpawnCommandInNewTab {
        args = v.args,
      },
    })
  end
else
  table.insert(config.keys, {
    key = numbers_with_shift[1],
    mods = 'CTRL|SHIFT',
    action = act.SpawnTab 'CurrentPaneDomain',
  })
  table.insert(config.keys, {
    key = numbers_with_shift[1],
    mods = 'SUPER|SHIFT',
    action = act.SpawnTab 'CurrentPaneDomain',
  })
end

return config
