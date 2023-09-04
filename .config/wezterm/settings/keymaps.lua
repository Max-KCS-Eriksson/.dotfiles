local wezterm = require("wezterm")
local act = wezterm.action

return {
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
