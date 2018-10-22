import csv

#with open('sounding.txt', 'rb') as csvfile:
#    reader = csv.reader(csvfile, delimiter=' ')
#    for row in reader:
#        print ', '.join(row)

#hmmm, that's not what I wanted.
f = open('sounding.txt', 'r')
lines = f.readlines()
f.close()

for line in lines[4::]:
    parts = line.strip().split(None)
    #print parts
    if float(parts[2]) <= 0:
        print('freezing level is at %s Mb with a height of %s meters.' % (parts[0],parts[1]) )
        break


