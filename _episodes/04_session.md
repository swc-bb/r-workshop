---
title: "Package creation and debugging"
teaching: 60
exercises: 30
questions:
- "How do I collect my code together so I can reuse it and share it?"
- "How do I make my own packages?"
objectives:
- "Describe the required structure of R packages."
- "Create the required structure of a simple R package."
- "Write documentation comments that can be automatically compiled to R's native help and documentation format."

keypoints:
- "A package is the basic unit of reusability in R."
- "Every package must have a DESCRIPTION file and an R directory containing code."
---


## Create an R package

### Why should you make your own R packages?

There are many advantages, naming them here in an unordered list:

*   Collect your own functions in one place
*   Combine functions and documentation in the right way
*   Share code with others
*   Make your research reproducible !

If you then want to publish your package, there are two main ways: CRAN (which is the official R package service) and github (rather for testing and developer versions).
Both have advantages and disadvantages. The process to publish in CRAN takes much more time but has also several quality checks build in within this procedure.
At github everyone can just upload what he thinks is right, so one has to be careful.
Its advantage is, that code can be shared quick and easily. If privacy (licensing) is an issue, please consider the fact, 
that github is open to everyone. Alternatives could be bitbucket but there are many.

An R package requires two components:

*   a DESCRIPTION file with metadata about the package
*   an R directory with the code

Optional components are:
*   documentation
*   vignettes
*   tests
*   namespace
*   data

*Go [here][r-package-basics] for much more information.*

[r-package-basics]: http://adv-r.had.co.nz/Package-basics.html

### DESCRIPTION file

~~~
Package: Package name
Title: Brief package description
Description: Longer package description
Version: Version number(major.minor.patch)
Author: Name and email of package creator
Maintainer: Name and email of package maintainer (who to contact with issues)
License: Abbreviation for an open source license
~~~
{: .source}

The package name can only contain letters and numbers and has to start with a letter.

### .R files

Functions don't all have to be in one file or each in separate files.
How you organize them is up to you.
Suggestion: organize in a logical manner so that you know which file holds which functions.

### Making your first R package

We'll be using custom slides for this lesson.

* [PDF version](https://github.com/swc-bb/2017-05-17-r-workshop/raw/gh-pages/_episodes/SWC_packages_debugging_BM.pdf)
* [Presentation version](https://github.com/swc-bb/2017-05-17-r-workshop/raw/gh-pages/_episodes/SWC_packages_debugging_BM_pres.pdf)
* [Rnw source code](https://github.com/swc-bb/2017-05-17-r-workshop/blob/gh-pages/_episodes/SWC_packages_debugging_BM.Rnw)

Let's start and turn our these functions into an R package.


~~~
# Nash-Sutclife Efficiency
nse <- function(obs, sim)
{
if(!(is.vector(obs) & is.vector(sim))) stop("Input is not a vector.")
if(length(obs) != length(sim)) stop("Vectors are not of equal length.")
if(any(is.na(obs)|is.na(sim)))
     {
     Na <- which(is.na(obs)|is.na(sim))
     warning(length(Na), " NAs were omitted from ", length(obs), " data points.")
     obs <- obs[-Na] ; sim <- sim[-Na]
     } # end if NA
1 - ( sum((obs - sim)^2) / sum((obs - mean(obs))^2) )
}
~~~
{: .r}


~~~
# Root mean square error
rmse <- function(a, b, quiet=FALSE)
{
if(!(is.vector(a) & is.vector(b))) stop("input is not vectors")
if(length(a) != length(b)) stop("vectors not of equal length")
if(any(is.na(a)|is.na(b)))
   {
   Na <- which(is.na(a)|is.na(b))
   if(!quiet) warning(length(Na), " NAs were omitted from ", length(a), " data points.")
   a <- a[-Na] ; b <- b[-Na]
   } # end if NA
sqrt( sum((a-b)^2)/length(b) )
}
~~~
{: .r}

We will use the `devtools` and `roxygen2` packages, which make creating packages in R relatively simple.
First, install the `devtools` package, which will allow you to install the `roxygen2` package from GitHub ([code][]).

[code]: https://github.com/klutometis/roxygen


~~~
install.packages("devtools")
library("devtools")
install_github("klutometis/roxygen")
library("roxygen2")
~~~
{: .r}

Set your working directory, and then use the `create` function to start making your package.
Keep the name simple and unique.
  - package_to_convert_temperatures_between_kelvin_fahrenheit_and_celsius (BAD)
  - tempConvert (GOOD)


~~~
setwd(parentDirectory)
create("lsc")
~~~
{: .r}

Add our functions to the R directory.
Place each function into a separate R script and add documentation like this:


~~~
#' Nash-Sutcliffe efficiency
#'
#' Nash-Sutcliffe efficiency as a measure of goodness of fit.
#' Removes incomplete observations with a warning.
#'
#' @param obs Numerical vector with observed values
#' @param sim Simulated values (Numerical vector with the same length as \code{obs})
#'
#' @return Single numerical value
#' @export
#' @seealso \code{\link{rmse}}
#' @references based on eval.NSeff  in RHydro Package
#'             \url{https://r-forge.r-project.org/R/?group_id=411}
#' @examples
#'
#' set.seed(123)
#' x <- rnorm(20)
#' y <- 2*x + rnorm(20)
#' plot(x,y)
#' x[2:4] <- NA
#'
#' nse(x,y)
#'
nse <- function(obs, sim)
{
if(!(is.vector(obs) & is.vector(sim))) stop("Input is not a vector.")
if(length(obs) != length(sim)) stop("Vectors are not of equal length.")
if(any(is.na(obs)|is.na(sim)))
     {
     Na <- which(is.na(obs)|is.na(sim))
     warning(length(Na), " NAs were omitted from ", length(obs), " data points.")
     obs <- obs[-Na] ; sim <- sim[-Na]
     } # end if NA
1 - ( sum((obs - sim)^2) / sum((obs - mean(obs))^2) )
}
~~~
{: .r}

For Rstudio: You can open the file, 
put the cursor inside the function and press CTRL + ALT + SHIFT + R
(or click on Code - Insert Roxygen Skeleton).

The `roxygen2` package reads lines that begin with `#'` as comments to create the documentation for your package.
Descriptive tags are preceded with the `@` symbol. For example, `@param` has information about the input parameters for the function.
Now, we will use `roxygen2` to convert our documentation to the standard R format.


~~~
document("./lsc")
~~~
{: .r}

Take a look at the package directory now.
The /man directory has a .Rd file for each .R file with properly formatted documentation.

Now, let's load the package and take a look at the documentation.


~~~
install("lsc")

?nse
~~~
{: .r}
> ## Challenge 1
>
> Write a documentation for the function called `rmse`
> and create the corresponding help files. Take a look at them if they
> understandable
>
> > ## Solution to challenge 1
> >
> > Write a documentation for the function called `rmse`
> > and create the corresponding help files. Take a look at them if they
> > understandable
> >
> > 
> > ~~~
> > #' Root Mean Square Error
> > #' 
> > #' RMSE as a measure of goodness of fit.
> > #' Removes incomplete observations with a warning.
> > #'
> > #' @param a,b   Numerical vectors both of the same length
> > #' @param quiet Logical: Suppress NA omission warning? DEFAULT: FALSE
> > #'
> > #' @return Single numerical value
> > #' @export
> > #' @seealso \code{\link{nse}}
> > #' @examples
> > #'
> > #' set.seed(123)
> > #' x <- rnorm(20)
> > #' y <- 2*x + rnorm(20)
> > #' plot(x,y)
> > #' x[2:4] <- NA
> > #' 
> > #' rmse(x,y)
> > #' 
> > rmse <- function(a, b, quiet=FALSE)
> > {
> > if(!(is.vector(a) & is.vector(b))) stop("input is not vectors")
> > if(length(a) != length(b)) stop("vectors not of equal length")
> > if(any(is.na(a)|is.na(b)))
> >    {
> >    Na <- which(is.na(a)|is.na(b))
> >    if(!quiet) warning(length(Na), " NAs were omitted from ", length(a), " data points.")
> >    a <- a[-Na] ; b <- b[-Na]
> >    } # end if NA
> > sqrt( sum((a-b)^2)/length(b) )
> > }
> > document(./lsc)
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > ~~~
> > Error in document(./lsc): could not find function "document"
> > ~~~
> > {: .error}
> > 
> > 
> > 
> > ~~~
> > install("lsc")
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > ~~~
> > Error in install("lsc"): could not find function "install"
> > ~~~
> > {: .error}
> > 
> > 
> > 
> > ~~~
> > ?rmse
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > ~~~
> > No documentation for 'rmse' in specified packages and libraries:
> > you could try '??rmse'
> > ~~~
> > {: .output}
> {: .solution}
{: .challenge}

Notice there is now a lcs environment that is the parent environment to the global environment.


~~~
search()
~~~
{: .r}

Now that our package is loaded, let's try out some of the functions.


~~~
nse(c(32,33), c(30,30))
~~~
{: .r}



~~~
[1] -25
~~~
{: .output}



~~~
rmse(c(32,33,20,33), c(31,32,19,32))
~~~
{: .r}



~~~
[1] 1
~~~
{: .output}

## Debugging

[R. Peng (2002): Interactive Debugging Tools in R](http://www.biostat.jhsph.edu/~rpeng/docs/R-debug-tools.pdf)  
[D. Murdoch (2010): Debugging in R](http://www.stats.uwo.ca/faculty/murdoch/software/debuggingR)  
[H. Wickham (2015): Advanced R: debugging](http://adv-r.had.co.nz/Exceptions-Debugging.html)  
[Example: Pete Werner Blog Post (2013)](https://www.r-bloggers.com/tracking-down-errors-in-r)

When writing functions, errors (named bugs by nature-avoiding computer scientists) are bound to occur.
Don't fret, it's normal and inevitable. 

Once you learn how to debug functions, you'll get faster at fixing them.

Modular programming is a very recommendable practice where each function has a specific task and its own documentation.
This leads to functions calling functions calling functions, and unhelpful errors like

~~~
error in obscure_function: missing value where TRUE/FALSE needed
~~~
{: .r}
To find out which function called which, `traceback()` is your best friend.
Rstudio will quite often (but not always!) show it by default.


When writing your own function, you can write `browser()` into it.
Or click in the sidebar in Rstudio, making a red dot appear (works fine usually, but not always!).

After sourcing the file with functions or reloading the package (CTRL+SHIFT+L), which redefines the function object in R, you can run the function again.
It will now pause execution at the browser location and let you wander around inside the function environment.
With `Q`, you exit the browsing environment, with `n` you go to the next line, with "f" finish the remainder of the function. 
Other special commands in brwosing mode are `s`, `where` and `c` (see the links above).

If you want this behaviour for every function (not just your own) for every error, set `options(error=recover)`.

If you want `browser` for each line of a function, just set it into debugging mode with `debug(function)`. 
Undo this after quitting the browser.

> ## Challenge 2
>
> Load your package and correct the functions until
> ```lsc(calib$P, calib$Q, area=1.6)``` returns the result below.
>
> > ## Solution to challenge 2
> >
> > Load your package and correct the functions until
> > ```lsc(calib$P, calib$Q, area=1.6)``` returns the result below.
> >
> > 
> > ~~~
> > " here has to go the solution plz...!! "
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > ~~~
> > [1] " here has to go the solution plz...!! "
> > ~~~
> > {: .output}
> {: .solution}
{: .challenge}




