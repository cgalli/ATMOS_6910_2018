import csv

#http://api.mesowest.net/v2/stations/timeseries?&stid=wbb&token=demotoken&recent=1440&units=english&vars=air_temp&output=csv

with open('wbb.csv', 'rb') as csvfile:
    reader = csv.reader(csvfile, delimiter=',')
    air_temps = []
    dates = []
    for row in reader:
        if row[0] == 'WBB':
            air_temps.append(row[2])
            dates.append(row[1])

print('max temp is: ', max(air_temps))

#now I need to find at what time.
max_temp = max(air_temps)

#get index position of matching max value
idx = air_temps.index(max_temp)

#get date
max_temp_date = dates[idx]

#or all at once
max_temp_date = dates[air_temps.index(max(air_temps))]

#but these are still strings! Maybe numpy can be useful here
import numpy as np

t = np.array(air_temps, dtype=np.float)

print(t.max())
print('index location of max value', np.argmax(t))

idx = np.argmax(t)
print('max temp is %s at %s' % (t[idx], dates[idx]) )


