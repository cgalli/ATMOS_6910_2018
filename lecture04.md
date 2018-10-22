# I/O: Input and output, part I

Working with CSV and JSON in python is a simple task. With CSV, python supports several modules, but most common is simply the "csv" module, available as a built-in.

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

Here, we find the first observed temperature after freezing level is reached. In a more simplified approach, I could ask for some recent observations from the weather station WBB, available from an [API here](http://api.mesowest.net/v2/stations/timeseries?&stid=wbb&token=demotoken&recent=1440&units=english&vars=air_temp&output=csv).

If this were saved to disk and called wbb.csv, I might read it and look for maximun and minimum temperatures like this:

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
JSON stands for Javascript Object Notation, and is used extensively over the web as a format returned from API services. JSON is mostly identical in concept as python dictionaries. This makes working with JSON very easy. Suppose I had a response from an API for [WBB air temperatures](http://api.mesowest.net/v2/stations/timeseries?&stid=wbb&token=demotoken&recent=1440&units=english&vars=air_temp&fields=STID). 

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

