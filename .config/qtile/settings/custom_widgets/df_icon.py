import psutil
from libqtile.widget import base

# TODO: Widget class not implemented!


class MyDfIcon(base.ThreadPoolText):
    def __init__(self) -> None:
        super().__init__()

    def poll(self):
        # df_percent = psutil.
        return super().poll()
