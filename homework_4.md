<H1>Homework Assignment 4</H1>
<H3>Assigned: Nov 14,2018</H3>
<H3>Due: Nov 21, 2018 22:00 UTC</H3>
<H3>Deliverable: Python script</H3>
<H3>Delivery: Email single file of code to chris.galli@utah.edu with answers in the email.</H3>
<H2>The assignment</H2>
<p>Read in the MYD11_L2 LST over KSLC for June 2017.  Find the corresponding surface air temperature measurement to the LST retrieval.  Plot as a scatter plot like Fig 5. Shamir et al. 2014.</p>
<p>Task items:</p>
<ul>
<LI>
All the data files you need are located here: <P>/uufs/chpc.utah.edu/common/home/mace-group4/modis/MYD11_L2/atmos_6910<P> 
These are small subsets of the MYD11_L2 modis product around each station.  Copy over the netcdf files.
</LI>
<LI>
  Read in the June 2017 data for an area around KSLC.  The date and time of the modis observation is in the filename.  The station is in the filename
</li>
<li>There will be a day and a night obervation for each 24 hours.  Pull out the closest pixel to KSLC for each of the two observations for each day</li>
<li>Find the closest in time surface air temperature measurement to the modis land surface temperature. These values are the values from homework assignment 2.</li>
<li>Plot the surface air temperature/lst pairs on a scatter plot.  An example is Figure 5 in this paper  http://dx.doi.org/10.1016/j.rse.2014.06.001  
  <LI>Plot all the obs together.</LI>
  <LI>Plot the morning and afternoon obs separately.</LI>  
  <LI>Plot separately the morning and afternoon observations that are within 1 hour of a station observation.   </li>
</ul>
<H2>Notes</H2>
<ul>
<li>This page describes the MYD11_L2 product and links to documentation  <a href="https://lpdaac.usgs.gov/dataset_discovery/modis/modis_products_table/myd11_l2_v006">MYD11_L2 V006</a></li>
  <LI> from netCDF4 import Dataset </LI>
</UL>  

