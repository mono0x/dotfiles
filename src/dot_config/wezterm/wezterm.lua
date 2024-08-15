---@type Wezterm
local wezterm = require 'wezterm'
local act = wezterm.action

local is_windows = wezterm.target_triple:find('windows')
local is_darwin = wezterm.target_triple:find('darwin')

-- config.keys doesn't work with wezterm.config_builder()...
-- local config = wezterm.config_builder()
---@type Config
local config = {}

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
if is_darwin then
  config.font_size = 14.0
else
  config.font_size = 12.0
end

-- Programs
if is_windows then
  config.default_prog = { 'pwsh' }
  config.launch_menu = {
    {
      label = 'pwsh',
      args = { 'pwsh' },
    },
    {
      label = 'Ubuntu-20.04',
      args = { 'wsl.exe', '~', '--distribution', 'Ubuntu-20.04' },
    },
    {
      label = 'Ubuntu-22.04',
      args = { 'wsl.exe', '~', '--distribution', 'Ubuntu-22.04' },
    },
  }
end

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
