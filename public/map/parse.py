import csv
import json
from pprint import pprint

with open('data.json') as data_file:    
    data = json.load(data_file)
    locations = data["cwbopendata"]["location"]
    result = [];
    for place in locations:
    	result.append({"addr": [place['lat'], place['lon']], "text": place['locationName'], "icon": "images/bluePin.png"})
    print json.dumps(result)