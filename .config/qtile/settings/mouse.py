from libqtile.command import lazy
from libqtile.config import Drag

from . import keys

mod = keys.mod
mod1 = keys.mod1
mod2 = keys.mod2


def init_mouse_settings():
    return [
        Drag(
            [mod],
            "Button1",
            lazy.window.set_position_floating(),
            start=lazy.window.get_position(),
        ),
        Drag(
            [mod],
            "Button3",
            lazy.window.set_size_floating(),
            start=lazy.window.get_size(),
        ),
    ]
