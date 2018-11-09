# Arrays II

## Evaluating results of results
Taking results from an existing set of results by index position is a common pattern in data analysis. Take for example a case of determining rates of change for a variable. We might have a case to find the rate of change for a subset of the original data set. While it is possible to simply create copies of the subsetted data into new arrays, it is often not wise to do so. And in some cases, there may not be enough resource on the server. 

Let's suppose we have a need to understand how frequently there are moments of when the air temperature is greater than 28 C in Salt Lake City during June. A certain crop must be planted only when there are at least 3 hour periods of continuous temperatures above that 28 C threshold, or so some hypothesis suggests. Taking the air temperatures from the last homework assignment, how can we tease this out?

```
import urllib2
import json

url = 'http://api.synopticdata.com/v2/stations/timeseries?stid=KSLC&token=demotoken&start=201706010000&end=201706302359&vars=air_temp,wind_speed,wind_gust'
response = urllib2.urlopen(url)
data = json.load(response)
temps = data['STATION'][0]['OBSERVATIONS']['air_temp_set_1']
dates = data['STATION'][0]['OBSERVATIONS']['date_time']

import time
import calendar

pattern = '%Y-%m-%dT%H:%M:%SZ'
epochs = [calendar.timegm(time.strptime(d, pattern)) for d in dates]

import numpy as np

temps = np.array(temps, dtype=np.float)
epochs = np.array(epochs)

temps.size
#9340

r = np.where(temps > 28.0)
#(array([   0,    1,    2, ..., 9337, 9338, 9339]),)

r[0].size
#2968

temps.min()
nan

```

After looking at the data and finding the min and max values, we realize there are NaN values in this data. We need to remove them, abd also remove the dates associated with them.

```
#there are nans in here :( better remove them
r = np.where(~np.isnan(temps))
temps = temps[r]
epochs = epochs[r]

#try this again
r = np.where(temps > 28.0)
r[0].size / temps.size
#0
#oops, I forgot these are integers 

r[0].size / float(temps.size)
#0.3177730192719486
```


We see that 31.8% of the time the temperature is above 28.0 C. Our goal is to first find how many discrete intervals there are when the temperature is above 28 C for at least 3 hours. 

```
#I could loop over and count 
#... this is a lot of "book keeping", but what else can I do?
start_date = 0
end_date = 0
counter = 0
number_of_consec_periods = 0

for i,t in enumerate(temps):
    #compare t to 28.0
    #if > 28 and start_date is 0 then we're starting one 
    #etc... 
    pass


#oh. Maybe I can use a where statement somehow to make this easier? 
# like np.where(temps > 28.0)

r = np.where(np.diff((temps > 28.0)))
segs = np.split(temps,r[0]+1)

#which means every other segment is a valid section of temps > 28 C
segs = np.split(temps,r[0]+1)[0::2]
seg_epochs = np.split(epochs,r[0]+1)[0::2]

#are we sure?!
#let's do a quick check
min([s.min() for s in segs])
#28.300000000000001

max([s.max() for s in segs])
#38.299999999999997

#so now we can loop over these 
# or just a list comprehension would be fine
count = np.sum([True for s in seg_epochs if (s[-1] - s[0]) >= (60*60*3)])

22
```

- What was that r[0]+1 about? 
- Why did we get every-other segment after splitting? The notion of [0::2] ?
- We're summing a bunch of True objects in counting? What's that?

## A note on Boolean element wise comparison results

We know that comparing arrays to equal sized arrays or scalars will result in a returned Boolean array of the same shape with values of True or False. It is sometimes useful to use this feature in summations and quick subsetting.

```
#get all epoch timestamps for when temperature is > 30 C

d = epochs[temps > 30.0]

# count the number of times the observations are within 60 seconds from the next observation

c = np.sum(np.diff(epochs) <= 60)
717

#find the average temperature change rate per every 10 minutes

a = np.mean(np.abs((np.diff(temps) / np.diff(epochs)) * 60 * 10))
0.66355624731643448

```


## HRRR coordinates

![HRRR](https://www.ready.noaa.gov/images/ready/HRRR.gif)


Getting the latitudes and longitudes is as easy as Brian has made it for us!
[From here.](https://github.com/blaylockbk/pyBKB_v3/blob/master/BB_HRRR/HRRR_Pando.py)

```
def get_hrrr_latlon(DICT=True):
    """
    Simply get the HRRR latitude and longitude grid, a file stored locally
    """
    import h5py
    FILE = '/uufs/chpc.utah.edu/common/home/horel-group7/Pando/hrrr/HRRR_latlon.h5'
    f = h5py.File(FILE)
    if DICT:
        return {'lat': f['latitude'][:],
                'lon': f['longitude'][:]}
    else:
        return f['latitude'][:], f['longitude'][:]

```

Knowing that the lats and lons are readily available, here are some numpy zipped files of the lats and lons

/uufs/chpc.utah.edu/common/home/u0095503/6910/hrrr_lats.npz
/uufs/chpc.utah.edu/common/home/u0095503/6910/hrrr_lons.npz

These files are arranged such that the upper left position of the coordinate system represents (0,0) in the arrays, and the lower right is (-1,-1) or (1799-1,1059-1), where the grid size of the HRRR data is 1799 x 1059 points. Organizing data in a way that intuitively makes sense to you is important. Some might argue that the lower left pixel of a model grid 2D array should be (0,0). It's entirely up to you regarding how you prefer to reference the coordinate system contained within the arrays.

As a sanity check, load in the latitudes and check how the data is stored:

```
>>> import numpy as np
>>> f = np.load('/uufs/chpc.utah.edu/common/home/u0095503/6910/hrrr_lats.npz')
>>> f.keys()
['arr_0']

>>> lats = f['arr_0']

#see if the left side (the first X position) starts at a higher latitude than the last
>>> lats[0,:]
array([ 47.83844,  47.81391,  47.78938, ...,  21.18775,  21.16287,  21.138  ])

#yes!

#and how about the values in the first row? They should all be the highest latitude N if it was stored as UL (upper left) being the NW corner.

>>> lats[:,0]
array([ 47.83844,  47.84874,  47.85902, ...,  47.86295,  47.85267,
        47.84238])

#excellent! Looks like this checks out

```

Suppose someone asked us to get the grid position within the HRRR data for a location at latitude 45.0 and a longitude of -110.0. Sound familiar?

```
import time
f = np.load('/uufs/chpc.utah.edu/common/home/u0095503/6910/hrrr_lons.npz')
lons = f['arr_0']

lat1 = 45.0
lon1 = -110.0

min_dist = 9999999.
stime = time.time()
for x in range(lons.shape[0]):
    for y in range(lons.shape[1]):
        lat2 = lats[x,y]
        lon2 = lons[x,y]
        d = np.sqrt((lat1 - lat2)**2 + (lon1 - lon2)**2)
        if d < min_dist:
            min_dist = d
            ll_idx = (x,y)

print time.time() - stime

14.9057290554

ll_idx
(570, 265)


stime = time.time()
n_deg = .05
min_dist = 9999999.
r = np.where((lons >= lon1 - n_deg) & (lons <= lon1 + n_deg) & (lats >= lat1 - n_deg) & (lats <= lat1 + n_deg))
for i in range(len(r[0])):
    lat2 = lats[r[0][i], r[1][i]]
    lon2 = lons[r[0][i], r[1][i]]
    d = np.sqrt((lat1 - lat2)**2 + (lon1 - lon2)**2)
    if d < min_dist:
        min_dist = d
        ll_idx = (r[0][i], r[1][i])

print time.time() - stime
0.0897121429443

ll_idx
(570, 265)

```
It is 167 times faster to use a chunking approach.
