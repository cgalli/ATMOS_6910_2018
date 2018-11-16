# Debugging

Debugging computer programs is the process of identifying flaws in code that prevent the program from arriving at the intended outcome. Bugs in programs often result in execution symptoms as one of the following:

- Code won't compile
- Code "crashes" and does not return why (memory issues, linked libraries in c or fortran)
- Code "crashes" with exception noted to standard out (STDOUT)
- Code runs, but gives "warning" about something to STDOUT
- Code runs and never finishes
- Code runs fine with no errors and you get results. (wait! why is this on the bug category list?)

Finding logical bugs in code is extremely tricky. A program might run with no errors, and yield results that, at first glance, appear to be reasonable. It is important to verify the results of code every step through the process of writing it.

When writing discrete functions that operate on specific inputs, the usage of unit tests are often employed. A unit test provides an independent approach to verifying a function does in fact result in the same answer after code has been modified. The test already knows the correct answer of the returned values from specific inputs.

## First: a tip to remember

Never write an entire program from start to finish without running it incrementally as code is written.
Never write an entire program from start to finish without running it incrementally as code is written. 
Never write an entire program from start to finish without running it incrementally as code is written.

Just like a general contractor would never finish building a structure without first checking the foundation was built correctly and was structurally sound...

... so should a developer verify existing code is sound before adding more "weight" onto the program. Because most code incrementally relies on the previous executed lines, not knowing if the prior state is sound will almost always result in wasted time and frustration.

## Common debugging approaches
Nearly all programs need to be debugged while they are written, and certainly after they are completed. A positive attitude is essential to tackling bugs in programs. With a little logic, it can be quite simple to "zero in" on the offending line or section of code.

Here are some common approaches to tracking down bugs:

- Interactive. Users step through each line of code, or segments of code until halting markers are reached. 
- Print statements (often called tracing). Print statements are written to the STDOUT (screen) as the applications runs providing diagnostic information about the state and location of logical flows. 
- Examining core dumps (memory dumps) about the application state. This is a post-mortem technique, not often used in python, however.
- Halving, or fencing. This algorithm is akin to finding a name in a phone book. For example, a directory with one million entries sorted alphabetically means we can find if a match exists by halfing the result after comparing if the name is to the left or right of the middle point. It only takes 20 iterations to find where the name would fit.



## Difficult debugging situations

Not all debugging is easy or straight forward. For example, server code often run as detached processes in the background and exceptions do not flow to STDOUT. In fact, all that is sometimes known is if the process is running.

Running applications in parallel using multiprocessing techniques are notoriously challenging to debug. 

Networking issues are equally difficult, especially in asynchronous coding patterns, which is a style increasing in popularity at the moment. 


## Stack traces in python

Lucky for us, python has some nice trace information for when an error occurs. There are many types of exceptions that python can notify reasonable information about. [See the docs here](https://docs.python.org/2/library/exceptions.html). For example, consider these:

```
Traceback (most recent call last):
  File "./test.py", line 2, in <module>
    import times
ImportError: No module named times
```

```
Traceback (most recent call last):
  File "./test.py", line 4, in <module>
    a = a + 1
NameError: name 'a' is not defined
```

```
>>> dates = {}
>>> a = dates['january']
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
KeyError: 'january'
```

## Some examples to consider

Error in a function

```
import numpy as np

def divider(a,b):
  b = (b * 10).astype(int)
  return a / b

arr_a = np.random.random(100)
arr_b = np.random.random(100)

result = divider(arr_a, arr_b)
answer = min(result.mean(), 10.)
```

Running it we get this:

```
__main__:3: RuntimeWarning: divide by zero encountered in divide
```

Because this will return a divide by zero error, how do we debug this? Running this interactively does not allow us to inspect the function, because we drop back to the global scope and all variable states are lost from the inner function.

## Catching errors during runtime

Most languages allow for exception catching. In python, we use the try: except: pattern. For example, we might attempt to catch a divide by zero error like this:

```
a = 1
b = 0

try:
  a / b
except:
  print 'looks like a divide by zero situation', a, b
```

And now what about this?

```
a = 1
b = 0

try:
  a = a * c
  a / b
except:
  print 'looks like a divide by zero situation', a, b
```

We can target the type of exception specifically, and act accordingly when necessary like this:

```
a = 1
b = 0

try:
  a = a * c
  a / b
except ZeroDivisionError:
  print 'looks like a divide by zero situation', a, b
  # do something intelligent here
except NameError:
  print 'oops, we have a name error?!'
finally:
  print 'end of try block'
```

A strangely common bug is to wrap an entire section of code, or even the entire program in one "try:" block of code and fail without doing anything, such as this:

```
def get_new_value(v):
  v -= 1
  return v**.9

v = 100
i = 0
while v > 0:
  try:
    v = get_new_value(v)
  except:
    pass
  i += 1
  print v

print i, 'iterations'

```
 It's tempting to just wrap a try: around something that feels problematic and move onto finishing the code! 
 
 Let's debug a simple script [here](./example14.py).
 
