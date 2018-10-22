# I/O: Input and output, part I

Working with CSV and JSON in python is a simple task. With CSV, python supports several modules, but most common is simply the "csv" module, available as a built-in.

```
with open('sounding.csv', 'rb') as csvfile:
...     myreader = csv.reader(csvfile, delimiter=',')
...     for row in spamreader:
...         print ', '.join(row)
Spam, Spam, Spam, Spam, Spam, Baked Beans
Spam, Lovely Spam, Wonderful Spam
```
