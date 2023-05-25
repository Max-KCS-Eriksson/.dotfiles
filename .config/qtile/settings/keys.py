from libqtile.config import Key
from libqtile.command import lazy

# Mod keys
# mod4 or mod = super key
mod = "mod4"
mod1 = "alt"
mod2 = "control"


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
        if switch_screen == True:
            qtile.cmd_to_screen(i - 1)


def window_to_next_screen(qtile, switch_group=False, switch_screen=False):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group, switch_group=switch_group)
        if switch_screen == True:
            qtile.cmd_to_screen(i + 1)


# fmt:off

def init_keybindings(groups):
    """Most keybindings are in sxhkd file - except these."""
    keys = [
        # Super keys
        Key([mod, "shift"], "f", lazy.window.toggle_fullscreen()),
        Key([mod], "Escape", lazy.window.kill()),

        # Super + Shift keys
        Key([mod, "shift"], "q", lazy.window.kill()),
        Key([mod, "shift"], "r", lazy.restart()),
        Key([mod, "shift"], "space", lazy.next_layout()),

        # Super + Ctrl keys
        Key([mod, "control"], "r", lazy.reload_config()),

        # Qtile layout keys
        Key([mod], "n", lazy.layout.normalize()),

        # Change focus
        Key([mod], "Up", lazy.layout.up()),
        Key([mod], "Down", lazy.layout.down()),
        Key([mod], "Left", lazy.layout.left()),
        Key([mod], "Right", lazy.layout.right()),
        Key([mod], "k", lazy.layout.up()),
        Key([mod], "j", lazy.layout.down()),
        Key([mod], "h", lazy.layout.left()),
        Key([mod], "l", lazy.layout.right()),

        # Resize up, down, left, right
        Key(
            [mod, "control"],
            "l",
            lazy.layout.grow_right(),
            lazy.layout.grow(),
            lazy.layout.increase_ratio(),
            lazy.layout.delete(),
        ),
        Key(
            [mod, "control"],
            "Right",
            lazy.layout.grow_right(),
            lazy.layout.grow(),
            lazy.layout.increase_ratio(),
            lazy.layout.delete(),
        ),
        Key(
            [mod, "control"],
            "h",
            lazy.layout.grow_left(),
            lazy.layout.shrink(),
            lazy.layout.decrease_ratio(),
            lazy.layout.add(),
        ),
        Key(
            [mod, "control"],
            "Left",
            lazy.layout.grow_left(),
            lazy.layout.shrink(),
            lazy.layout.decrease_ratio(),
            lazy.layout.add(),
        ),
        Key(
            [mod, "control"],
            "k",
            lazy.layout.grow_up(),
            lazy.layout.grow(),
            lazy.layout.decrease_nmaster(),
        ),
        Key(
            [mod, "control"],
            "Up",
            lazy.layout.grow_up(),
            lazy.layout.grow(),
            lazy.layout.decrease_nmaster(),
        ),
        Key(
            [mod, "control"],
            "j",
            lazy.layout.grow_down(),
            lazy.layout.shrink(),
            lazy.layout.increase_nmaster(),
        ),
        Key(
            [mod, "control"],
            "Down",
            lazy.layout.grow_down(),
            lazy.layout.shrink(),
            lazy.layout.increase_nmaster(),
        ),

        # Flip layout for MonadTall/MonadWide
        Key([mod, "shift"], "t", lazy.layout.flip()),

        # Flip layout for BSP
        Key([mod, "mod1"], "k", lazy.layout.flip_up()),
        Key([mod, "mod1"], "j", lazy.layout.flip_down()),
        Key([mod, "mod1"], "l", lazy.layout.flip_right()),
        Key([mod, "mod1"], "h", lazy.layout.flip_left()),

        # Move windows up or down BSP layout
        Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
        Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
        Key([mod, "shift"], "h", lazy.layout.shuffle_left()),
        Key([mod, "shift"], "l", lazy.layout.shuffle_right()),

        # Move windows up or down MonadTall/MonadWide layout
        Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),
        Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),
        Key([mod, "shift"], "Left", lazy.layout.swap_left()),
        Key([mod, "shift"], "Right", lazy.layout.swap_right()),

        # Toggle floating layout
        Key([mod, "mod1"], "space", lazy.window.toggle_floating()),

        # Tab to switch workspace.
        Key([mod], "Tab", lazy.screen.next_group()),
        Key([mod, "shift"], "Tab", lazy.screen.prev_group()),
        Key(["mod1"], "Tab", lazy.screen.next_group()),
        Key(["mod1", "shift"], "Tab", lazy.screen.prev_group()),

        # Move window between screens.
        Key(
            [mod, "shift"],
            "Right",
            lazy.function(window_to_next_screen, switch_screen=True),
        ),
        Key(
            [mod, "shift"],
            "Left",
            lazy.function(window_to_previous_screen, switch_screen=True),
        ),

        # Change focus between screens.
        Key([mod], 'home', lazy.prev_screen(), desc='Next monitor'),
        Key([mod], 'end', lazy.next_screen(), desc='Next monitor'),

        Key([mod2, "mod4"], "1",
            lazy.to_screen(2),  # Left screen
            desc='Keyboard focus to monitor 1'
        ),
        Key([mod2, "mod4"], "2",
            lazy.to_screen(0),  # Middle screen
            desc='Keyboard focus to monitor 2'
        ),
        Key([mod2, "mod4"], "3",
            lazy.to_screen(1),  # Right screen
            desc='Keyboard focus to monitor 3'
        ),
    ]


    # Add keybinding for switching to specific workspaces.
    for i, group in enumerate(groups, start=1):
        keys.extend(
            [
                # CHANGE WORKSPACES
                Key([mod], group.name, lazy.group[group.name].toscreen()),

                # MOVE WINDOW TO SELECTED WORKSPACE 1-10 AND STAY ON WORKSPACE
                # Key([mod, "shift"], key, lazy.window.togroup(group.name)),

                # MOVE WINDOW TO SELECTED WORKSPACE 1-10 AND FOLLOW MOVED WINDOW TO WORKSPACE
                Key(
                    [mod, "shift"],
                    group.name,
                    lazy.window.togroup(group.name),
                    lazy.group[group.name].toscreen(),
                ),
            ]
        )

    return keys
