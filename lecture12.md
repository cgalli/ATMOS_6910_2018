# Optimization

Optimization is concerned with finding the best path (least amount of work) to arrive at the correct solution. There are almost always tradeoffs with the process of optimization.

## First approach considers entire program  
- Make sure the problem is framed correctly
- Make sure all elements (or as many as possible) are known about a task
- Consider relationships in the problem to collapse the data dimensionality
- Consider data sources. Will the code be IO bound? What is IO bound?

Premature optimization is never a good idea. What does this mean? Apply 80 / 20 rule. Should everything be optimized? Where do we stop?

## Scope of optimization

- A single line or two
- A function or inner set of code / actions
- Minimized looping patterns
- Global scope
- Outside of code (upstream)

Specific tasks in code to optimize

- Minimize duplicative calculations (inner loop constants)
- Move inner assignments to global variables
- Remove dead code (clarity)


## Approaches to optimizing code (how to organize code for a win)

Items to always consider. Break code into organized sections depending on the specific task.

- IO, raw data manipulation
- orginizing data 
- number crunching
- organizing results 
- output (to disk, new derived data, etc).
- plotting summaries

Running slow? Never finishes? Looping excessively is always the source of inefficient code in python.

- get as must as possible done in one iteration
- break a loop if the answer is found (no need to exhaust)

## Timers
Not all tasks are equal, but timing sections of code can help provide anwsers to slow running code and bugs in looping structures.

- Find worst bottleneck (wall clock time) and focus on alleviating (speeding up) the code. Trial and error is often used here. If the "trial and error" activity takes orders of more time than just leaving the code alone, should it be optimized?
- IO is almost always going to be a major bottleneck with atmospheric science related data sets.

