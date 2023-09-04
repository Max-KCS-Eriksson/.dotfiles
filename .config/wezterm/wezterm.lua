local wezterm = require("wezterm")
local act = wezterm.action

local colors = require("settings.theme").colors

wezterm.on("format-tab-title", require("settings.tab_bar").format_tab_title)
wezterm.on("update-right-status", require("settings.tab_bar").update_right_status)

local config = {}

-- In newer versions of wezterm, use the config_builder which will help provide clearer
-- error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Font
config.font_size = 11.0
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.font = wezterm.font_with_fallback({ "JetBrainsMono NF" })

-- Colors
config.colors = colors.color_scheme
config.bold_brightens_ansi_colors = true

-- Cursor
config.force_reverse_video_cursor = true
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- Tabs
config.hide_tab_bar_if_only_one_tab = false
config.show_new_tab_button_in_tab_bar = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.tab_max_width = 32

-- Window
config.window_frame = {
  font = config.font,
  font_size = config.font_size,
  active_titlebar_bg = colors.color_scheme.tab_bar.background,
  inactive_titlebar_bg = colors.color_scheme.tab_bar.background,
}
config.window_padding = {
  top = 1,
  bottom = 0,
  left = 1,
  right = 0,
}

-- Scroll
config.scrollback_lines = 3000

-- Keys
config.keys = require("settings.keymaps")

return config
