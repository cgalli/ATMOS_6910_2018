pro lecture05_scientific_netcdf

;  Heres an array
numtimes=60
lat=findgen(60)

;  Put it in a file
fdir='/uufs/chpc.utah.edu/common/home/u0079358/atmos_6910/'
fname='latitude.cdf'
fid=ncdf_create(fdir+fname,/clobber)
time_did=ncdf_dimdef(fid,'numtimes',numtimes)
lat_id=ncdf_vardef(fid,'latitude',time_did,/float)
ncdf_attput,fid,lat_id,'units','degrees North'
ncdf_control,fid,/ENDEF
ncdf_varput,fid,lat_id,lat
ncdf_close,fid
stop

;  Read from a netcdf file
fname='201603312345Z_merra.cdf'
fid=ncdf_open(fdir+fname)
xid=ncdf_varid(fid,'H')
ncdf_varget,fid,xid,height
xid=ncdf_varid(fid,'T')
ncdf_varget,fid,xid,temp
ncdf_close,fid
p1=plot(temp,height)
stop
 
; HDF4

;  File directory
filedir='/uufs/chpc.utah.edu/common/home/mace-group3/cloudsat/CS_2B-GEOPROF_GRANULE_P_R04/2008/02/'

;  File name
filename='2008059172631_09777_CS_2B-GEOPROF_GRANULE_P_R04_E02.hdf'

;  Open the hdf file
fid=hdf_open(filedir+filename,/read)

;The TAI timestamp for the first profile in the data file.
;TAI is International Atomic Time: seconds since 00:00:00 Jan 1 1993.
vdref=hdf_vd_find(fid,'TAI_start')
vdid=hdf_vd_attach(fid,vdref,/read)
result=hdf_vd_read(vdid,tai_start)
hdf_vd_detach,vdid

;Seconds since the start of the granule for each profile. The first profile is 0.
vdref=hdf_vd_find(fid,'Profile_time')
vdid=hdf_vd_attach(fid,vdref,/read)
result=hdf_vd_read(vdid,profile_time)
hdf_vd_detach,vdid

;  Open HDF file in SD mode
fid=hdf_sd_start(filedir+filename,/read)
var_id=hdf_sd_nametoindex(fid,'Radar_Reflectivity')
sds_id=hdf_sd_select(fid,var_id)
hdf_sd_getdata,sds_id,dbz
hdf_sd_endaccess,sds_id
hdf_sd_end,fid

stop

;******************
;  Read data from hdf5 file
;******************
radar='ku'
fdir='/uufs/chpc.utah.edu/common/home/mace-group4/gpm/GPM_L2/GPM_2AKu.05/2018/017/'
fname='2A.GPM.Ku.V7-20170308.20180117-S165029-E182303.022092.V05A.HDF5'
file_id=h5f_open(fdir+fname)
if radar eq 'ku' then begin
  ns_id=h5g_open(file_id,'NS')
endif else if radar eq 'ka' then begin
  ns_id=h5g_open(file_id,'HS')
endif
dset_id=h5d_open(ns_id,'Latitude')
lat=h5d_read(dset_id)
h5d_close,dset_id
dset_id=h5d_open(ns_id,'Longitude')
lon=h5d_read(dset_id)
h5d_close,dset_id
slv_id=h5g_open(ns_id,'SLV')
dset_id=h5d_open(slv_id,'zFactorCorrected')
dbz=h5d_read(dset_id)
h5d_close,dset_id
h5g_close,slv_id
time_id=h5g_open(ns_id,'ScanTime')
dset_id=h5d_open(time_id,'DayOfYear')
doy=h5d_read(dset_id)
h5d_close,dset_id
dset_id=h5d_open(time_id,'Year')
year=h5d_read(dset_id)
h5d_close,dset_id
dset_id=h5d_open(time_id,'Month')
month=h5d_read(dset_id)
h5d_close,dset_id
dset_id=h5d_open(time_id,'DayOfMonth')
day=h5d_read(dset_id)
h5d_close,dset_id
dset_id=h5d_open(time_id,'Hour')
hour=h5d_read(dset_id)
h5d_close,dset_id
dset_id=h5d_open(time_id,'Minute')
minute=h5d_read(dset_id)
h5d_close,dset_id
dset_id=h5d_open(time_id,'Second')
second=h5d_read(dset_id)
h5d_close,dset_id
dset_id=h5d_open(time_id,'MilliSecond')
msecond=h5d_read(dset_id)
h5d_close,dset_id
h5g_close,time_id
pre_id=h5g_open(ns_id,'PRE')
dset_id=h5d_open(time_id,'elevation')
elevation=h5d_read(dset_id)  ;meters
dset_id=h5d_open(time_id,'zFactorMeasured')
dbz_measured=h5d_read(dset_id)
h5d_close,dset_id

h5g_close,ns_id
h5f_close,file_id
stop
;s=size(dbz,/dimensions)
;print,s
;nbin=s[0]  ;176
;nray=s[1]  ;49
;nscan=s[2] ;7937

end