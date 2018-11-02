# Homework Assignment 2
### Assigned: Nov 2, 2018
### Due: No later than 1541608200 seconds since Jan 1, 1970 00:00:00 UCT
### Deliverable: Python script
### Delivery: Email single file of code to chris.galli@utah.edu

## First order of business
Figure out when this assignment is due (hint, google 'epoch time converter', or use python's datetime module)

This assignment requires you to download all of the June 2017 and 2018 data for the three ASOS surface stations noted in our final project from the MesoWest API (Synoptic Data, api.synopticdata.com). The three variables to grab are air_temp, wind_speed and wind_gust. The stations are KSLC, KHOU, and KAUG. Again, the request pattern looks like the below. Don't forget to signup and get your API key. [See the final project outline for more details here.](./semester_project.md). You will need to use your own API token.

This python script must accomplish the following tasks:

- Acquire all data from the noted API (three stations, two years of June data, three variables).
- Organize the data into a python dictionary or other simple object.
- Convert the string date_time values into a datetime object or numerical format such as epoch seconds. 
- Save the data in your own organized way to disk. Python pickles are great at saving the state of python objects all at once.
- Find the max wind gust for KHOU across both years of data, and print out the time it occurred.


Python 3 
```
import urllib.request
import json

url = 'http://api.synopticdata.com/v2/stations/timeseries?stid=KSLC&token=your_token&start=201706010000&end=201706302359&vars=air_temp,wind_speed,wind_gust'
req = urllib.request.Request(url)

##parsing response
r = urllib.request.urlopen(req).read()
data = json.loads(r.decode('utf-8'))

```

Python 2
```
import urllib2
import json

url = 'http://api.synopticdata.com/v2/stations/timeseries?stid=KSLC&token=your_token&start=201706010000&end=201706302359&vars=air_temp,wind_speed,wind_gust'
response = urllib2.urlopen(url)
data = json.load(response)

```

Then getting data from the python dictionary (converted from JSON):

```
dates = data['STATION'][0]['OBSERVATIONS']['date_time']
temps = data['STATION'][0]['OBSERVATIONS']['air_temp_set_1']
wind_speed = data['STATION'][0]['OBSERVATIONS']['wind_speed_set_1']
wind_gust = data['STATION'][0]['OBSERVATIONS']['wind_gust_set_1']

```

You can organize the data you retrieve from the API however you'd like, but consider organizing it all into a single python dictionary object. The reason is because you can simply save the "state" of the data in your prefered organized way
you've created. This is done with the python "pickle" module.

```
import pickle

surface_obs = {}
surface_obs['KSL'] = {}
surface_obs['KSL'][2017] = {"dates": dates, "temps": temps, "wind_speeds": wind_speed, "wind_gusts": wind_gust }

# see: https://stackoverflow.com/questions/11218477/how-can-i-use-pickle-to-save-a-dict

#dates are in a text string format known as ISO 8601 and look like this: 2017-06-01T00:00:00Z

```

These dates should be converted to a numerical value that is easy to compare other dates. The use of epoch seconds is something that will always work as a standardized time format. Using seconds allows to easily compare values across hour, day, month, and year boundaries, just to name a few. 

There are many ways to work with dates and times. The common modules are datetime, time, calendar, dateutil. Working with data at UTC is always easiest. The timegm function in calendar is a fast and easy way to convert a time tuple into epoch seconds.

```
import time
import calendar

pattern = '%Y-%m-%dT%H:%M:%SZ'
epoch = calendar.timegm(time.strptime(dates[0], pattern))

#and as a list comprehension, you can convert all of these dates from the API at once
epochs = [calendar.timegm(time.strptime(d, pattern)) for d in dates]

#or explicitly
epochs = []
for d in dates:
  epochs.append( calendar.timegm(time.strptime(d, pattern)) )
  
```

