# Basic Programs
Computer program defined: a collection of instructions that performs a specific task when executed by a computer.

Algorithm defined: a process or set of rules to be followed in calculations or other problem-solving operations, especially by a computer.

- Low level vs high level languages
- Compiled vs interpreted
- Object oriented languages
- Scripted languages

### Basic components of a program
All programs typically include these types of elements
- some form of input (IO)
- defined variables
- logical operators
- a flow path
- some form of output (IO)

# Working with arrays in python.

In native python, everything is an object.
- integers (int)
- floats (float)
- classes
- methods
- functions
- lists 
- dictionaries
- nested objects

With Pandas or Numpy, addition of special object types extend python as Arrays. Arrays are defined shapes and sizes of like data types. This allows for optimized memory consumption, increased computation of elements within the array.

Consider an array created as
```
a = np.arange(10)
```

position | value
-------- | -----
0 | 0
1 | 1
2 | 2
3 | 3
4 | 4
5 | 5
6 | 6
7 | 7
8 | 8
9 | 9

Or as 0 base arrays in "english"

position | value
-------- | -----
zeroth | 0
one-th | 1
two-th | 2
three-th | 3
fourth | 4

What's the data type?

Now consider an array created as:
```
b = np.arange(5) + 273.15
```

position | value
-------- | -----
0 | 273.15
1 | 274.15
2 | 275.15
3 | 276.15
4 | 277.15

What's the data type? Why? What about other attributes?

```
b.dtype
dtype('float64')

b.shape
(5,)

b.size
5

len(b)
5

```

Both arrays of "a" and "b" are vectors. An array of 2 dimensions is refered to as a matrix, though the term is often reserved for specific use in mathematics and linear algebra. A 3 dimensional array is often called a cuboid of data-cube. The term N-dimensional is used for most cases thereafter. In atmospheric science, we often work with 4D data, specifically model output from numerical predictions: x and y coordinate systems (catesian, or similar), height levels (pressure levels), and time steps (forecast hours or lead-times). 

What happens when you add a + b ?

```
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ValueError: operands could not be broadcast together with shapes (10,) (5,)
```

How about a * b[0] ?
```
>>> a * b[0]
array([    0.  ,   273.15,   546.3 ,   819.45,  1092.6 ,  1365.75,
        1638.9 ,  1912.05,  2185.2 ,  2458.35])
        
```

Rules are such that all dimensions, or the shapes of arrays, must match. For N dimensional arrays, all OR the last dimension must match in shape.
```
>>> a = np.arange(10).reshape(5,2)
>>> a
array([[0, 1],
       [2, 3],
       [4, 5],
       [6, 7],
       [8, 9]])

>>> b = np.arange(2)
>>> a * b
array([[0, 1],
      [0, 3],
      [0, 5],
      [0, 7],
      [0, 9]])
      
>>> b = np.arange(5)
>>> a * b
Traceback (most recent call last):
 File "<stdin>", line 1, in <module>
ValueError: operands could not be broadcast together with shapes (5,2) (5,) 
```

# Exercise
Let's play around at the command line in Python
- Open up a terminal window. How? On a Mac, terminal is built into the OS. To find it, hit CMD+Space and type "terminal"
- Type "which python" at the terminal window
- Type "python" to start enter a terminal session / console in python

Lists vs arrays in python.

## Task: create a 1D array of temperature values in Celsius from 0 to 10 and convert the array to Fahrenheit
- Hint: there are 11 elements in that number series
- The equation is: (C × 9/5) + 32 = F


### Numpy Arrays
Here is a short list of numpy array creation functions we often use in our field:
- np.array
- np.arange
- np.ones
- np.zeros
- np.empty
- np.random (.random, .randint, e.g. np.random.randint(10, size=(3, 4)) )
- np.asarray

Let's create a 2d numpy array using np.arange
```
a = np.arange(100).reshape(10,10)
```

Row order vs column order. [Wikipedia page on the topic](https://en.wikipedia.org/wiki/Row-_and_column-major_order)

xy | x0 | x1 | x2 | x3 | x4 | x5 | x6 | x7 | x8 | x9 
-- | -- | -- | -- | -- |  -- |  -- |  -- |  -- |  -- | --
y0 | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
y1 | 10 | 11 | 12 | 13 | 14 | 15 | 16 | 17 | 18 | 19
y2 | 20 | 21 | 22 | 23 | 24 | 25 | 26 | 27 | 28 | 29
y3 | 30 | 31 | 32 | 33 | 34 | 35 | 36 | 37 | 38 | 39
y4 | 40 | 41 | 42 | 43 | 44 | 45 | 46 | 47 | 48 | 49
y5 | 50 | 51 | 52 | 53 | 54 | 55 | 56 | 57 | 58 | 59
y6 | 60 | 61 | 62 | 63 | 64 | 65 | 66 | 67 | 68 | 69
y7 | 70 | 71 | 72 | 73 | 74 | 75 | 76 | 77 | 78 | 79
y8 | 80 | 81 | 82 | 83 | 84 | 85 | 86 | 87 | 88 | 89
y9 | 90 | 91 | 92 | 93 | 94 | 95 | 96 | 97 | 98 | 99


To converting arrays to lists is sometimes useful depending on the function or task. All numpy arrays can be created as a list object, even ND arrays!
```
my list = my_3d_array.tolist() 
```

Consider this:
```
a = np.arange(100).reshape(5,2,10)
b = a.tolist()

a.shape
(5, 2, 10)

b.shape
!?

a[3,1,0]
70

b[3,1,0]
!?

b[3][1][0]
70

a[0]
array([[ 0,  1,  2,  3,  4,  5,  6,  7,  8,  9],
       [10, 11, 12, 13, 14, 15, 16, 17, 18, 19]])

b[0]
[[0, 1, 2, 3, 4, 5, 6, 7, 8, 9], [10, 11, 12, 13, 14, 15, 16, 17, 18, 19]]

```

## Memory pointers and lists
```
#assign c to the first set of data in b at position 0
c = b[0]
c
   [[0, 1, 2, 3, 4, 5, 6, 7, 8, 9], [10, 11, 12, 13, 14, 15, 16, 17, 18, 19]]

#assign a value to first element of first dimension
c[0][0]=-9999
c
   [[-9999, 1, 2, 3, 4, 5, 6, 7, 8, 9], [10, 11, 12, 13, 14, 15, 16, 17, 18, 19]]

#what does b look like?
b
[[[-9999, 1, 2, 3, 4, 5, 6, 7, 8, 9], [10, 11, 12, 13, 14, 15, 16, 17, 18, 19]], [[20, 21, 22, 23, 24, 25, 26, 27, 28, 29], [30, 31, 32, 33, 34, 35, 36, 37, 38, 39]], [[40, 41, 42, 43, 44, 45, 46, 47, 48, 49], [50, 51, 52, 53, 54, 55, 56, 57, 58, 59]], [[60, 61, 62, 63, 64, 65, 66, 67, 68, 69], [70, 71, 72, 73, 74, 75, 76, 77, 78, 79]], [[80, 81, 82, 83, 84, 85, 86, 87, 88, 89], [90, 91, 92, 93, 94, 95, 96, 97, 98, 99]]]

#what's going on here!?

```

## Memory pointers in arrays
```
c = a[0]
>>> c
array([[ 0,  1,  2,  3,  4,  5,  6,  7,  8,  9],
       [10, 11, 12, 13, 14, 15, 16, 17, 18, 19]])
>>> c[0][0] = -9999
>>> a
array([[[-9999,     1,     2,     3,     4,     5,     6,     7,     8,
             9],
        [   10,    11,    12,    13,    14,    15,    16,    17,    18,
            19]],

       [[   20,    21,    22,    23,    24,    25,    26,    27,    28,
            29],
        [   30,    31,    32,    33,    34,    35,    36,    37,    38,
            39]],

       [[   40,    41,    42,    43,    44,    45,    46,    47,    48,
            49],
        [   50,    51,    52,    53,    54,    55,    56,    57,    58,
            59]],

       [[   60,    61,    62,    63,    64,    65,    66,    67,    68,
            69],
        [   70,    71,    72,    73,    74,    75,    76,    77,    78,
            79]],

       [[   80,    81,    82,    83,    84,    85,    86,    87,    88,
            89],
        [   90,    91,    92,    93,    94,    95,    96,    97,    98,
            99]]])
```

## Consider data type and value assignment
```
>>> a.dtype
dtype('int64')
>>> a[0,0,0] = 0.0123
>>> a
array([[[ 0,  1,  2,  3,  4,  5,  6,  7,  8,  9],
        [10, 11, 12, 13, 14, 15, 16, 17, 18, 19]],

       [[20, 21, 22, 23, 24, 25, 26, 27, 28, 29],
        [30, 31, 32, 33, 34, 35, 36, 37, 38, 39]],

       [[40, 41, 42, 43, 44, 45, 46, 47, 48, 49],
        [50, 51, 52, 53, 54, 55, 56, 57, 58, 59]],

       [[60, 61, 62, 63, 64, 65, 66, 67, 68, 69],
        [70, 71, 72, 73, 74, 75, 76, 77, 78, 79]],

       [[80, 81, 82, 83, 84, 85, 86, 87, 88, 89],
        [90, 91, 92, 93, 94, 95, 96, 97, 98, 99]]])
        
```
