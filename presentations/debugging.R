# SWC R Course 2018-04-25
# debugging session part by Berry Boessenkool, berry-b@gmx.de
# https://github.com/swc-bb/r-workshop   -> presentations/debugging.R


# Outline ----
# intro, references
# overview of useful functions
# exercise with actual code and data (from hydrology)


# Intro ----

# "Debugging" refers to tracking down errors in the code. More specifically, 
# it may involve several tools that allow the execution of code step-by-step, 
# and inspecting and modifying intermediate results.
# When R is in debug mode, the prompt changes to "Browse[1]>". All R-commands still work.
# special debug commands:
# n (or Enter): execute next line
# c: leave debug mode and continue execution of script
# Q: leave debug mode and terminate script


# References (best-of selection) ----

# R. Peng (2002): Interactive Debugging Tools in R
# D. Murdoch (2010): Debugging in R
# H. Wickham (2015): Advanced R: debugging
# P. Werner Blog Post (2013)
browseURL("http://www.biostat.jhsph.edu/~rpeng/docs/R-debug-tools.pdf")
browseURL("http://www.stats.uwo.ca/faculty/murdoch/software/debuggingR")
browseURL("http://adv-r.had.co.nz/Exceptions-Debugging.html")
browseURL("https://www.r-bloggers.com/tracking-down-errors-in-r")



# Useful functions ----
# browser()                go into function environment: n, s, f, c, Q
# debug(funct)             toggle linewise function execution
# undebug(funct)           after calling and fixing function
# options(error=recover)   open interactive session where error occurred
# options(warn=2)          Convert warnings to error. default 0
# source("projectFuns.R")  execute complete file
# traceback()              find error source in sequence of function calls


# Side note: make your own functions easier to debug with informative messages:
if(length(input)>1) stop("input length must be 1, not ", length(input))
# stop:    Interrupts function execution and gives error
# warning: continues but gives warning
# message: to inform instead of worrying the user


#Let's assume you have some complex code ..
complex_stuff <- function(a, b)
{
  # pseudo-complex code:
  if (a > 0)   v <-  1
  if (a < 0)   v <- -1
  z <- b - v
}

#...which throws an error under certain circumstances:
complex_stuff(1, 6) #works
complex_stuff(0, 3) #fails

# We now have three main options to understand what is going on by using the 
# debugging mode
# 1. Enter debugging mode when on entering the function:
  debug(complex_stuff)
  complex_stuff(0, 3) # invokes debug mode. Execute stepwise with "n" or 
  # buttons atop console. Quit with "c" or "Q"
  # set back to normal behaviour:
  undebug(complex_stuff)
  complex_stuff(0, 3) # as before

# 2. We have no clue where the error is generated and want to enter debug mode
  # exactly where it happens:
  options(error=recover)
  complex_stuff(0, 3) # as before
  options(error=NULL) # back to normal error handling
  # or: Rstudio - Debug - On Error - Error Inspector for the nice  Rstudio option!
  
# 3. We already have an idea where the error might be and want to enter 
  # debugging mode exactly there:
  complex_stuff <- function(a, b)
  {
  # pseudo-complex code:
  if (a > 0)   v <-  1
  if (a < 0)   v <- -1
  browser()  # we expect something fishy here and want to check at this point
  # (in RStudio, we could also set a breakpoint by clicking left of the line numbers)
  z <- b - v
  }
  complex_stuff(0, 3) # invokes debug mode at the desired line. Same commands as in 1.
  
  

# Debugging exercise ----

# In the script "presentations/lsc_functions.R", two data.frames (calib and valid)
# and 5 functions ("lsc", "nse", "rmse", "superPos", "unitHydrograph") are created.
# Run the entire script with the appropriate R command.

# YOUR CODE HERE
# Solutions are at the end of this script. Remember: learn by doing, not looking.


# Now run
lsc(calib$P, calib$Q, area=1.6)
# and you will encounter some errors intentionally built into the functions.
# Correct those (in the script) using the techniques outlined above.
# BONUS: log each change with git with useful (!) commit messages

# You want the result to look like
browseURL("https://github.com/brry/course/blob/master/externalfig/lsc.png")

# Bonus: also get rid of the 50 or more warnings



# Solutions scroll ----

# Some scrolling left to prevent accidentally seeing the solutions
# Or click the last item in the outline!



















# Exercise solutions ----

source("presentations/lsc_functions.R")
lsc(calib$P, calib$Q, area=1.6)

# stupid error you can easily remove  ->  traceback 
# ->  find location of error  ->  lsc#181  ->  just comment it out

# harder to find but still stupid  ->  traceback  ->  nse#33  ->  ditto

# Error in plot: need finite 'ylim' value
# ->  debug/browser/options(error=recover)  ->  lsc#214  ->  NAs in Q
# ->  range(Q, na.rm=TRUE  ->  also in other applicable locations

# There were 50 or more warnings  ->  come from rmse being called in optimization 
# add argument quietNA (or similar) to lsc that is passed to rmse in lsc#187
