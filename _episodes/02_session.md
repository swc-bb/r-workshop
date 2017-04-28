---
title: Functions and testing
teaching: 45
exercises: 45
questions:
- "Functions:"
- "How can I write a new function in R?"
- "Testing:"
- "How can I test my functions"
objectives:
- "Functions:"
- "Define a function that takes arguments."
- "Return a value from a function."
- "Test a function."
- "Set default values for function arguments."
- "Explain why we should divide programs into small, single-purpose functions."
- "Testing:"
- "Understanding the necessity for testing"
- "Making __testing__ more fun"
keypoints:
- "Functions:"
- "Use `function` to define a new function in R."
- "Use parameters to pass values into functions."
- "Load functions into programs using `source`."
- "Testing:"
- "write `tests` instead of `print` statements"

source: Rmd
---



In this lesson, we'll learn how to write a function so that we can repeat
several operations with a single command.

> ## What is a function?
>
> Functions gather a sequence of operations into a whole, preserving it for ongoing use. Functions provide:
>
> * a name we can remember and invoke it by
> * relief from the need to remember the individual operations
> * a defined set of inputs and expected outputs
> * rich connections to the larger programming environment
>
> As the basic building block of most programming languages, user-defined
> functions constitute "programming" as much as any single abstraction can. If
> you have written a function, you are a computer programmer.
{: .callout}

## Defining a function

Let's open a new R script file in the `functions/` directory and call it functions-lesson.R.


~~~
my_sum <- function(a, b) {
  the_sum <- a + b
  return(the_sum)
}
~~~
{: .r}

Let’s define a function fahr_to_kelvin that converts temperatures from Fahrenheit to Kelvin:


~~~
fahr_to_kelvin <- function(temp) {
  kelvin <- ((temp - 32) * (5 / 9)) + 273.15
  return(kelvin)
}
~~~
{: .r}

We define `fahr_to_kelvin` by assigning it to the output of `function`.  The
list of argument names are contained within parentheses.  Next, the
[body]({{ page.root }}/reference/#function-body) of the function--the statements that are
executed when it runs--is contained within curly braces (`{}`).  The statements
in the body are indented by two spaces.  This makes the code easier to read but
does not affect how the code operates.

When we call the function, the values we pass to it as arguments are assigned to those
variables so that we can use them inside the function.  Inside the function, we
use a [return statement]({{ page.root }}/reference/#return-statement) to send a result back
to whoever asked for it.

Let's try running our function.
Calling our own function is no different from calling any other function:


~~~
# freezing point of water
fahr_to_kelvin(32)
~~~
{: .r}



~~~
[1] 273.15
~~~
{: .output}


~~~
# boiling point of water
fahr_to_kelvin(212)
~~~
{: .r}



~~~
[1] 373.15
~~~
{: .output}

> ## Challenge 1
>
> Write a function called `kelvin_to_celsius` that takes a temperature in Kelvin
> and returns that temperature in Celsius
>
> Hint: To convert from Kelvin to Celsius you subtract 273.15
>
> > ## Solution to challenge 1
> >
> > Write a function called `kelvin_to_celsius` that takes a temperature in Kelvin
> > and returns that temperature in Celsius
> >
> > 
> > ~~~
> > kelvin_to_celsius <- function(temp) {
> >  celsius <- temp - 273.15
> >  return(celsius)
> > }
> > ~~~
> > {: .r}
> {: .solution}
{: .challenge}

> ## Challenge 2
>
> Write a function called `kelvin_to_celsius` that takes a temperature in Kelvin
> and returns that temperature in Celsius. In addtion, make sure that the function 
> does not produce values smaller than the absolute freeezing point and that we 
> process only numbers (not strings or factors).
>
> Hint: To convert from Kelvin to Celsius you subtract 273.15 (the absolute
> freezing point).
>
> > ## Solution to challenge 2
> >
> > Write a function called `kelvin_to_celsius` that takes a temperature in Kelvin
> > and returns that temperature in Celsius.In addtion, make sure that the function 
> > does not produce values smaller than the absolute freeezing point and that we 
> > process only numbers (not strings).
> >
> > 
> > ~~~
> > kelvin_to_celsius <- function(temp) {
> >   stopifnot(temp < 273,15, is.numeric(temp))
> >   celsius <- temp - 273.15
> >   return(celsius)
> > }
> > ~~~
> > {: .r}
> {: .solution}
{: .challenge}

## Combining functions
The real power of functions comes from mixing, matching and combining them
into ever-larger chunks to get the effect we want.

Let's define two functions that will convert temperature from Fahrenheit to
Kelvin, and Kelvin to Celsius:


~~~
fahr_to_kelvin <- function(temp) {
  kelvin <- ((temp - 32) * (5 / 9)) + 273.15
  return(kelvin)
}

kelvin_to_celsius <- function(temp) {
  celsius <- temp - 273.15
  return(celsius)
}
~~~
{: .r}

> ## Challenge 3
>
> Define the function to convert directly from Fahrenheit to Celsius,
> by reusing the two functions above (or using your own functions if you prefer).
>
>
> > ## Solution to challenge 3
> >
> > Define the function to convert directly from Fahrenheit to Celsius,
> > by reusing these two functions above
> >
> >
> > 
> > ~~~
> > fahr_to_celsius <- function(temp) {
> >   temp_k <- fahr_to_kelvin(temp)
> >   result <- kelvin_to_celsius(temp_k)
> >   return(result)
> > }
> > ~~~
> > {: .r}
> {: .solution}
{: .challenge}

> ## Tip
>
> R has some unique aspects that can be exploited when performing
> more complicated operations. We will not be writing anything that requires
> knowledge of these more advanced concepts. In the future when you are
> comfortable writing functions in R, you can learn more by reading the
> [R Language Manual][man] or this [chapter][] from
> [Advanced R Programming][adv-r] by Hadley Wickham. For context, R uses the
> terminology "environments" instead of frames.
{: .callout}

[man]: http://cran.r-project.org/doc/manuals/r-release/R-lang.html#Environment-objects
[chapter]: http://adv-r.had.co.nz/Environments.html
[adv-r]: http://adv-r.had.co.nz/


[roxygen2]: http://cran.r-project.org/web/packages/roxygen2/vignettes/rd.html
[testthat]: http://r-pkgs.had.co.nz/tests.html


### Testing and Documenting

Once we start putting things in functions so that we can re-use them, we need to start testing that those functions are working correctly.
To see how to do this, let's write a function to center a dataset around a particular value:


~~~
center <- function(data, desired) {
  new_data <- (data - mean(data)) + desired
  return(new_data)
}
~~~
{: .r}

We could test this on our actual data, but since we don't know what the values ought to be, it will be hard to tell if the result was correct.
Instead, let's create a vector of 0s and then center that around 3.
This will make it simple to see if our function is working as expected:


~~~
z <- c(0, 0, 0, 0)
z
~~~
{: .r}



~~~
[1] 0 0 0 0
~~~
{: .output}



~~~
center(z, 3)
~~~
{: .r}



~~~
[1] 3 3 3 3
~~~
{: .output}

That looks right, so let's try center on our real data. We'll center the inflammation data from day 4 around 0:


~~~
dat <- read.csv(file = "data/inflammation-01.csv", header = FALSE)
centered <- center(dat[, 4], 0)
head(centered)
~~~
{: .r}



~~~
[1]  1.25 -0.75  1.25 -1.75  1.25  0.25
~~~
{: .output}

It's hard to tell from the default output whether the result is correct, but there are a few simple tests that will reassure us:


~~~
# original min
min(dat[, 4])
~~~
{: .r}



~~~
[1] 0
~~~
{: .output}



~~~
# original mean
mean(dat[, 4])
~~~
{: .r}



~~~
[1] 1.75
~~~
{: .output}



~~~
# original max
max(dat[, 4])
~~~
{: .r}



~~~
[1] 3
~~~
{: .output}



~~~
# centered min
min(centered)
~~~
{: .r}



~~~
[1] -1.75
~~~
{: .output}



~~~
# centered mean
mean(centered)
~~~
{: .r}



~~~
[1] 0
~~~
{: .output}



~~~
# centered max
max(centered)
~~~
{: .r}



~~~
[1] 1.25
~~~
{: .output}

That seems almost right: the original mean was about 1.75, so the lower bound from zero is now about -1.75.
The mean of the centered data is 0.
We can even go further and check that the standard deviation hasn't changed:


~~~
# original standard deviation
sd(dat[, 4])
~~~
{: .r}



~~~
[1] 1.067628
~~~
{: .output}



~~~
# centered standard deviation
sd(centered)
~~~
{: .r}



~~~
[1] 1.067628
~~~
{: .output}

Those values look the same, but we probably wouldn't notice if they were different in the sixth decimal place.
Let's do this instead:


~~~
# difference in standard deviations before and after
sd(dat[, 4]) - sd(centered)
~~~
{: .r}



~~~
[1] 0
~~~
{: .output}

Sometimes, a very small difference can be detected due to rounding at very low decimal places.
R has a useful function for comparing two objects allowing for rounding errors, `all.equal`:


~~~
all.equal(sd(dat[, 4]), sd(centered))
~~~
{: .r}



~~~
[1] TRUE
~~~
{: .output}

> ## Writing Documentation
>
> Formal documentation for R functions is written in separate `.Rd` using a
> markup language similar to [LaTeX][]. You see the result of this documentation
> when you look at the help file for a given function, e.g. `?read.csv`.
> The [roxygen2][] package allows R coders to write documentation alongside
> the function code and then process it into the appropriate `.Rd` files.
> You will want to switch to this more formal method of writing documentation
> when you start writing more complicated R projects.
> 
> It's still possible that our function is wrong, but it seems unlikely enough
> that we should probably get back to doing our analysis.  We have one more task
> first, though: we should write some [documentation]({{ page.root}}/reference#documentation) 
> for our function to remind ourselves later what
> it's for and how to use it.
> 
> A common way to put documentation in software is to add 
> [comments]({{ page.root}}/reference/#comment) like this:
> 
> ~~~
> center <- function(data, desired) {
>   # return a new vector containing the original data centered around the
>   # desired value.
>   # Example: center(c(1, 2, 3), 0) => c(-1, 0, 1)
>   new_data <- (data - mean(data)) + desired
>   return(new_data)
> }
> ~~~
> {: .r}
> [LaTeX]: http://www.latex-project.org/
> [roxygen2]: http://cran.r-project.org/web/packages/roxygen2/vignettes/rd.html
{: .callout}


### Defining Defaults

We have passed arguments to functions in two ways: directly, as in `dim(dat)`, and by name, as in `read.csv(file = "data/inflammation-01.csv", header = FALSE)`.
In fact, we can pass the arguments to `read.csv` without naming them:


~~~
dat <- read.csv("data/inflammation-01.csv", FALSE)
~~~
{: .r}

However, the position of the arguments matters if they are not named.


~~~
dat <- read.csv(header = FALSE, file = "data/inflammation-01.csv")
dat <- read.csv(FALSE, "data/inflammation-01.csv")
~~~
{: .r}



~~~
Error in read.table(file = file, header = header, sep = sep, quote = quote, : 'file' muss eine Zeichenkette oder eine Verbindung sein
~~~
{: .error}

To understand what's going on, and make our own functions easier to use, let's re-define our `center` function like this:


~~~
center <- function(data, desired = 0) {
  # return a new vector containing the original data centered around the
  # desired value (0 by default).
  # Example: center(c(1, 2, 3), 0) => c(-1, 0, 1)
  new_data <- (data - mean(data)) + desired
  return(new_data)
}
~~~
{: .r}

The key change is that the second argument is now written `desired = 0` instead of just `desired`.
If we call the function with two arguments, it works as it did before:


~~~
test_data <- c(0, 0, 0, 0)
center(test_data, 3)
~~~
{: .r}



~~~
[1] 3 3 3 3
~~~
{: .output}

But we can also now call `center()` with just one argument, in which case `desired` is automatically assigned the default value of `0`:


~~~
more_data <- 5 + test_data
more_data
~~~
{: .r}



~~~
[1] 5 5 5 5
~~~
{: .output}



~~~
center(more_data)
~~~
{: .r}



~~~
[1] 0 0 0 0
~~~
{: .output}

This is handy: if we usually want a function to work one way, but occasionally need it to do something else, we can allow people to pass an argument when they need to but provide a default to make the normal case easier.

The example below shows how R matches values to arguments


~~~
display <- function(a = 1, b = 2, c = 3) {
  result <- c(a, b, c)
  names(result) <- c("a", "b", "c")  # This names each element of the vector
  return(result)
}

# no arguments
display()
~~~
{: .r}



~~~
a b c 
1 2 3 
~~~
{: .output}



~~~
# one argument
display(55)
~~~
{: .r}



~~~
 a  b  c 
55  2  3 
~~~
{: .output}



~~~
# two arguments
display(55, 66)
~~~
{: .r}



~~~
 a  b  c 
55 66  3 
~~~
{: .output}



~~~
# three arguments
display (55, 66, 77)
~~~
{: .r}



~~~
 a  b  c 
55 66 77 
~~~
{: .output}

As this example shows, arguments are matched from left to right, and any that haven't been given a value explicitly get their default value.
We can override this behavior by naming the value as we pass it in:


~~~
# only setting the value of c
display(c = 77)
~~~
{: .r}



~~~
 a  b  c 
 1  2 77 
~~~
{: .output}

> ## Matching Arguments
>
> To be precise, R has three ways that arguments are supplied
> by you are matched to the *formal arguments* of the function definition:
>
> 1. by complete name,
> 2. by partial name (matching on initial *n* characters of the argument name), and
> 3. by position.
>
> Arguments are matched in the manner outlined above in *that order*: by
> complete name, then by partial matching of names, and finally by position.
{: .callout}

With that in hand, let's look at the help for `read.csv()`:


~~~
?read.csv
~~~
{: .r}

There's a lot of information there, but the most important part is the first couple of lines:


~~~
read.csv(file, header = TRUE, sep = ",", quote = "\"",
         dec = ".", fill = TRUE, comment.char = "", ...)
~~~
{: .r}

This tells us that `read.csv()` has one argument, `file`, that doesn't have a default value, and six others that do.
Now we understand why the following gives an error:


~~~
dat <- read.csv(FALSE, "data/inflammation-01.csv")
~~~
{: .r}



~~~
Error in read.table(file = file, header = header, sep = sep, quote = quote, : 'file' muss eine Zeichenkette oder eine Verbindung sein
~~~
{: .error}

It fails because `FALSE` is assigned to `file` and the filename is assigned to the argument `header`.

> ## A Function with Default Argument Values
>
> Rewrite the `rescale` function so that it scales a vector to lie between 0 and 1 by default, but will allow the caller to specify lower and upper bounds if they want.
> Compare your implementation to your neighbor's: do the two functions always behave the same way?
>
> > ## Solution
> > ~~~
> > rescale <- function(v, lower = 0, upper = 1) {
> >   # Rescales a vector, v, to lie in the range lower to upper.
> >   L <- min(v)
> >   H <- max(v)
> >   result <- (v - L) / (H - L) * (upper - lower) + lower
> >   return(result)
> > }
> > ~~~
> > {: .r}
> {: .solution}
{: .challenge}


