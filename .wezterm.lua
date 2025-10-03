local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

-- Colors
-- config.color_scheme = 'One Dark (Gogh)'
config.color_scheme = 'Tango (terminal.sexy)'
-- Fonts
config.font = wezterm.font({
  family = "MesloLGLDZ Nerd Font",
  weight = "Regular",
})
config.font_size = 14
config.line_height = 1.0

-- Natural Text Editing 
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

config.keys = {
-- Natural Text Editing
  { mods = "OPT", key = "LeftArrow",  action = act.SendKey({ mods = "ALT",  key = "b" }) },
  { mods = "OPT", key = "RightArrow", action = act.SendKey({ mods = "ALT",  key = "f" }) },
  { mods = "CMD", key = "LeftArrow",  action = act.SendKey({ mods = "CTRL", key = "a" }) },
  { mods = "CMD", key = "RightArrow", action = act.SendKey({ mods = "CTRL", key = "e" }) },
  { mods = "OPT", key = "Backspace",  action = act.SendKey({ mods = "ALT",  key = "Backspace" }) },
  { mods = "OPT", key = "Delete",     action = act.SendKey({ mods = "ALT",  key = "d" }) },
  { mods = "CMD", key = "Backspace",  action = act.SendKey({ mods = "CTRL", key = "u" }) },
  { mods = "CMD", key = "Delete",     action = act.SendKey({ mods = "CTRL", key = "k" }) },
}

return config
