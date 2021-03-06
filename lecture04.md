# I/O: Input and output, part I

Working with CSV and JSON in python is a simple task. With CSV, python supports several modules, but most common is simply the "csv" module, available in most default distributions.

## CSV
CSV is comma separated values, but any parseable text file can be treated in similar ways. Take for example an atmospheric sounding originating from Salt Lake City (http://weather.uwyo.edu/upperair/sounding.html). The text list output looks like this:

```
72572 SLC Salt Lake City Observations at 12Z 21 Oct 2018
-----------------------------------------------------------------------------
   PRES   HGHT   TEMP   DWPT   RELH   MIXR   DRCT   SKNT   THTA   THTE   THTV
    hPa     m      C      C      %    g/kg    deg   knot     K      K      K 
-----------------------------------------------------------------------------
 1000.0    146                                                               
  925.0    821                                                               
  876.0   1289   11.0    2.0     54   5.07    130      4  295.1  310.2  296.0
  867.0   1375   15.0    1.0     39   4.77    135      6  300.1  314.7  301.0
  852.0   1521   15.4   -0.6     33   4.32    144     10  302.1  315.4  302.9
  850.0   1541   15.4   -0.6     33   4.33    145     10  302.3  315.7  303.1
  828.0   1762   13.4   -0.6     38   4.44    160     13  302.4  316.2  303.2
  821.5   1829   14.1    0.1     38   4.72    165     14  303.9  318.5  304.7
  819.0   1854   14.4    0.4     38   4.83    166     14  304.4  319.4  305.3
```

The data is organized in a predicatable format, so it's very easy to approach parsing. In this case, we can use the character positions. There are 78 character. The first 7 are reserved for pressure, the next 7 for height, then the next for temperature, and so on. 

If data is organized as "splittable" on spaces, or tabs, or even new lines, then sometimes not using any parser module is equally fine.

Assume we had a text file on disk of a sounding called "sounding.txt". We could open the file and parse it quickly with this:

```
f = open('sounding.txt', 'r')
lines = f.readlines()
f.close()

for line in lines[4::]:
    parts = line.strip().split(None)
    if float(parts[2]) <= 0:
        print('freezing level is at %s Mb with a height of %s meters.' % (parts[0],parts[1]) )
        break
```

Here, we find the first observed temperature after freezing level is reached. In a more simplified approach, we could ask for some recent observations from the weather station WBB, available from an [API here](http://api.mesowest.net/v2/stations/timeseries?&stid=wbb&token=demotoken&recent=1440&units=english&vars=air_temp&output=csv).

```
# STATION: WBB
# STATION NAME: U of U William Browning Building
# LATITUDE: 40.76623
# LONGITUDE: -111.84755
# ELEVATION [ft]: 4806
# STATE: UT
Station_ID,Date_Time,air_temp_set_1
,,Fahrenheit
WBB,2018-10-21T03:19:00Z,55.22
WBB,2018-10-21T03:20:00Z,55.26
WBB,2018-10-21T03:21:00Z,55.18
WBB,2018-10-21T03:22:00Z,55.11
```
If this were saved to disk and called wbb.csv, we can read this file and look for maximun and minimum temperatures in the time series:

```
with open('wbb.csv', 'rb') as csvfile:
    reader = csv.reader(csvfile, delimiter=',')
    air_temps = []
    dates = []
    for row in reader:
        if row[0] == 'WBB':
            air_temps.append(row[2])
            dates.append(row[1])

print('max temp is: ', max(air_temps))

#now I need to find at what time.
max_temp = max(air_temps)

#get index position of matching max value
idx = air_temps.index(max_temp)

#get date
max_temp_date = dates[idx]

#or all at once
max_temp_date = dates[air_temps.index(max(air_temps))]

#but these are still strings! Maybe numpy can be useful here
import numpy as np

t = np.array(air_temps, dtype=np.float)

print(t.max())
print('index location of max value', np.argmax(t))

idx = np.argmax(t)
print('max temp is %s at %s' % (t[idx], dates[idx]) )
```

## JSON
JSON stands for Javascript Object Notation, and is used extensively over the web as a format returned from API services. JSON is mostly identical in concept as python dictionaries. This makes working with JSON very easy. Suppose we had a response from an API for [WBB air temperatures](http://api.mesowest.net/v2/stations/timeseries?&stid=wbb&token=demotoken&recent=1440&units=english&vars=air_temp&fields=STID). 

```
{
  "STATION": [
    {
      "STID": "WBB",
      "OBSERVATIONS": {
        "date_time": [
          "2018-10-21T02:20:00Z",
          "2018-10-21T02:21:00Z",
          "2018-10-21T02:22:00Z"
         ],
        "air_temp_set_1": [
          56.37,
          56.35,
          56.41
         ]
      }
   }
   ]
} 
```

JSON can be turned into python dictionaries with the use of the json module:
```
import json

f = open('wbb.json', 'r')
wbb_json = f.read()
f.close()

wbb = json.loads(wbb_json)
```
From there it's easy traverse the dictionary like this:

```
dates = wbb['STATION'][0]['OBSERVATIONS']['date_time']
air_temps = wbb['STATION'][0]['OBSERVATIONS']['air_temp_set_1']
```

Note, the variables are already organized as matching length lists, which can be converted to Numpy arrays. We could then quickly find the minimum temperature in the series:
```
import numpy as np

t = np.array(air_temps, dtype=np.float)
idx = np.argmin(t)
print('minimum temperature is %s F at %s' % (t[idx], dates[idx] ) )
```

## Exercise: read in values from wbb.csv, convert temperature in F, to Kelvin and write it out as wbb_kelvin.csv

```
import csv

file_out = open('wbb_kelvin.csv', 'w')

with open('wbb.csv', 'rb') as csvfile:
    reader = csv.reader(csvfile, delimiter=',')
    for row in reader:
        if row[0] == 'WBB':
            air_temp_k = (float(row[2]) − 32.) * 5./9. + 273.15
            file_out.write('%s,%s,%s\n' % (row[0],row[1],air_temp_k))
         else:
            file_out.write(','.join(row))

file_out.close()

```
