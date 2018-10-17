pro lecture02_variables_datatypes

;****************
;  Mixed type calculations - Cloudsat
;****************

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

hdf_close,fid

;  Seconds in a day 86400
sec_per_day=24*60*60

day1=julday(1,1,1993,0,0,0)

julian_day=day1+((tai_start+profile_time)/sec_per_day)

caldat,julian_day,mm,dd,yy,hh,mi,ss
for i=0,10 do begin
  print,yy[i],mm[i],dd[i],hh[i],mi[i],ss[i]
endfor

stop

;  sec_per_day needs to be a real value for it to work correctly

;************************
;  STORED AS AN INTEGER
;************************

;  Open HDF file in SD mode
file_id=hdf_sd_start(filedir+filename,/read)
var_id=hdf_sd_nametoindex(file_id,'Radar_Reflectivity')
sds_id=hdf_sd_select(file_id,var_id)
hdf_sd_getdata,sds_id,dbz
hdf_sd_endaccess,sds_id
hdf_sd_end,file_id


stop


;**********************
;  Overflow and underflow errors
;**********************

x=0.25e20
y=0.10e30
z=x*y
stop

x=double(0.25e20)
y=double(0.10e30)
z=x*y
stop

a=0.25e-25
b=0.10e+25
c=a/b
stop

a=double(0.25e-25)
b=double(0.10e+25)
c=a/b
stop


end