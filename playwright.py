import pandas as pd
from playwright.sync_api import sync_playwright, Playwright
import re

# Read in names data
open = pd.read_csv('data/open.csv')
open['Alias'] = open['Alias'].replace('Eric Magnus', 'Magneto')

# Initialize Playwright
pw = sync_playwright().start()
chrome = pw.chromium.launch(headless = False)
page = chrome.new_page()
page.goto('https://marvel.fandom.com/wiki/Special:Search?query=&scope=internal&contentType=&ns%5B0%5D=0&ns%5B1%5D=116&ns%5B2%5D=118&ns%5B3%5D=126&ns%5B4%5D=2900')

# Loop to download images
for member in open['Member']:
    page.fill('input.unified-search__input__query', member)
    page.locator('button.wds-button.unified-search__input__button').click()
    page.locator('css=.unified-search__result__header').nth(1).click()
    page.locator('css=.image')

# Run to close
page.close()
chrome.close()
pw.stop()