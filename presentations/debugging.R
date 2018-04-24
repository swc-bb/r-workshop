# SWC R Course 2018-04-25
# debugging session part by Berry Boessenkool, berry-b@gmx.de
# https://github.com/swc-bb/r-workshop   -> presentations/debugging.R


# Outline ----
# references
# overview of useful functions
# exercise with actual code and data (from hydrology)



# Debugging references (best-of selection) ----
# R. Peng (2002): Interactive Debugging Tools in R
# D. Murdoch (2010): Debugging in R
# H. Wickham (2015): Advanced R: debugging
# P. Werner Blog Post (2013)
browseURL("http://www.biostat.jhsph.edu/~rpeng/docs/R-debug-tools.pdf")
browseURL("http://www.stats.uwo.ca/faculty/murdoch/software/debuggingR")
browseURL("http://adv-r.had.co.nz/Exceptions-Debugging.html")
browseURL("https://www.r-bloggers.com/tracking-down-errors-in-r")



# Debugging: useful functions ----
# source("projectFuns.R")  execute complete file
# traceback()              find error source in sequence of function calls
# options(warn=2)          Convert warnings to error. default 0
# browser()                go into function environment: n, s, f, c, Q
# options(error=recover)   open interactive session where error occurred
# debug(funct)             toggle linewise function execution
# undebug(funct)           after calling and fixing function


# Side note: make your own functions easier to debug with informative messages:
if(length(input)>1) stop("input length must be 1, not ", length(input))
# stop:    Interrupts function execution and gives error
# warning: continues but gives warning
# message: to inform instead of worry the user



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


# Note: lsc is available in the package berryFunctions.
# Currently, the CRAN version doesn't handle NAs, but the next release (1.18) will.
# Until then, use the development version from github (Yay git!!):
source("https://install-github.me/brry/berryFunctions")
berryFunctions::lsc(calib$P, calib$Q, area=1.6)


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
# ->  debug/browser/options(error=recover)  ->  lsc#213  ->  NAs in Q
# ->  range(Q, na.rm=TRUE  ->  also in other applicable locations

# There were 50 or more warnings  ->  come from rmse being called in optimization 
# add argument quietNA (or similar) to lsc that is passed to rmse in lsc#187
