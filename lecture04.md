# I/O: Input and output, part I

Working with CSV and JSON in python is a simple task. With CSV, python supports several modules, but most common is simply the "csv" module, available as a built-in.

CSV is comma separated values, but any parseable text file can be treated in similar ways. Take for example a atmospheric sounding originating at Salt Lake City. (http://weather.uwyo.edu/upperair/sounding.html). The text list output looks like this:

```
72572 SLC Salt Lake City Observations at 12Z 21 Oct 2018
-----------------------------------------------------------------------------
   PRES   HGHT   TEMP   DWPT   RELH   MIXR   DRCT   SKNT   THTA   THTE   THTV
    hPa     m      C      C      %    g/kg    deg   knot     K      K      K 
-----------------------------------------------------------------------------
 1000.0    146                                                               
  925.0    821                                                               
  876.0   1289   11.0    2.0     54   5.07    130      4  295.1  310.2  296.0
  867.0   1375   15.0    1.0     39   4.77    135      6  300.1  314.7  301.0
  852.0   1521   15.4   -0.6     33   4.32    144     10  302.1  315.4  302.9
  850.0   1541   15.4   -0.6     33   4.33    145     10  302.3  315.7  303.1
  828.0   1762   13.4   -0.6     38   4.44    160     13  302.4  316.2  303.2
  821.5   1829   14.1    0.1     38   4.72    165     14  303.9  318.5  304.7
  819.0   1854   14.4    0.4     38   4.83    166     14  304.4  319.4  305.3
```

