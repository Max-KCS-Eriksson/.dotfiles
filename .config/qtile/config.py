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
    d = {}
    # Use `$ xprop` to find the value of `WM_CLASS(STRING)`.
    # First field is sufficient.
    # fmt: off
    d[groups[0].name] = []
    d[groups[1].name] = []
    d[groups[2].name] = []
    d[groups[3].name] = ["Insomnia", "insomnia"]
    d[groups[4].name] = ["Thunar", "thunar"]
    d[groups[5].name] = [
        "Vlc", "vlc",
        "gl",
        "Mpv", "mpv",
        "Gimp", "gimp",
        "steamwebhelper", "steam", "Steam",
    ]
    d[groups[6].name] = []
    d[groups[7].name] = ["TelegramDesktop", "telegram-desktop", "Discord", "discord"]
    d[groups[8].name] = ["Spotify", "spotify"]
    d[groups[9].name] = ["libreoffice-calc", "Mail", "Thunderbird", "thunderbird"]
    # fmt: on

    wm_class = client.window.get_wm_class()[0]

    for i, _ in enumerate(d):
        if wm_class in list(d.values())[i]:
            group = list(d.keys())[i]
            client.togroup(group)
            client.group.cmd_toscreen(toggle=False)


# Hooks
@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser("~")
    subprocess.call([f"{home}/.config/qtile/scripts/autostart.sh"])


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
