local wezterm = require("wezterm")

local colors = require("settings.theme").colors

local M = {}

M.format_tab_title = function(tab, tabs, panes, config, hover, max_width)
  local icons = wezterm.nerdfonts

  local title = tab.tab_title
  if not title or title == "" then
    title = tab.active_pane.title
  end

  local icon
  local pwdBasefolder = tostring(tab.active_pane.current_working_dir):gsub(".*/(.*)/$", "%1"):gsub("%%20", " ") or ""
  local pwd = tostring(tab.active_pane.current_working_dir):gsub("^file://[^/]+", ""):gsub("%%20", " ") or ""
  local pwdRelativeHome = pwd:gsub("^/home/[^/]+", "~") or ""

  local function trimTail(string, chars)
    return string:gsub(chars .. "$", "")
  end

  local function formatPwdRelativeHome(pwdRelativeHome)
    if pwdRelativeHome:find("^~/.config/[^/]+") then
      return "." .. trimTail(pwdRelativeHome:gsub("^~/.config/", ""), "/")
    end

    if pwdRelativeHome:find("^~/.local/bin") then
      return trimTail(pwdRelativeHome, "/")
    end
  end

  if pwdBasefolder == os.getenv("USER") then
    pwdBasefolder = "~/"
  end
  if title:find("^zsh") or title:find("^wezterm") or title:find("^ls") or title:find("^clear") then
    if pwdRelativeHome:find("^~/.config/[^/]+") or pwdRelativeHome:find("^~/.local/bin") then
      title = formatPwdRelativeHome(pwdRelativeHome)
    else
      title = pwdBasefolder
    end
    if pwdRelativeHome:find("^~/.config") then
      icon = icons.cod_gear
    else
      icon = icons.cod_folder_opened
    end
  elseif title:find("^docs") then
    icon = icons.cod_book
  elseif title:find("^n?vim") then
    icon = icons.custom_vim
    if pwdRelativeHome:find("^~/.config/[^/]+") or pwdRelativeHome:find("^~/.local/bin") then
      title = formatPwdRelativeHome(pwdRelativeHome)
    else
      title = pwdBasefolder
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
end

M.update_right_status = function(window, pane)
  window:set_right_status(wezterm.format({
    { Foreground = { Color = colors.palette.dim[2] } },
    { Text = "| " .. window:active_workspace() .. " " },
  }))
end

return M
