from libqtile.config import Key
from libqtile.command import lazy

# Modifiers
META = "mod4"
SHIFT = "shift"
CTRL = "control"
ALT = "mod1"

# Keys
UP = "Up"
DOWN = "Down"
LEFT = "Left"
RIGHT = "Right"
HOME = "home"
END = "end"
TAB = "Tab"
SPACE = "space"
ESC = "Escape"


@lazy.function
def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)


@lazy.function
def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)


def window_to_previous_screen(qtile, switch_group=False, switch_screen=False):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group, switch_group=switch_group)
        if switch_screen:
            qtile.cmd_to_screen(i - 1)


def window_to_next_screen(qtile, switch_group=False, switch_screen=False):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group, switch_group=switch_group)
        if switch_screen:
            qtile.cmd_to_screen(i + 1)


def init_keybindings(groups):
    """Qtile specific keybindings"""
    # fmt:off
    keys = [
        # Super + key
        Key([META, SHIFT], "f", lazy.window.toggle_fullscreen()),
        Key([META], ESC, lazy.window.kill()),

        # Super + Shift + key
        Key([META, SHIFT], "q", lazy.window.kill()),
        Key([META, SHIFT], "r", lazy.restart()),
        Key([META, SHIFT], SPACE, lazy.next_layout()),

        # Super + Ctrl + key
        Key([META, CTRL], "r", lazy.reload_config()),

        # Qtile layout keys
        Key([META, SHIFT], "n", lazy.layout.normalize()),

        # Change focus
        Key([META], UP, lazy.layout.up()),
        Key([META], DOWN, lazy.layout.down()),
        Key([META], LEFT, lazy.layout.left()),
        Key([META], RIGHT, lazy.layout.right()),
        Key([META], "k", lazy.layout.up()),
        Key([META], "j", lazy.layout.down()),
        Key([META], "h", lazy.layout.left()),
        Key([META], "l", lazy.layout.right()),

        # Resize up, down, left, right
        Key(
            [META, CTRL],
            "l",
            lazy.layout.grow_right(),
            lazy.layout.grow(),
            lazy.layout.increase_ratio(),
            lazy.layout.delete(),
        ),
        Key(
            [META, CTRL],
            RIGHT,
            lazy.layout.grow_right(),
            lazy.layout.grow(),
            lazy.layout.increase_ratio(),
            lazy.layout.delete(),
        ),
        Key(
            [META, CTRL],
            "h",
            lazy.layout.grow_left(),
            lazy.layout.shrink(),
            lazy.layout.decrease_ratio(),
            lazy.layout.add(),
        ),
        Key(
            [META, CTRL],
            LEFT,
            lazy.layout.grow_left(),
            lazy.layout.shrink(),
            lazy.layout.decrease_ratio(),
            lazy.layout.add(),
        ),
        Key(
            [META, CTRL],
            "k",
            lazy.layout.grow_up(),
            lazy.layout.grow(),
            lazy.layout.decrease_nmaster(),
        ),
        Key(
            [META, CTRL],
            UP,
            lazy.layout.grow_up(),
            lazy.layout.grow(),
            lazy.layout.decrease_nmaster(),
        ),
        Key(
            [META, CTRL],
            "j",
            lazy.layout.grow_down(),
            lazy.layout.shrink(),
            lazy.layout.increase_nmaster(),
        ),
        Key(
            [META, CTRL],
            DOWN,
            lazy.layout.grow_down(),
            lazy.layout.shrink(),
            lazy.layout.increase_nmaster(),
        ),

        # Flip layout for MonadTall/MonadWide
        Key([META, SHIFT], "t", lazy.layout.flip()),

        # Flip layout for BSP
        Key([META, ALT], "k", lazy.layout.flip_up()),
        Key([META, ALT], "j", lazy.layout.flip_down()),
        Key([META, ALT], "l", lazy.layout.flip_right()),
        Key([META, ALT], "h", lazy.layout.flip_left()),

        # Move windows up or down BSP layout
        Key([META, SHIFT], "k", lazy.layout.shuffle_up()),
        Key([META, SHIFT], "j", lazy.layout.shuffle_down()),
        Key([META, SHIFT], "h", lazy.layout.shuffle_left()),
        Key([META, SHIFT], "l", lazy.layout.shuffle_right()),

        # Move windows up or down MonadTall/MonadWide layout
        Key([META, SHIFT], UP, lazy.layout.shuffle_up()),
        Key([META, SHIFT], DOWN, lazy.layout.shuffle_down()),
        Key([META, SHIFT], LEFT, lazy.layout.swap_left()),
        Key([META, SHIFT], RIGHT, lazy.layout.swap_right()),

        # Toggle floating layout
        Key([META, ALT], "f", lazy.window.toggle_floating()),

        # Tab to switch workspace.
        Key([META], TAB, lazy.screen.next_group()),
        Key([META, SHIFT], TAB, lazy.screen.prev_group()),
        Key([ALT], TAB, lazy.screen.next_group()),
        Key([ALT, SHIFT], TAB, lazy.screen.prev_group()),

        # Move window between screens.
        Key(
            [META, SHIFT],
            RIGHT,
            lazy.function(window_to_next_screen, switch_screen=True),
        ),
        Key(
            [META, SHIFT],
            LEFT,
            lazy.function(window_to_previous_screen, switch_screen=True),
        ),

        # Change focus between screens.
        Key([META], HOME, lazy.prev_screen(), desc='Next monitor'),
        Key([META], END, lazy.next_screen(), desc='Next monitor'),

        Key([META, CTRL], "1",
            lazy.to_screen(2),  # Left screen
            desc='Keyboard focus to monitor 1'
        ),
        Key([META, CTRL], "2",
            lazy.to_screen(0),  # Middle screen
            desc='Keyboard focus to monitor 2'
        ),
        Key([META, CTRL], "3",
            lazy.to_screen(1),  # Right screen
            desc='Keyboard focus to monitor 3'
        ),
    ]
    # fmt:on

    # Add keybinding for switching to specific workspaces.
    first_numrow_key = 1
    for i, group in enumerate(groups, start=first_numrow_key):
        last_numrow_key = 0
        if i == 10:
            i = last_numrow_key
        numkey = str(i)

        keys.extend(
            # fmt:off
            [
                # Change workspaces
                Key([META], numkey, lazy.group[group.name].toscreen()),

                # Move window to selected workspace 1-10 and stay on workspace
                # Key([META, SHIFT], numkey, lazy.window.togroup(group.name)),

                # Move window to selected workspace 1-10 and follow moved window to workspace
                Key(
                    [META, SHIFT],
                    numkey,
                    lazy.window.togroup(group.name),
                    lazy.group[group.name].toscreen(),
                ),
            ]
            # fmt:on
        )

    return keys
