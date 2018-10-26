import numpy as np
from netCDF4 import Dataset
import matplotlib.pyplot as plt
import h5py
#from pyhdf.SD import SD,SDC

nc_f='/uufs/chpc.utah.edu/common/home/mace-group3/arm/grw/grwvceil25kM1.b1/2010/grwvceil25kM1.b1.20100828.000008.cdf'
nc_fid=Dataset(nc_f,'r')
print nc_fid.file_format
print nc_fid.dimensions.keys()
print nc_fid.dimensions['time']
print nc_fid.variables.keys()
print nc_fid.variables['first_cbh']
base_time=nc_fid.variables['base_time'][:]
first_cbh=nc_fid.variables['first_cbh'][:]
print base_time
fig=plt.figure()



hdf_f='/uufs/chpc.utah.edu/common/home/mace-group4/gpm/GPM_L2/GPM_2AKa.05/2018/010/2A.GPM.Ka.V7-20170308.20180110-S072245-E085520.021977.V05A.HDF5'
f=h5py.File(hdf_f,'r')
f.keys()
group1=f.get('MS')
print group1.items()
lat=group1.get('Latitude')
print lat
print(lat[0:10,0:10])
np.array(lat).shape
f.close


#hdf_f='/uufs/chpc.utah.edu/common/home/mace-group4/modis/MYD06_L2/2008/092/MYD06_L2.A2008092.0210.006.2013344194530.hdf'
#file=SD(hdf_f,SDC.READ)
#print file.info()




