"""
Module defining the a class and a wrapper function to check for changes in a webpage.
"""

import os
from pathlib import Path

from bs4 import BeautifulSoup
from selenium import webdriver

from .. import color_theme
from .webpage_monitor_settings import URL_TO_MONITOR, LOG_PATH

BASE_DIR = Path(__file__).resolve().parent
HOME_DIR = Path(os.path.expanduser("~"))

COLORS = color_theme.init_theme()
OK = COLORS["dim"][0]
WARNING = COLORS["warning"]
DANGER = COLORS["danger"]
CRITICAL = COLORS["critical"]


class Scraper:
    def __init__(self):
        options = webdriver.FirefoxOptions()
        options.headless = True

        service = webdriver.FirefoxService(log_path=LOG_PATH)

        self.driver = webdriver.Firefox(options=options, service=service)
        self.driver.maximize_window()

    def scrape(self, url):
        self.driver.get(url)
        source = BeautifulSoup(self.driver.page_source)
        self.driver.quit()

        return source

    def compare_sources(self, url):
        # Ensure filename doesn't resemble path structure.
        url_name = url.lstrip("https:/").rstrip("/").replace("/", "#")
        comparison_file_path = BASE_DIR / f"comparison_{url_name}.html"

        # Check if comparison file exists. Create if not.
        if os.path.exists(comparison_file_path):
            with open(comparison_file_path, "r") as f:
                comparison_file = f.read()
        else:
            with open(comparison_file_path, "w") as f:
                f.write(str(self.scrape(url)))
            return f"<span foreground='{DANGER}'>No comparison: Creating one</span>"

        # Compare scrape(url) == comparison file.
        try:
            latest_state = str(self.scrape(url))
        except:
            return f"<span foreground='{WARNING}'>No response</span>"

        if latest_state == comparison_file:
            return f"<span foreground='{OK}'>No changes</span>"
        else:
            return f"<span foreground='{CRITICAL}' font='JetBrainsMono Nerd Font bold'>CHANGE DETECTED</span>"


def check_once():
    """
    Wrapper function to init a Scraper instance and use it's methods on the global
    URL_TO_MONITOR variable.
    """
    scraper = Scraper()
    return scraper.compare_sources(URL_TO_MONITOR)
