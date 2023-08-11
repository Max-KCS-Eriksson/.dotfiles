from libqtile.config import Group


def init_groups():
    return [
        Group(
            name="1",
            # name = "HOME",
            layout="monadwide",
            label="",  #         
            layout_opts=None,  # Options to pass to a layout.
            screen_affinity=None,  # Preference to start on specific screen.
            spawn=None,
        ),
        Group(
            name="2",
            # name = "WEB",
            layout="monadtall",
            label=" ",  #   
            layout_opts=None,  # Options to pass to a layout.
            screen_affinity=None,  # Preference to start on specific screen.
            spawn=None,
        ),
        Group(
            name="3",
            # name="TRAINING",
            layout="monadtall",
            label="",  #   
            layout_opts=None,  # Options to pass to a layout.
            screen_affinity=None,  # Preference to start on specific screen.
            spawn=None,
        ),
        Group(
            name="4",
            # name = "LAB",
            layout="monadwide",
            label="",  #   
            layout_opts=None,  # Options to pass to a layout.
            screen_affinity=None,  # Preference to start on specific screen.
            spawn=None,
        ),
        Group(
            name="5",
            # name = "FILE",
            layout="monadtall",
            label="",  #   
            layout_opts=None,  # Options to pass to a layout.
            screen_affinity=None,  # Preference to start on specific screen.
            spawn=None,
        ),
        Group(
            name="6",
            # name = "BREAK",
            layout="monadtall",
            label="",  # 
            layout_opts=None,  # Options to pass to a layout.
            screen_affinity=None,  # Preference to start on specific screen.
            spawn=None,
        ),
        Group(
            name="7",
            # name = "NOTES",
            layout="monadtall",
            label="",  #       
            layout_opts=None,  # Options to pass to a layout.
            screen_affinity=None,  # Preference to start on specific screen.
            spawn=None,
        ),
        Group(
            name="8",
            # name = "CONF"
            layout="monadtall",
            label="",  #     
            layout_opts=None,  # Options to pass to a layout.
            screen_affinity=None,  # Preference to start on specific screen.
            spawn=None,
        ),
        Group(
            name="9",
            # name = "MUSIC",
            layout="monadtall",
            label="",  # 
            layout_opts=None,  # Options to pass to a layout.
            screen_affinity=None,  # Preference to start on specific screen.
            spawn=None,
        ),
        Group(
            name="0",
            # name = "MAIL",
            layout="monadtall",
            label="",  #     @    
            layout_opts=None,  # Options to pass to a layout.
            screen_affinity=None,  # Preference to start on specific screen.
            spawn=None,
        ),
    ]
