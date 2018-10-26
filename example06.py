import matplotlib
#matplotlib.use('agg')  # Or any other X11 back-end

import os
import numpy as np

model_dir = 'http://tgftp.nws.noaa.gov/SL.us008001/ST.opnl/'
model_day = '20181025'
model_runtime = '12'
model_forecast_hour = '0003'

model_file = 'fh.%s_tl.press_gr.us40km' % model_forecast_hour
url = (model_dir + 'MT.rap_CY.%s/RD.%s/PT.grid_DF.gr2/' + model_file) % (model_runtime, model_day)

#download grib file 

cmd = 'wget %s' % url
os.system(cmd)

#now use wgrib2 utility to grab 2 meter temperatures
cmd = '/tmp/wgrib2 -match ":TMP:2 m above ground:" %s -no_header -bin out.bin' % model_file
os.system(cmd)

# open the binary file in numpy
# discovered from the wgrib2 -grid feature

xsize = 151 #number of lons
ysize = 113 #number of lats
data = np.fromfile('out.bin', dtype=np.float32).reshape(ysize,xsize).transpose()

#plot it. What does this look like?
import matplotlib.pyplot as plt

plt.figure(1)
plt.imshow(data, interpolation='nearest')
plt.grid(True)

plt.show()
