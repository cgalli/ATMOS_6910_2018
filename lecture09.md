# Arrays

## Shapes, sizes, and resize

Consider a simple array created with arange:
```
>>> data = np.arange(10)**2.
>>> data
array([ 0.,  1.,  4.,  9., 16., 25., 36., 49., 64., 81.])
>>> data
array([ 0.,  1.,  4.,  9., 16., 25., 36., 49., 64., 81.])
>>> data.shape
(10,)
>>> data.size
10
>>> data.dtype
dtype('float64')
>>>
```

As 10 elements, this array can be reshaped to any number of dimensions as long as the total number of elements is preserved:
```
>>> data.reshape(5,2)
array([[ 0.,  1.],
       [ 4.,  9.],
       [16., 25.],
       [36., 49.],
       [64., 81.]])
       
>>> data.reshape(5,2)[3]
array([36., 49.])

#how about reshape of (10,1)? or (1,1,1,10,1,1,1) ?!
>>> data.reshape(10,1)
array([[ 0.],
       [ 1.],
       [ 4.],
       [ 9.],
       [16.],
       [25.],
       [36.],
       [49.],
       [64.],
       [81.]])
```

It is possible to resize a data array, into a shape that does not contain the same number of original elements.
```
>>> data = np.arange(10)
>>> data.resize(3,3) # note this happens in-place
>>> data.shape
(3, 3)

>>> data.resize(10)
>>> data
array([0, 1, 2, 3, 4, 5, 6, 7, 8, 0])

```

## Slicing
Arrays can be referenced and sliced or subsettd in many way. The most direct and common approach is to target data by element positions. From the above example, we can take the first 3 elements like this:

```
>>> data
array([ 0.,  1.,  4.,  9., 16., 25., 36., 49., 64., 81.])
>>> data[0:3]
array([0., 1., 4.])

#from 7 to ?
>>> data[7:10]
array([49., 64., 81.])
>>> data[7:11]
array([49., 64., 81.])
>>> data[7:12]
array([49., 64., 81.])
>>> data[7::]
array([49., 64., 81.])

#getting a middle slice
>>> data[3:5]
array([ 9., 16.])

#getting every other element, starting at 1 (step or stride)
>>> data[1::2]
array([ 1.,  9., 25., 49., 81.])

```


The end point in slicing is not inclusive, and because the index position of 3 is the fourth element, the returned slice is 3 elements long.


Depending on how data is consumed from external sources, the row order vs column order for multiple dimensions need to be considered carefully. In a previous example of reading in raw binary grib files, we had a need to reverse the entire array to make it easier to work with. Consider what we did to get our X (longitude) and Y (latitude) axis to match a cartesian coordiante system where North is up, etc.

```
data = np.flipud(np.fromfile('out.bin', dtype=np.float32).reshape(ysize,xsize)).transpose()
```

If we walked through the logic of what this is doing we get this:

- Read some raw binary data from a file called out.bin.
- The discrete data values in out.bin are 4 byte floats (32 bits).
- After reading the entire file and assigning each 4 byte segment into an array, we end up with an array of size N
- Assuming we already know about how the data was stored in the source file, we reshape the data as (Y,X) because it was read in as column order. 
- Once reshaped, we can transpose the data which results in a new shape of (X,Y)
- And because the binary data stored on disk was reversed, the entire array needs to be flipped upside down.


Let's see this happen with a sample data array of 12 elements with a shape of (4,3). Let's assume these are temperatures in Kelvin and the value of -9999. represents the first top left grid point (farthest North and West):

```
>>> data = np.array([273.63, 276.31, 275.57, -9999., 275.12, 274.04, 276.5, 273.93, 276.5, 273.6 , 273.52, 278.83])
>>> data = np.flipud(data.reshape(3,4).transpose())

>>> data[0,0]
-9999.0

>>> data[:,0]
array([-9999.  ,   275.57,   276.31,   273.63])
```

## Organizing data in a meaningful way with arrays

Suppose we have a need to work with a set of data with these dimension attributes:

- A 10 km box around a center point from a 1km forecast model output file. A shape of (10,10)
- With the first 7 vertical levels of air temperature starting at the surface. A shape of (7,)
- At hourly increments for 24 hours. A shape of (24,)

If we didn't know any better, we might create arrays in this manner:

```
hour_1_level_2_temp = np.zeros((10,10), dtype=np.float)
hour_1_level_3_temp = np.zeros((10,10), dtype=np.float)
hour_1_level_4_temp = np.zeros((10,10), dtype=np.float)

...

hour_23_level_7_temp = np.zeros((10,10), dtype=np.float)

```

This is never a good idea, although it still can work. A better approach is to create an array with all dimensions.

**(pop quiz! How many elements are in this above data set?)**

```
temps = np.zeros((24,7,10,10), dtype=np.float)
```

Let's load a saved numpy array of this exact example. It's found in this repo as **10x10_7_levels.npz**

```
>>> import numpy as np

>>> d = np.load('./10x10_7_levels.npz')
>>> d.files
['temps']

>>> data = d['temps']
>>> data.shape
(24, 7, 10, 10)

#looks like
>>> data
[2911, 2913, 2914, ..., 2914, 2916, 2918]]]], dtype=int16)

data = data / 10.

```

Let's also assume these levels are pressure levels, starting at 1000 hPa and every 25 hPa upwards. So we have a level coordinate system as: levels = [1000, 975, 950, 925, 900, 875, 850]


## Answering simple statistical questions

Given the above set of data, where we have a 10 km X 10 km grid of temperatures from the surface up in 7 levels across 24 consecutive hours, we can start to inspect and answer basic questions.

**What's the average temperature on the 12 UTC hour for all grid points on the surface?** Knowing the structure on our array, we can easily target the appropriate data and find the mean value.

```
mean_12z_temp = data[11,0,:,:].mean()

308.05400000000003
```

Position "11" in the first dimension is the 12th hour in this data (we start at 0), and the "0th" position for the second dimension is the surface level, and ":" for the thrid and fourth dimensions represent All data. We then can subset and execute the mean() function in one line.

**What's the minimum temperature within the 2x2 km center for the surface level from 00 UTC through 03 UTC?** 

```
min_value = data[0:3,0,4:6,4:6].min()

304.4
```

**What level has the largest standard deviation in the 18 UTC hour?** 

```
std_levels = data[17,:,:,:].std(axis=(1,2))

#or 
std_levels = []
for i in range(7):
       std_levels[i] = data[17,i,:,:].std()

#find max sdev value position
np.argmax(std_levels)
4

#or

print levels[np.argmax(std_levels)], 'hPa'
900, hPa

```

## Searching for specific data

Performing statistics on an entire data set is fairly easy to do once it's organized. Searching for specific attributes or points of interest, or breaking points in data is trickier. The use of the numpy where function comes in handy.


To simplify showing this, let's grab a single vertical profile of for one grid point at one time period. Let's use the top left grid point for the profile at the 12 UTC hour. 

```
t = data[11,:,0,0]

#find all data that's <= 300 Kelvin

results = np.where(t <= 300.0)
(array([4, 5, 6]),)

#these are the positions, now print out the values

print t[results]
[299.5 295.4 292.5]

```

**What is the lowest pressure level with a value >= 300.0 Kelvin at the grid position of (3,3)?**

```
#assuming we had these levels available:

levels = np.array([1000, 975, 950, 925, 900, 875, 850])

t = data[11,:,3,3]
r = np.where(t >= 300.0)

#what levels do we have?
levels[r]
array([1000,  975,  950,  925])

#and the minimum pressure level (highest above surface)?
print levels[r].min()
925

```

Setting values to NaN or something notable based on thresholds is a very common task. We can use the np.where function, and even expedite the process with additional arguments. Let's say we can't trust any value less than 298.5 degrees Kelvin in our data set due to a shortcoming of how it was derived. We still might want to work with the "good" data in meaningful ways. The rigorous approach is to loop over every element and compare it to our threshold value, setting it to NaN when applicable. We can also use np.where like this:

```
data_good = np.where(data < 298.5, np.nan, data)

#now let's get the mean temperature of the entire data set
np.mean(data_good)
nan

#!? What

#when using nan values, you must use nan functions
np.nanmean(data_good)
304.2059241503296

```
