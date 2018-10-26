# I/O Part II: grib

GRIB (GRIdded Binary or General Regularly-distributed Information in Binary form[1]) is a concise data format commonly used in meteorology to store historical and forecast weather data. It is standardized by the World Meteorological Organization's Commission for Basic Systems, known under number GRIB FM 92-IX, described in WMO Manual on Codes No.306. 

[https://en.wikipedia.org/wiki/GRIB](https://en.wikipedia.org/wiki/GRIB)

Grib files have these practical defining characteristics:

- Store 2 dimensional "slabs" or arrays of data for a single parameter/variable (e.g., 2m air temperature)
- Self describing. The headers are messages in each segment of data.
- Internal packing and compression for each variable.
- Sequential byte range positions for each variable.
- Regularly gridded.
- Well supported and used everywhere.

## A note on forecast files
Gridded model output is commonly organized by an initialization time (often called the runtime) with forecast time steps written in separate files.
For example, the GFS model ([Global Forecast System](https://en.wikipedia.org/wiki/Global_Forecast_System)) runs 6 times a day at 00 UTC, 06 UTC, 12 UTC, and 18 UTC.
Each run outputs forecasts every hour into the future through 96 hours. Then every 3 hours. At 10 days, the model decreases in spatial resolution from 13 km to 27 km out through 16 days.


The NAM is run every 6 hours, as well. The RAP and HRRR are run every hour out to varying forecast times.

Some models create analysis products that are useful for retrospective tasks, such as validating surface observations, or comparing other remote sensed data sets.
Analysis grids are also used to initialize model runs starting at the moment, given they often contain the best representation of the environment from observations.

## Grib indexes
All grib files can be indexed which provides a short description of the contained fields or records. This requires a full inspection of each file. The resulting index will often have .idx suffix sitting alonside the grib file in its distribution directory.

- fh.0003_tl.press_gr.0p50deg
- fh.0003_tl.press_gr.0p50deg.idx

Such as here in the NWS operational FTP web directory:

[ftp://tgftp.nws.noaa.gov/SL.us008001/ST.opnl/](http://tgftp.nws.noaa.gov/SL.us008001/ST.opnl/)

Consider the NDFD products for 1 to 3 day forecasts. The National Digital Forecast Database (NDFD) is a suite of gridded forecasts of sensible weather elements (e.g., cloud cover, maximum temperature). You can find the [website here.](https://www.weather.gov/mdl/ndfd_home) This data set is extremely valuable for short term forecast products. Many weather companies use these official grids to produce simple point-based forecasts.

[http://tgftp.nws.noaa.gov/SL.us008001/ST.opnl/DF.gr2/DC.ndfd/AR.conus/VP.001-003/](http://tgftp.nws.noaa.gov/SL.us008001/ST.opnl/DF.gr2/DC.ndfd/AR.conus/VP.001-003/)

Metadata is almost always found elsewhere. Grib files are optimized for high compression ratios which allows for faster distribution and saves considerable disk space.

## Grib record details

Using another model as an example, listing the records in a grib file is simply done by running the wgrib2 utility against the file. Here's a RAP 40km forecast hour:

```
wgrib2 fh.0003_tl.press_gr.us40km

...
8:92036:d=2018102512:HGT:100 mb:3 hour fcst:
9:104507:d=2018102512:TMP:100 mb:3 hour fcst:
10:111042:d=2018102512:RH:100 mb:3 hour fcst:
11:117303:d=2018102512:VVEL:100 mb:3 hour fcst:
12.1:120591:d=2018102512:UGRD:100 mb:3 hour fcst:
12.2:120591:d=2018102512:VGRD:100 mb:3 hour fcst:
13:135200:d=2018102512:HGT:125 mb:3 hour fcst:
14:147689:d=2018102512:TMP:125 mb:3 hour fcst:
...
```

## Exercise
Let's download a forecast hour from a model run and look at how the records are stored in the file.

- Download the 3 hour forecast of the RAP 40km from the NWS website. The root directory is here: [http://tgftp.nws.noaa.gov/SL.us008001/ST.opnl/](http://tgftp.nws.noaa.gov/SL.us008001/ST.opnl/)
-- Navigate to the MT.rap_CY.12 directory in a web browser. This is the RAP 12 UTC runtime cycle.
-- The current day should be noted in the next directory name, such as RD.20181020/. The PT.grid_DF.gr2/ directory is where grib2 files reside.
- Note there is an index file called fh.0003_tl.press_gr.us40km.idx. Click on that and review the fields available.
- Download the the 40km RAP grib file for the 3rd forecast hour. It'll look like this: fh.0003_tl.press_gr.us40km. You can right click on the file and "copy link address". In your terminal, use wget or curl to download the file locally.
-- wget http://tgftp.nws.noaa.gov/SL.us008001/ST.opnl/MT.rap_CY.12/RD.20181020/PT.grid_DF.gr2/fh.0003_tl.press_gr.us40km

Once downloaded to a local directory, use the wgrib2 utility to review the contents of the file.
- wgrib2 fh.0003_tl.press_gr.us40km

You'll see output like the above stream by. The descriptions are separated by the ":" (colon) character. The parts are organzied as such:

'''
8:92036:d=2018102512:HGT:100 mb:3 hour fcst:
'''
- 8 denotes it's the 8th record in the grib file
- 92036 is the exact byte position of where the record starts in the file
- d=2018102512 is the runtime date and hour as YYYYMMDDHH, always in UTC
- HGT is the class or type of record
- 100 mb is the height level the record represents
- 3 hour fcst notes the forecast time in the future from the model runtime.

What time does this grib file represent?

There are a lot of ways to interact with grib files using the wgrib2 utility. Here are two notable resources found at NCEP:
- [http://www.ftp.cpc.ncep.noaa.gov/wd51we/wgrib2/tricks.wgrib2](http://www.ftp.cpc.ncep.noaa.gov/wd51we/wgrib2/tricks.wgrib2)
- [http://www.ftp.cpc.ncep.noaa.gov/wd51we/wgrib2/tricks.cheap](http://www.ftp.cpc.ncep.noaa.gov/wd51we/wgrib2/tricks.cheap)

Let's explore this file in more detail.

To target just a single record, a pattern match can be used, or a specific record number can be used:

```
wgrib2 -d 8 fh.0003_tl.press_gr.us40km

or

wgrib2 -match ":TMP:" fh.0003_tl.press_gr.us40km

or to see the descriptions verbosely

wgrib2 -v -match ":TMP:" fh.0003_tl.press_gr.us40km

9:104507:d=2018102512:TMP Temperature [K]:100 mb:3 hour fcst:
14:147689:d=2018102512:TMP Temperature [K]:125 mb:3 hour fcst:
19:193939:d=2018102512:TMP Temperature [K]:150 mb:3 hour fcst:

```

Targeting specific records is useful, because other commands allow for specific subsetting, or statistical calculations, etc. 
For example, how would we get the average temperature across the entire record of 2m surface temperatures?

```
wgrib2 -match ":TMP:2 m above ground" -stats fh.0003_tl.press_gr.us40km

203:2321981:ndata=17063:undef=0:mean=284.819:min=260.042:max=303.605:cos_wt_mean=286.222
```

What about grid information? The model horizontal spacing? The number of rows and columns in the 2D array (latitudes and longitudes)?

```
wgrib2 -domain -match ":TMP:2 m above ground" fh.0003_tl.press_gr.us40km

203:2321981:N=58.365355 S=16.362787 W=-139.856122 E=-57.381070

wgrib2 -grid -match ":TMP:2 m above ground" fh.0003_tl.press_gr.us40km

203:2321981:grid_template=30:winds(grid):
	Lambert Conformal: (151 x 113) input WE:SN output WE:SN res 56
	Lat1 16.281000 Lon1 233.862000 LoV 265.000000
	LatD 25.000000 Latin1 25.000000 Latin2 25.000000
	LatSP 0.000000 LonSP 0.000000
	North Pole (151 x 113) Dx 40635.000000 m Dy 40635.000000 m mode 56
  
```

Now that we understand the domain extents of this grid, we can ask for specific points of data in the grid.

```
#get the 2 meter above ground relative humidity value for grid position (20, 40)

wgrib2 -ij 20 40 -match ":RH:2 m above ground" fh.0003_tl.press_gr.us40km

209:2397892:val=89.2946

#get the closest grid point to a specified latitude and longitude, like Salt Lake City

wgrib2 -lon -111.89 40.76 -match ":RH:2 m above ground" fh.0003_tl.press_gr.us40km

209:2397892:lon=248.296691,lat=40.614280,val=83.2946

```

Although it's interesting to extract data this way, how do we get it into our programs? How do we automate the processing of gridded forecast data for a project?



# Reading Assignment

https://www.brynmawr.edu/cs/resources/beauty-of-programming

