import json

f = open('wbb.json', 'r')
wbb_json = f.read()
f.close()

wbb = json.loads(wbb_json)

print(wbb.keys())

dates = wbb['STATION'][0]['OBSERVATIONS']['date_time']
air_temps = wbb['STATION'][0]['OBSERVATIONS']['air_temp_set_1']

#find min temp

import numpy as np

t = np.array(air_temps, dtype=np.float)
min_temp = t.min()

print('min temp is', min_temp)

idx = np.argmin(t)

print('min temp is %s at %s' % (t[idx], dates[idx] ) )

