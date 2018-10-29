# Final Project

The final project will consist of analyzing multiple data sets representing the same locations over the month of June, 2017 and 2018.
There are three main sets of data: time series surface observation data from NWS automated weather stations as CSV (or JSON),
model output from the HRRR (High Resolution Rapid Refresh) surface analysis products as grib2,
and a remote sensed data set (TBD still) as HDF or NetCDF. 

The objective of this project is focused on effectively organizing and processing these data sets in order to attempt answering several questions.
The questions we're asking are not overly complex, and for the most part not as important as the the actual gathering and processing of the data.
Additionally, each data set is available (archived) in different specific formats that atmospheric scientists often use. Becoming
comfortable with working on these types of data is fundamental in our field. 

## Data sets
### MesoWest archived time series observations 

- Timeseries of air temperature from 3 locations.
-- Salt Lake City, UT. Station identifier KSLC.
-- Houston, TX. Station identifier KHOU.
-- August, ME. Station identifier KAUG.


Downloading timeseries data from MesoWest/Synoptic Data API services

http://api.synopticlabs.org/v2/stations/timeseries?&token=demotoken&stid=KAUG&start=201806010000&end=201806302359&output=csv&vars=air_temp,relative_humidity,wind_speed,wind_gust

### HRRR surface analysis grids
Our own department's PhD candidate Brian Blaylock has created the only HRRR archive for easy access to forecast and analysis products located at [http://hrrr.chpc.utah.edu/](http://hrrr.chpc.utah.edu/). 
From this archive, you'll be extracting grib2 files for 2 meter surface temperatures and wind speed. 
