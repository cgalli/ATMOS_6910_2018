
# Homework Assignment 3
### Assigned: Nov 7, 2018
### Due: Nov 14, 2018
### Deliverable: Python script
### Delivery: Email single file of code to chris.galli@utah.edu with answers in the email.


## The assignment

We've spent time working with grib2 data already, so let's put it into practice. This assignment includes downloading 24 hours of grib2 HRRR 2 meter above ground surface temperatures from the CHPC Pando archive. 

Task items:
- Download all 24 hours of grib2 HRRR surface files for 2 meter above ground surface temperatures for June 1, 2018.
- Find the metadata that describes the coordinate system.
- Using the latitude and longitude grids, determine the grid point closest to the KHOU Houston, TX station. This will be a (x,y) position within the 2D array of data.
- Calculate the mean temperature across the 24 hour period for the location found.

## Notes

- Some of the language in the final project was intended to be a little nebulous in scope. This assignment is to help bridge the gap of what is asked and how to actually approach finding stations near or close to a model grid point.  [See the final project questions.](./semester_project.md)
- There are many ways to find the latitudes and longitudes of the model coordinate system. One if from extrernally available metadata files describing the system (additional hdf5 or netcdf files). Another is to extract it directly from the grib2 file based on the grid info. The wgrib2 utility has features to create the latitudes and longitudes for every every point, and can even be output as csv, though it will be a rather large file.
- There are MANY ways to approach finding the closest point in another array / grid of data. To simplify the distance equation, use sqrt(a**2 + b**2) for now. This is a close enough approximation for our needs at this point.


## Useful python / numpy features
- np.fromfile to read in the binary gridded data if you chose that route
- np.where to find the location closest matching location of a single lat/lon point in a larger grid, or to subset a "box" of point around a location
- np.asrray or np.array to get the latitudes and longitudes into a 2d array.



