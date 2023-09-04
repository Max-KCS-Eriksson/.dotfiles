local wezterm = require("wezterm")
local act = wezterm.action

local theme = "gruvbox"
local colors = require("colors." .. theme)

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
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local icons = wezterm.nerdfonts

  local title = tab.tab_title
  if not title or title == "" then
    title = tab.active_pane.title
  end

  local icon
  local pwdBasefolder = tab.active_pane.current_working_dir:gsub(".*/(.*)/$", "%1"):gsub("%%20", " ")
  local pwd = tab.active_pane.current_working_dir:gsub("^file://[^/]+", ""):gsub("%%20", " ")
  local pwdRelativeHome = pwd:gsub("^/home/[^/]+", "~")

  local function trimTail(string, chars)
    return string:gsub(chars .. "$", "")
  end

  if pwdBasefolder == os.getenv("USER") then
    pwdBasefolder = "~/"
  end
  if title == "zsh" or title == "wezterm" then
    title = pwdBasefolder
    icon = icons.cod_folder_opened

    if pwdRelativeHome:find("^~/.config") then
      icon = icons.cod_gear
    end
    if pwdRelativeHome:find("^~/.config/[^/]+") then
      title = "." .. trimTail(pwdRelativeHome:gsub("^~/.config/", ""), "/")
    end

    if pwdRelativeHome:find("^~/.local/bin") then
      title = trimTail(pwdRelativeHome, "/")
    end
  elseif title:find("^docs") then
    icon = icons.cod_book
  elseif title:find("^n?vim") then
    title = pwdBasefolder
    icon = icons.custom_vim

    if pwdRelativeHome:find("^~/.config/[^/]+") then
      title = "." .. trimTail(pwdRelativeHome:gsub("^~/.config/", ""), "/")
    end

    if pwdRelativeHome:find("^~/.local/bin") then
      title = trimTail(pwdRelativeHome, "/")
    end
  elseif title:find("^python") then
    title = "python"
    icon = icons.seti_python
  elseif title == "java" then
    icon = icons.fae_java
  elseif title == "lua" then
    icon = icons.seti_lua
  elseif title == "node" then
    icon = icons.md_nodejs
  else
    icon = icons.cod_server_process
  end

  return {
    { Text = " " },
    { Text = icon .. " " },
    { Text = title },
    { Foreground = { Color = colors.palette.dim[1] } },
    { Text = " |" },
  }
end)

-- Status bar
wezterm.on("update-right-status", function(window, pane)
  window:set_right_status(wezterm.format({
    { Foreground = { Color = colors.palette.dim[2] } },
    { Text = "| " .. window:active_workspace() .. " " },
  }))
end)

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
config.keys = {
  -- Scrollback
  { key = "UpArrow",   mods = "SHIFT",      action = act.ScrollByLine(-1) },
  { key = "DownArrow", mods = "SHIFT",      action = act.ScrollByLine(1) },
  { key = "UpArrow",   mods = "SHIFT|CTRL", action = act.ScrollByLine(-1) },
  { key = "DownArrow", mods = "SHIFT|CTRL", action = act.ScrollByLine(1) },
  { key = "PageUp",    mods = "SHIFT",      action = act.ScrollByPage(-0.5) },
  { key = "PageDown",  mods = "SHIFT",      action = act.ScrollByPage(0.5) },
  { key = "PageUp",    mods = "SHIFT|CTRL", action = act.ScrollByPage(-0.5) },
  { key = "PageDown",  mods = "SHIFT|CTRL", action = act.ScrollByPage(0.5) },
  { key = "End",       mods = "SHIFT",      action = act.ScrollToBottom },
  { key = "Home",      mods = "SHIFT",      action = act.ScrollToTop },
  { key = "End",       mods = "SHIFT|CTRL", action = act.ScrollToBottom },
  { key = "Home",      mods = "SHIFT|CTRL", action = act.ScrollToTop },
}

return config
