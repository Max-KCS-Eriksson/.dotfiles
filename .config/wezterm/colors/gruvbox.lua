local M = {}

M.palette = {
  -- Theme colors
  black = { "#282828", "#928374" },
  red = { "#CC241D", "#FB4934" },
  green = { "#689D6A", "#8EC07C" },
  yellow = { "#D79921", "#FABD2F" },
  blue = { "#458588", "#83A598" },
  purple = { "#B16286", "#D3869B" },
  cyan = { "#98971A", "#B8BB26" },
  white = { "#A89984", "#EBDBB2" },
  -- Extended colors
  dim = { "#504945", "#807670" },
  orange = { "#D65D0E", "#FE8019" },
}

M.theme = {
  primary = M.palette.orange[2],
  secondary = M.palette.blue[2],

  background = M.palette.black[1],
  foreground = M.palette.white[2],
}

M.color_scheme = {
  background = M.theme.background,
  foreground = M.theme.foreground,
  selection_fg = M.theme.background,
  selection_bg = M.theme.foreground,

  -- Overrides the cell background color when the current cell is occupied by the
  -- cursor and the cursor style is set to Block
  cursor_bg = M.theme.foreground,
  -- Overrides the text color when the current cell is occupied by the cursor
  cursor_fg = M.theme.background,
  -- Specifies the border color of the cursor when the cursor style is set to Block,
  -- or the color of the vertical or horizontal bar when the cursor style is set to
  -- Bar or Underline.
  cursor_border = M.theme.foreground,

  scrollbar_thumb = M.palette.dim[1],

  split = M.theme.primary,

  ansi = {
    M.palette.black[1], -- Black
    M.palette.red[1],  -- Maroon
    M.palette.green[1], -- Green
    M.palette.yellow[1], -- Olive
    M.palette.blue[1], -- Navy
    M.palette.purple[1], -- Purple
    M.palette.cyan[1], -- Teal
    M.palette.white[1], -- Silver
  },
  brights = {
    M.palette.black[2], -- Grey
    M.palette.red[2],  -- Red
    M.palette.green[2], -- Lime
    M.palette.yellow[2], -- Yellow
    M.palette.blue[2], -- Blue
    M.palette.purple[2], -- Fuchsia
    M.palette.cyan[2], -- Aqua
    M.palette.white[2], -- White
  },

  -- When the IME, a dead key or a leader key are being processed and are effectively
  -- holding input pending the result of input composition, change the cursor
  -- to this color to give a visual cue about the compose state.
  compose_cursor = M.palette.orange[2],

  -- TODO: Define below
  --
  -- Colors for copy_mode and quick_select
  -- In copy_mode, the color of the active text is:
  -- 1. copy_mode_active_highlight_* if additional text was selected using the mouse
  -- 2. selection_* otherwise
  copy_mode_active_highlight_bg = { Color = "#000000" },
  -- use `AnsiColor` to specify one of the ansi color palette values
  -- (index 0-15) using one of the names "Black", "Maroon", "Green",
  --  "Olive", "Navy", "Purple", "Teal", "Silver", "Grey", "Red", "Lime",
  -- "Yellow", "Blue", "Fuchsia", "Aqua" or "White".
  copy_mode_active_highlight_fg = { AnsiColor = "Black" },
  copy_mode_inactive_highlight_bg = { Color = "#52ad70" },
  copy_mode_inactive_highlight_fg = { AnsiColor = "White" },

  quick_select_label_bg = { Color = "peru" },
  quick_select_label_fg = { Color = "#ffffff" },
  quick_select_match_bg = { AnsiColor = "Navy" },
  quick_select_match_fg = { Color = "#ffffff" },
}

M.color_scheme.tab_bar = {
  inactive_tab_edge = M.palette.dim[1],
  background = M.theme.background,
  active_tab = {
    bg_color = M.palette.black[1],
    fg_color = M.palette.dim[2],
    intensity = "Bold", -- Options: "Half", "Normal" or "Bold"
    underline = "None", -- Options: "None", "Single" or "Double"
    italic = false,
    strikethrough = false,
  },
  inactive_tab = {
    bg_color = M.palette.black[1],
    fg_color = M.palette.dim[1],
    intensity = "Normal", -- Options: "Half", "Normal" or "Bold"
    underline = "None", -- Options: "None", "Single" or "Double"
    italic = false,
    strikethrough = false,
  },
  inactive_tab_hover = {
    bg_color = M.palette.dim[1],
    fg_color = M.palette.black[1],
    intensity = "Normal", -- Options: "Half", "Normal" or "Bold"
    underline = "None", -- Options: "None", "Single" or "Double"
    italic = false,
    strikethrough = false,
  },
  new_tab = {
    bg_color = M.palette.black[1],
    fg_color = M.palette.dim[2],
    intensity = "Normal", -- Options: "Half", "Normal" or "Bold"
    underline = "None", -- Options: "None", "Single" or "Double"
    italic = false,
    strikethrough = false,
  },
  new_tab_hover = {
    bg_color = M.palette.dim[2],
    fg_color = M.palette.black[1],
    intensity = "Normal", -- Options: "Half", "Normal" or "Bold"
    underline = "None", -- Options: "None", "Single" or "Double"
    italic = false,
    strikethrough = false,
  },
}

return M
