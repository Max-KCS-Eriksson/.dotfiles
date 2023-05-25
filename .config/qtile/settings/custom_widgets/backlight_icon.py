from libqtile import widget


class MyBacklightIcon(widget.Backlight):
    """
    Child class to format the percentage output.

    Note: the "format" kwarg needs to be set to "{percent}" for the widget to display
    the correct value.
    """

    def __init__(self, icon, low_color, min_color, max_color, **kwargs):
        self.icon = icon
        self.low_color = low_color
        self.min_color = min_color
        self.max_color = max_color
        super().__init__(**kwargs)

    def _get_info(self):
        brightness = self._load_file(self.brightness_file)
        max_value = self._load_file(self.max_brightness_file)
        return int((brightness / max_value) * 100)

    def poll(self):
        try:
            percent = self._get_info()
        except RuntimeError as e:
            return "Error: {}".format(e)

        return percent

    def tick(self):
        current_brightness = self.poll()

        if current_brightness <= 0:
            text = f"<span foreground='{self.low_color}'>{self.icon}</span>"
        elif current_brightness < 50:
            text = f"<span foreground='{self.min_color}'>{self.icon}</span>"
        else:
            text = f"<span foreground='{self.max_color}'>{self.icon}</span>"

        self.update(text)
