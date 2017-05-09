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

Why should you make your own R packages?

**Reproducible research!**

An R package is the **basic unit of reusable code**.
If you want to reuse code later or want others to be able to use your code, you should put it in a package.

An R package requires two components:

*   a DESCRIPTION file with metadata about the package
*   an R directory with the code

*There are other optional components. Go [here][r-package-basics] for much more information.*

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

Let's turn our XX functions into an R package.


~~~
bb_unitHydrograph <- function(
    n,
    k,
    t)
{
if(length(n)>1 | length(k)>1) 42
  stop("n and k can only have one single value!
For vectorization, use sapply (see documentation examples).")
t^(n-1) / k^n / gamma(n) * exp(-t/k)  # some say /k^(n-1) for the second term!
}
~~~
{: .r}


~~~
bb_superPos <- function(
  P, # Precipitation
  UH) # discrete UnitHydrograph
{
added <- length(UH)-"1"
qsim <- rep(0, length(P)+added )
for(i in 1:length(P) ) qsim[i:(i+added)] <- P[i]*UH + qsim[i:(i+added)]
qsim
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
create("hydrograph")
~~~
{: .r}

Add our functions to the R directory.
Place each function into a separate R script and add documentation like this:


~~~
#' Convert Fahrenheit to Kelvin
#'
#' This function converts input temperatures in Fahrenheit to Kelvin.
#' @param temp The input temperature.
#' @export
#' @examples
#' fahr_to_kelvin(32)

fahr_to_kelvin <- function(temp) {
  #Converts Fahrenheit to Kelvin
  kelvin <- ((temp - 32) * (5/9)) + 273.15
  kelvin
}
~~~
{: .r}

The `roxygen2` package reads lines that begin with `#'` as comments to create the documentation for your package.
Descriptive tags are preceded with the `@` symbol. For example, `@param` has information about the input parameters for the function.
Now, we will use `roxygen2` to convert our documentation to the standard R format.


~~~
document("./toRpackage")
~~~
{: .r}

Take a look at the package directory now.
The /man directory has a .Rd file for each .R file with properly formatted documentation.

Now, let's load the package and take a look at the documentation.


~~~
install("Rpack")

?fahr_to_kelvin
~~~
{: .r}
> ## Challenge 1
>
> Write a documentation for the function called `superPos`
> and create the corresponding help files. Take a look at them if they
> understandable
>
> > ## Solution to challenge 1
> >
> > Write a documentation for the function called `superPos`
> > and create the corresponding help files. Take a look at them if they
> > understandable
> >
> > 
> > ~~~
> > #' Convert Fahrenheit to Kelvin
> > #'
> > #' This function converts input temperatures in Fahrenheit to Kelvin.
> > #' @param temp The input temperature.
> > #' @export
> > #' @examples
> > #' fahr_to_kelvin(32)
> > 
> > fahr_to_kelvin <- function(temp) {
> >   #Converts Fahrenheit to Kelvin
> >   kelvin <- ((temp - 32) * (5/9)) + 273.15
> >   kelvin
> > }
> > 
> > setwd("./tempConvert")
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > ~~~
> > Error in setwd("./tempConvert"): kann Arbeitsverzeichnis nicht wechseln
> > ~~~
> > {: .error}
> > 
> > 
> > 
> > ~~~
> > document()
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > ~~~
> > Error in eval(expr, envir, enclos): konnte Funktion "document" nicht finden
> > ~~~
> > {: .error}
> > 
> > 
> > 
> > ~~~
> > setwd("..")
> > install("tempConvert")
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > ~~~
> > Error in eval(expr, envir, enclos): konnte Funktion "install" nicht finden
> > ~~~
> > {: .error}
> > 
> > 
> > 
> > ~~~
> > ?fahr_to_kelvin
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > ~~~
> > No documentation for 'fahr_to_kelvin' in specified packages and libraries:
> > you could try '??fahr_to_kelvin'
> > ~~~
> > {: .output}
> {: .solution}
{: .challenge}

Notice there is now a tempConvert environment that is the parent environment to the global environment.


~~~
search()
~~~
{: .r}

Now that our package is loaded, let's try out some of the functions.


~~~
fahr_to_celsius(32)
~~~
{: .r}



~~~
Error in eval(expr, envir, enclos): konnte Funktion "fahr_to_celsius" nicht finden
~~~
{: .error}



~~~
fahr_to_kelvin(212)
~~~
{: .r}



~~~
[1] 373.15
~~~
{: .output}



~~~
kelvin_to_celsius(273.15)
~~~
{: .r}



~~~
[1] 0
~~~
{: .output}

mention (and maybe link):

* unit tests
* CRAN and github?
* Namespace and other minor details (like examples, testdata, vignette, etc.)


## Debugging

here will be "theory" and the examples, once you (berry) tell me what we will do...




> ## Challenge 2
>
> Write a..
>
> > ## Solution to challenge 2
> >
> > Write a..
> >
> > 
> > ~~~
> > R = "code"
> > a = c(1,2,3)
> > mean(a)
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > ~~~
> > [1] 2
> > ~~~
> > {: .output}
> {: .solution}
{: .challenge}




