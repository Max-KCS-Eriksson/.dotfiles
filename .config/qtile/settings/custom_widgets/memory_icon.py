import psutil
from libqtile.widget import base

# TODO: Widget class not implemented!


class MyMemoryIcon(base.ThreadPoolText):
    def __init__(self) -> None:
        super().__init__()

    def poll(self):
        memory_percent = psutil.virtual_memory().percent
        return super().poll()
