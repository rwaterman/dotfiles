local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

-- =========================================================
--  Appearance
-- =========================================================
config.color_scheme = 'Tango (terminal.sexy)'

-- Font fallback chain (auto-selects first available)
config.font = wezterm.font_with_fallback({
  'MesloLGLDZ Nerd Font',     -- preferred
  'SF Mono',                  -- fallback: MacOS system font
  'Ubuntu Mono',              -- fallback: Ubuntu system font
  'DejaVu Sans Mono',         -- fallback: common Linux fallback
})

config.font_size = 14
config.line_height = 1.0

-- Add Background Transparency
-- config.front_end = "WebGpu"
config.window_background_opacity = 0.90
config.macos_window_background_blur = 5
-- config.text_background_opacity = 0.9

-- =========================================================
--  Keyboard Behavior / Natural Text Editing
-- =========================================================
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

config.keys = {
  -- Natural Text Editing
  { mods = 'OPT', key = 'LeftArrow',  action = act.SendKey({ mods = 'ALT',  key = 'b' }) },
  { mods = 'OPT', key = 'RightArrow', action = act.SendKey({ mods = 'ALT',  key = 'f' }) },
  { mods = 'CMD', key = 'LeftArrow',  action = act.SendKey({ mods = 'CTRL', key = 'a' }) },
  { mods = 'CMD', key = 'RightArrow', action = act.SendKey({ mods = 'CTRL', key = 'e' }) },
  { mods = 'OPT', key = 'Backspace',  action = act.SendKey({ mods = 'ALT',  key = 'Backspace' }) },
  { mods = 'OPT', key = 'Delete',     action = act.SendKey({ mods = 'ALT',  key = 'd' }) },
  { mods = 'CMD', key = 'Backspace',  action = act.SendKey({ mods = 'CTRL', key = 'u' }) },
  { mods = 'CMD', key = 'Delete',     action = act.SendKey({ mods = 'CTRL', key = 'k' }) },
}

config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = wezterm.action.CompleteSelectionOrOpenLinkAtMouseCursor 'Clipboard',
  },
}

-- =========================================================
--  URL Handling
-- =========================================================
config.hyperlink_rules = wezterm.default_hyperlink_rules()

return config
