# Final Project

The final project will consist of analyzing multiple data sets representing the same locations over the month of June in 2017 and 2018. There are three main sets of data: time series surface observation data from NWS automated weather stations as CSV (or JSON), model output from the HRRR (High Resolution Rapid Refresh) surface analysis products as grib2, and a remote sensed data set (TBD still) as HDF or NetCDF. 

The objective of this project is focused on effectively organizing and processing these data sets in order to attempt answering several questions. The questions we're asking are not overly complex, and for the most part not as important as the actual gathering and processing of the data. Additionally, each data set is available (archived) in different specific formats that atmospheric scientists often use. Becoming comfortable with working on these types of data is fundamental in our field. 

This project is worth 50 points, and comprises one third of your final grade. (1.0/3.0 and not 1/3)

## Data sets
### MesoWest archived time series observations 

Time series of air temperature and wind speed observations from 3 locations
- Salt Lake City, UT. Station identifier KSLC.
- Houston, TX. Station identifier KHOU.
- August, ME. Station identifier KAUG.

Variables to extract: air temperature, wind speed, wind gust.

Resources
- [https://developers.synopticdata.com/mesonet/v2/](https://developers.synopticdata.com/mesonet/v2/)
- Get access: [https://developers.synopticdata.com/mesonet/signup/](https://developers.synopticdata.com/mesonet/signup/)

Downloading time series data from MesoWest/Synoptic Data API services is simple to do. The pattern to use for this assignment will look like this:

http://api.synopticlabs.org/v2/stations/timeseries?&token={your token}&stid={station ID}&start=201806010000&end=201806302359&output=csv&vars=air_temp,wind_speed,wind_gust

### HRRR surface analysis grids
Brian Blaylock, a PhD candidate in our department, has created the only HRRR archive for easy access to forecast and analysis products located at [http://hrrr.chpc.utah.edu/](http://hrrr.chpc.utah.edu/). This CHPC hosted archive uses an object store technology similar to cloud providers, such as Amazon or Google's cloud. From this archive, you'll be extracting grib2 files for 2 meter surface temperatures and 10 meter wind speed (stored as U and V vector components in the files). The analysis files are the 00 forecast hour from the model run time and will look similar to this in the grib2 index file:

66:35216477:d=2018102800:TMP:2 m above ground:anl:

Variables to extract: 2 meter above ground air temperature, 10 meter above ground wind speed, and wind gust.

Resources:
- [HRRR archive main page](http://hrrr.chpc.utah.edu/)
- [HRRR download page](http://home.chpc.utah.edu/~u0553130/Brian_Blaylock/cgi-bin/hrrr_download.cgi)

### MODIS derived surface temperature
Using the files from Homework 4, match the morning and afternoon land surface temp modis observations with the closest surface air temperature observation for each station (KSLC, KHOU, KAUG).  Plot the lst/sfc obs pairs on a scatter plot, using only the lst/sfc pairs that are within 1 hour of each other.  Plot morning and evening data for each station on a separate plot.  This will be 6 scatter plots. Use Figure 5 of http://dx.doi.org/10.1016/j.rse.2014.06.001  for a reference.

### GOES 16 Satellite 
THe GOES 16 satellite is one of many GOES-R series satellites, a collaboration between NOAA and NASA to increase remote sensing capabilities and coverage. [GOES-R web page](https://www.goes-r.gov/)

Resources:
- Bryan Blaylock's GOES-16 archive: [http://home.chpc.utah.edu/~u0553130/Brian_Blaylock/cgi-bin/goes16_pando.cgi](http://home.chpc.utah.edu/~u0553130/Brian_Blaylock/cgi-bin/goes16_pando.cgi)
- Bryan's python repos: [https://github.com/blaylockbk/pyBKB_v2/tree/master/BB_goes16](https://github.com/blaylockbk/pyBKB_v2/tree/master/BB_goes16). There's also a python V3 version a directory level up.

## Questions we're asking
In this project, we'll be asking the specific questions below. The complexity of the questions are not difficult and can be answered easily once the data is organized and processed. It is common to spend 90% of the time with acquiring, organizing, and pre-processing data in order to perform the actual "work" or analysis with the data. In this case, it will be at least 90% if not closer to 99%. 

Questions
- For each year of data (2017 and 2018) separately for all three stations, at what datetime did the minimum and maximum air temperatures occur. There will be a total of 12 values found.
- For the wind gusts contained in the HRRR data set for each hourly analysis file across the June months in 2017 and 2018, at what datetimes are the observed surface gust greater for each station?
- Create two different scatter plots, one for air temperature and another for wind speed comparing all observed surface data nearest the top of the hour to the model output data of the same hours for each of the three stations. Calculate the correlation coefficient. 
- Calculate two mean air temperatures for each station for all times (June 2017 and 2018) using both surface station observations and HRRR grid points. There will be 6 values in all.
- For the maximum temperature for each station using the grid point closest in the HRRR, for all times in June 2018, download the closest matching CONUS GEOS-16 ABI Level 1b Radiances product from the CHPC Pando archive and plot the scene. Mark the location of the station in the plot. The plot should have country and state outlines, plotted as a true color image (R, G, B) in the projection of your choice.

### Extra credit / alternative tasks
You are welcome and encouraged to also approach finding answers to your own questions based on these data sets. You will be allowed to ask two additional questions which you can programmatically provide answers to, upon approval of your instructor. These additional tasks will count for more points toward your final grade to make up missed assignment or attendance throughout the semester. Total extra points will not exceed 20.

### Notes
- When comparing time series surface observations to forecast data, all data 30 minutes before and 29 minutes after should be associated to the center hour, which allows for comparison of hourly analysis data.
- All HRRR analysis files will be the 00 hour from the respective 00 UTC through 23 UTC model runs. 
- Wind gust data in the surface observations will be sparse, meaning NULL values will be needed when no gust was reported.
- Extracting the model grid points for the three stations requires the latitude and longitude metadata from each station.

## Due
Projects must be complete by Dec 5, 2018 where we will be reviewing approaches and techniques in class together. Students will have until Dec 12 to turn in the final code via email or a link to their CHPC home directory where the code resides and runs.
