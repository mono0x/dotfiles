local wezterm = require 'wezterm'

local config = {
  -- color_scheme = "Solar Flare Light (base16)",
  color_scheme = "Solarized (light) (terminal.sexy)",
  font = wezterm.font('HackGen Console NF'),
  initial_cols = 100,
  initial_rows = 40,
  default_prog = default_prog,
  launch_menu = launch_menu,
}

if wezterm.target_triple:find('windows') then
  local pwsh = 'C:\\Program Files\\Powershell\\7\\pwsh.exe' 
  config.default_prog = { pwsh }
  config.launch_menu = {
    {
      label = 'pwsh',
      args = { pwsh },
    },
    {
      label = 'Ubuntu-20.04',
      args = { 'wsl.exe', '~', '--distribution', 'Ubuntu-20.04' },
    },
  }
elseif wezterm.target_triple:find('darwin') then
  config.font_size = 14.0
end

return config