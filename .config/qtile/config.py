"""
Copyright (c) 2010 Aldo Cortesi
Copyright (c) 2010, 2014 dequis
Copyright (c) 2012 Randall Ma
Copyright (c) 2012-2014 Tycho Andersen
Copyright (c) 2012 Craig Barnes
Copyright (c) 2013 horsik
Copyright (c) 2013 Tao Sauvage
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
"""

import os
import subprocess

from libqtile import hook

from settings.color_theme import init_theme
from settings.groups import init_groups
from settings.keys import init_keybindings
from settings.layouts import init_floating_layout, init_floating_types, init_layouts
from settings.mouse import init_mouse_settings
from settings.screens import init_screens

wmname = "LG3D"

follow_mouse_focus = False
cursor_warp = False
bring_front_click = False

auto_fullscreen = True
auto_minimize = False

focus_on_window_activation = "focus"  # Options: "focus", "smart"

main = None

# Colors
colors = init_theme()

# Groups
groups = init_groups()

# Keybindings
keys = init_keybindings(groups=groups)

# Layouts
layouts = init_layouts(colors=colors)
floating_types = init_floating_types()
floating_layout = init_floating_layout()

# Screens
screens = init_screens()

# Mouse
mouse = init_mouse_settings()

# Assign apps to groups
dgroups_key_binder = None
dgroups_app_rules = []


@hook.subscribe.client_new
def assign_app_group(client):
    HOME = "home"
    WEB = "web"
    MISC = "misc"
    LAB = "lab"
    FILE = "file"
    RELAX = "relax"
    NOTES = "notes"
    CONF = "conf"
    MUSIC = "music"
    MAIL = "mail"
    # Use `$ xprop` to find the value of `WM_CLASS(STRING)`.
    # wm_class is not case sensitive in this case.
    app_default_group = {
        "discord": MAIL,
        "gimp": RELAX,
        "gl": RELAX,
        "insomnia": LAB,
        "libreoffice-calc": MAIL,
        "mail": MAIL,
        "mpv": RELAX,
        "steam": RELAX,
        "steamwebhelper": RELAX,
        "telegram-desktop": MAIL,
        "telegramDesktop": MAIL,
        "thunar": FILE,
        "thunderbird": MAIL,
        "vlc": RELAX,
    }

    # Move client to default group
    wm_class = client.window.get_wm_class()[0]
    wm_class = wm_class.lower()
    if wm_class in app_default_group:
        group = app_default_group[wm_class]
        client.togroup(group)
        client.group.cmd_toscreen(toggle=False)


# Hooks
@hook.subscribe.startup_once
def start_once():
    HOME = os.path.expanduser("~")
    subprocess.call([f"{HOME}/.config/qtile/scripts/autostart.sh"])


@hook.subscribe.startup
def start_always():
    # Set the cursor to something sane in X
    subprocess.Popen(["xsetroot", "-cursor_name", "left_ptr"])


@hook.subscribe.client_new
def set_floating(window):
    if (
        window.window.get_wm_transient_for()
        or window.window.get_wm_type() in floating_types
    ):
        window.floating = True
