# Final Project

The final project will consist of analyzing multiple data sets representing the same locations over the month of June in 2017 and 2018. There are three main sets of data: time series surface observation data from NWS automated weather stations as CSV (or JSON), model output from the HRRR (High Resolution Rapid Refresh) surface analysis products as grib2, and a remote sensed data set (TBD still) as HDF or NetCDF. 

The objective of this project is focused on effectively organizing and processing these data sets in order to attempt answering several questions. The questions we're asking are not overly complex, and for the most part not as important as the the actual gathering and processing of the data. Additionally, each data set is available (archived) in different specific formats that atmospheric scientists often use. Becoming comfortable with working on these types of data is fundamental in our field. 

## Data sets
### MesoWest archived time series observations 

Time series of air temperature and wind speed observations from 3 locations
- Salt Lake City, UT. Station identifier KSLC.
- Houston, TX. Station identifier KHOU.
- August, ME. Station identifier KAUG.

Variables to extract: air temperature, wind speed, wind gust.

Resrouces
- [https://developers.synopticdata.com/mesonet/v2/](https://developers.synopticdata.com/mesonet/v2/)
- Get access: [https://developers.synopticdata.com/mesonet/signup/](https://developers.synopticdata.com/mesonet/signup/)

Downloading timeseries data from MesoWest/Synoptic Data API services is simple to do. The pattern to use for this assignment will look like this:

http://api.synopticlabs.org/v2/stations/timeseries?&token={your token}&stid={station ID}&start=201806010000&end=201806302359&output=csv&vars=air_temp,wind_speed,wind_gust

### HRRR surface analysis grids
Brian Blaylock, a PhD candidate in our department, has created the only HRRR archive for easy access to forecast and analysis products located at [http://hrrr.chpc.utah.edu/](http://hrrr.chpc.utah.edu/). This CHPC hosted archive uses an object store technology similar to cloud providers, such as Amazon or Google's cloud. From this archive, you'll be extracting grib2 files for 2 meter surface temperatures and 10 meter wind speed (stored as U and V vector components in the files). The analysis files are the 00 forecast hour from the model run time and will look similar to this in the grib2 index file:

66:35216477:d=2018102800:TMP:2 m above ground:anl:

Variables to extract: 2 meter above ground air temperature, 10 meter above ground wind speed, and wind gust.

Resources:
- [HRRR archive main page](http://hrrr.chpc.utah.edu/)
- [HRRR download page](http://home.chpc.utah.edu/~u0553130/Brian_Blaylock/cgi-bin/hrrr_download.cgi)

### MODIS or LANDSAT derived surface temperature
TBD still.

## Questions we're asking
In this project, we'll be asking the specific questions below. The complexity of the questions are not difficult and can be answered easily once the data is organized and processed. It is common to spend 90% of the time with acquiring, organizing, and pre-processing data in order to perform the actual "work" or analysis with the data. In this case, it will be at least 90% if not closer to 99%. 

Questions
- For each year of data (2017 and 2018) separately for all three stations, at what datetime did the minimum and maximum air temperatures occur. There will be a total of 12 values found.
- For the wind gusts contained in the HRRR data set for each hourly analysis file across the June months in 2017 and 2018, at what datetimes was the observed surface gust greater for each station?
- What is the 

Notes
- When comparing time series surface observations to forecast data, all data 30 minutes before and 29 minutes after should be associated to the center hour, which allows for comparison of hourly analysis data.
- All HRRR analysis files will be the 00 hour from the respective 00 UTC through 23 UTC model runs. 
