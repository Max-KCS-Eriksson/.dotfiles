local wezterm = require("wezterm")
local config = {}

-- In newer versions of wezterm, use the config_builder which will help provide clearer
-- error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Font
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 11.0
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

-- Colors
config.colors = require("colors.gruvbox").color_scheme
config.bold_brightens_ansi_colors = true

-- Cursor
config.force_reverse_video_cursor = true
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- Tabs
config.hide_tab_bar_if_only_one_tab = true

-- Window
config.window_padding = {
  top = 1,
  bottom = 0,
  left = 1,
  right = 0,
}

-- Scroll
config.scrollback_lines = 3000

-- Keys
config.keys = {
  -- Scrollback
  { key = "UpArrow",   mods = "SHIFT",      action = wezterm.action.ScrollByLine(-1) },
  { key = "DownArrow", mods = "SHIFT",      action = wezterm.action.ScrollByLine(1) },
  { key = "UpArrow",   mods = "SHIFT|CTRL", action = wezterm.action.ScrollByLine(-1) },
  { key = "DownArrow", mods = "SHIFT|CTRL", action = wezterm.action.ScrollByLine(1) },
  { key = "PageUp",    mods = "SHIFT",      action = wezterm.action.ScrollByPage(-0.5) },
  { key = "PageDown",  mods = "SHIFT",      action = wezterm.action.ScrollByPage(0.5) },
  { key = "PageUp",    mods = "SHIFT|CTRL", action = wezterm.action.ScrollByPage(-0.5) },
  { key = "PageDown",  mods = "SHIFT|CTRL", action = wezterm.action.ScrollByPage(0.5) },
}

return config
