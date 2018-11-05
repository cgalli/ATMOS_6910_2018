# Functions and code design

**There is no one right way to deisgn software and write code.** And because there is rarely one right way to solve a problem or task, the design of programs take many shapes. The language used in developing programs will often influence the style used.

When we refer to desciptors like "good" and "bad" ways of writing code, what we often mean is how efficient, or simple, or readable is the code.

There are plenty of books, blogs, evangelists, tweeters, and more who proclaim The proper way to design software. All of them are right, and all of them are wrong.

### Notable books and references
- [The Elements of Programming Style. 1974](https://en.wikipedia.org/wiki/The_Elements_of_Programming_Style). Note the large DO-NOT_DO-THIS list.
- [Clean Code Advice by Martin Fowler](https://martinfowler.com/tags/clean%20code.html)
- [Clean Code: A Handbook of Agile Software Craftsmanship. 2008](https://www.oreilly.com/library/view/clean-code/9780136083238/)
- [WikiBook on Code Styles](https://en.wikibooks.org/wiki/Computer_Programming/Coding_Style)


In the continuum of code styles and techniques, a few stand out, mostly because they are en vogue at the moment (and some just make good practical sense).

- procedural
- object oriented
- functional

We've already discussed details types of code, such as compiled vs interpreted. Taking python as a means to illustrate coding styles, take a simple task of adding two very large numbers together:

**Procedural approach**
```
#!/usr/bin/python

number_1 = 1.23456789e100
number_2 = 2.34567890e101

total = number_1 + number_2
```

**Functional approach**
```
#!/usr/bin/python

def add_very_large_numbers(a,b):
  return a + b

def main(number_1, number_2):
  total = add_very_large_numbers(number_1, number_2)
  return total

if __name__ == "__main__":
  number_1 = 1.23456789e100
  number_2 = 2.34567890e101
  
  #call main program
  total = main(number_1, number_2)
  
  print('big number is: %s' % total)
  exit(0)
```

**Object oriented approach**
```
#!/usr/bin/python

class NumberCruncher(object):
  '''
  Class object to crunch some really big numbers. 
  In fact, these numbers are HUGE. Much bigger than most other numbers,
    which is why we have a special class to handle this, plus it's good
    coding practice to break out segments of code into discrete functions
    to make it clearer to read and use.
  '''
  
  self.total = None
  
  def init(self, number_1=None, number_2=None):
    self.number_1 = number_1
    self.number_2 = number_2
    
  def add_very_large_numbers(self):
    if self.is_a_number(self.number_1) and self.is_a_number(self.number_2):
      self.total = self.number_1 + self.number_2
    else:
      self.total = None
      
  def is_a_number(self, number_to_check):
    number_is_good = False
    
    try:
      float(number_to_check)
      number_is_good = True
    except:
      #not a good number
      pass
    if number_is_good:  
      return True
    else:
      return False
      
  def get_total(self):
    return self.total
    
    
def perform_addition(number_1, number_2):
  #create an instance of the number cruncher
  my_number_cruncher = NumberCruncher(number_1, number_2)
  
  #call addition method
  my_number_cruncher.add_very_large_numbers()
  
  #get total
  total = my_number_cruncher.get_total()
  
  return total

if __name__ == "__main__":
  number_1 = 1.23456789e100
  number_2 = 2.34567890e101
  
  #call main program
  total = perform_addition(number_1, number_2)
  
  print('big number is: %s' % total)
  exit(0)

```

## A solid philosophy
You will write code ...

to learn how to write code ...

to throw away that code ...

to learn how to write code ...

to write code that works and is useful


The reason we sift through mountains of data is to find the essence of that data or its relationships to other data. Making sense of it can be confusing. Communicating what that data means in the context of your research can feel daunting.

## This for that
The practical answer when approaching design is always somehwere in the middle of spectrum:

- Many separate functions vs. one long program
- Separate files for individual functions vs. single file
- Reusable code as abstracted functions vs. duplicative code in-line
- Elegant and compressed structure of execution vs. verbose and explicit
- Comments and docs imbedded vs. no comments or docs

... and so on. 

The goal is almost always to accomplish a task efficiently and practical without extra "junk" code or structure and organization. 

