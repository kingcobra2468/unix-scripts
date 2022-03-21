#!/usr/bin/env python3
from bs4 import BeautifulSoup
import requests

# simple script reporting for weather to terminal. No need for setting location as Google's weather
# widget can intelligently find that out for you :)

HEADERS = {
    'User-Agent': 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:64.0) Gecko/20100101 Firefox/64.0'}
GOOGLE_WIDGET_SOURCE = requests.get('https://www.google.com/search?client=ubuntu&channel=fs&q=weather&ie=utf-8&oe=utf-8',
                                    headers=HEADERS)

soup_parser = BeautifulSoup(GOOGLE_WIDGET_SOURCE.text, 'html.parser')
temperature = soup_parser.find('span', {'id': 'wob_tm'}).text
weather_type = soup_parser.find('span', {'id': 'wob_dc'}).text

print("The weather is %s and %s." % (temperature, weather_type))
