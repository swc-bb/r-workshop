# SWC R Course 2018-04-25
# Rstudio + git session by Berry Boessenkool, berry-b@gmx.de
# https://github.com/swc-bb/r-workshop   -> presentations/rstudiogit.R

# Outline ----

# Connect Rstudio to git
# Using Rstudio as git GUI
# - for loop -> lapply -> pblapply
# Share Rstudio tips and tricks


# Sections ----
# With 4 (or more) minuses or hashtags in a line, you get a section in Rstudio.
# Turn on the outline with CTRL + SHIFT + O   (or the topright button).
# Use it to make longer scripts well structured or fold code regions.



# __ 1. Rstudio and git ----

# Configure RStudio to use git ----

# RStudio - Tools - Global Options - Git/SVN
# If Git executable shows (none), click Browse and select the git executable installed on your system
# On a Mac, likely one of   /usr/bin/git,   /usr/local/bin/git,   /usr/local/git/bin/git
# On Windows, git.exe will likely be somewhere in Program Files


# clone git repository ----

# either:
# if you don't already have the repository from the git session
# Rstudio - File - New Project - Version Control - git
# Use the URL   https://github.com/swc-bb/r-workshop
# or:
# Rstudio - File - New Project - Existing directory  
# if you already have the folder



# __ 2. Using Rstudio as a git GUI ----

# Make changes in the script below e.g. by solving the exercises
# and commit those piece-wise with useful (!) commit messages


# Needed packages + data ----

# small helper function to conditionally install packages:
instifneeded <- function(pack) if(!requireNamespace(pack, quietly=TRUE)) 
                               install.packages(pack)
instifneeded("nycflights13")
instifneeded("pbapply")
instifneeded("berryFunctions")

library(pbapply)

# Reduced dataset used as example 

flights <- as.data.frame(nycflights13::flights)[,c(1:9,11,15:18)] # nonchar columns
# How many rows we'll examine:
n <- 1e5


# for loops suck on old R versions, and here's why ----

# ..ex1: for loop ----
# write a for loop to fill the first 10 elements of "means_forloop",
# each with the average of the respective row of "flights".
# Remember that a single row of a df is still a data.frame, i.e. a list, 
# which needs to be vectorized for the "mean" function.
# Remember also to cover for NAs.
# If this works, measure the computing time to do this for the first "n" rows.
# Note: The solutions are at the end of this document, in case you get completely stuck.
# Otherwise: learning by experimenting is very effective. Peeking at solutions is not.

means_forloop <- NA
for(i in 1:10) means_forloop[i] <- 7777 # Your code here


# This grows a vector, requiring it to be rewritten to memory in every step!
# In older R versions, this will take more than a minute!
# Since about 2017, R has grown smart about this. If you use older versions,
# initializing the vector with the right length (and data type) speeds it up:
means_for_loop <- numeric(n)
system.time(
  for(i in 1:n) means_for_loop[i] <- mean(unlist(flights[i,]), na.rm=TRUE)
  )
# Takes about 15 seconds on my computer
# Search keyword for this is pre-allocation, by the way.



# Applying functions ----

# Real work can often be done elegantly in a reusable function:
# ..ex2: write a function ----
# Fill the function framework below with code that computes the mean
# of a given "row" from a given data.frame "object" (default if omitted: flights)

myrowmean <- function(row, object=flights)
  {
  # Your code here
  }

# Test your function  
flights[1,]
myrowmean(1) # should be 564.3571



# Applying functions to lists (lapply) or vectors is quite easy. 
# If the result is always regular, you can simplify it with sapply.
means_apply <- sapply(1:n, FUN=myrowmean)
# also computes about 15 secs


# Digression: progress bars and parallel computing ----

# Want a progress bar with estimated remaining time? the pbapply package does that:
means_apply_pb <- pbsapply(1:n, FUN=myrowmean)

# Want to parallize that (keeping the progress bar)? Easy as cake on LINUX:
means_apply_parallel <- pbsapply(1:n, myrowmean, cl=8) # on LINUX

# Needs a bit more preparation on Windows:
library(parallel) # comes installed with R, cannot be install.packages()ed
cl <- makeCluster( detectCores()-1 )
clusterExport(cl, "flights")
means_apply_parallel <- pbsapply(1:n, myrowmean, cl=cl)
stopCluster(cl); rm(cl); gc()
# Runs 7 seconds instead of 15 on 3 cores
# Cluster creation overhead gets relatively smaller, the longer a single function call takes

# Can't remember that windows parallel code? Copy the output from
berryFunctions::parallelCode()



# Problem-specific optimal solution ----

# Use built-in or packaged code if possible!
# ..ex3: built-in solution ----
# There's a built-in function in base R to compute the means of rows.
# It only computes 0.03 secs instead of 15! Figure out which function it is.
# Test it on the first "n" rows of "flights" as well and compare the output.
# Why is the object.size so much larger?

means_builtin <- 7777 # Your code here



# __ 3. Rstudio tips and tricks ----

# General tips ----

# Work with Rstudio projects (sets wd, enables git, keeps script tabs)
# use script sectioning (see the top of this document)
# know tearable panes
# change some settings for reproducibility:
browseURL("https://github.com/brry/course#settings")

# Keyboard shortcuts ----

# See all with ALT+SHIFT+K  or at
browseURL("https://support.rstudio.com/hc/en-us/articles/200711853-Keyboard-Shortcuts")

# ALT + mouse for multiline cursor
# CTRL + SHIFT + 1 panel full view
# ALT + UP / DOWN move line of code
# CTRL + SHIFT + P rerun previous code region
# CTRL + SHIFT + S / ENTER source document
# CTRL + UP (in console) command history
# CTRL + SHIFT + O Document outline
# CTRL + SHIFT + C Comment/uncomment code blocks

# Your ideas ----

# What tricks or packages do you use commonly and can recommend to us?


# More tips at e.g.:
browseURL("https://rviews.rstudio.com/2016/11/11/easy-tricks-you-mightve-missed")
browseURL("https://rviews.rstudio.com/categories/tips-and-tricks")



# __4. Exercise solutions ----

# ex 1: for loop ----
means_forloop <- NA
system.time(
  for(i in 1:n) means_forloop[i] <- mean(unlist(flights[i,]), na.rm=TRUE)
)

# ex 2: rowmeans function ----
myrowmean <- function(row, object=flights) mean(unlist(object[row,]), na.rm=TRUE)
# Curly braces can be left away if the content is a single line R command
# some people suggest to always use them for consistency

# ex 3: built-in solution ----
means_builtin <- rowMeans(flights[1:n,], na.rm=TRUE) # 0.03 secs (instead of 15!)
object.size(means_apply)
object.size(means_builtin)
means_builtin_noname <- unname(means_builtin)
all.equal(means_apply, means_builtin_noname)

