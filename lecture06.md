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

Let's take a look at the NDFD products for 1 to 3 day forecasts. The National Digital Forecast Database (NDFD) is a suite of gridded forecasts of sensible weather elements (e.g., cloud cover, maximum temperature). You can find the [website here.](https://www.weather.gov/mdl/ndfd_home) This data set is extremely valuable for short term forecast products. Many weather companies use these official grids to produce simple point-based forecasts.

[http://tgftp.nws.noaa.gov/SL.us008001/ST.opnl/DF.gr2/DC.ndfd/AR.conus/VP.001-003/](http://tgftp.nws.noaa.gov/SL.us008001/ST.opnl/DF.gr2/DC.ndfd/AR.conus/VP.001-003/)

Metadata is almost always found elsewhere. Grib files are optimized for high compression ratios which allows for faster distribution and saves considerable disk space.

## Grib record details

Listing the records in a grib file is simply done by running the wgrib2 utility against the file. For example, here's a RAP 40km forecast hour:

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



https://www.brynmawr.edu/cs/resources/beauty-of-programming

