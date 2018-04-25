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
fahr_to_kelvin <- function(temp_f) {
  kelvin <- ((temp_f - 32) * (5 / 9)) + 273.15
  return(kelvin)
}
~~~
{: .r}

We define `fahr_to_kelvin` by assigning it to the output of `function`. The
list of argument names are contained within parentheses.  Next, the
[body]({{ page.root }}/reference/#function-body) of the function--the statements that are
executed when it runs--is contained within curly braces (`{}`).  The statements
in the body are indented by two spaces. This makes the code easier to read but
does not affect how the code operates.

When we call the function, the values we pass to it as arguments are assigned to those
variables so that we can use them inside the function. Inside the function, we
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
> > 
> > ~~~
> > kelvin_to_celsius <- function(temp_k) {
> >  temp_c<- temp_k - 273.15
> >  return(temp_c)
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
> > ## Solution to challenge 2
> >
> > 
> > ~~~
> > kelvin_to_celsius <- function(temp_k) {
> >   if(!is.numeric(temp_k)){
> >     stop("Numeric input required")
> >   }else{}
> >   if (temp_k < 0) {
> >     stop("Can not process temperatures below absolute zero")
> >   }else {}
> >   #  
> >   temp_c <- temp_k - 273.15
> >   return(temp_c)
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
fahr_to_kelvin <- function(temp_f) {
  temp_k <- ((temp_f - 32) * (5 / 9)) + 273.15
  return(temp_k)
}

kelvin_to_celsius <- function(temp_k) {
  if(!is.numeric(temp_k)){
    stop("Numeric input required")
  }else{}
  if (temp_k < 0) {
    stop("Can not process temperatures below absolute zero")
  }else {}
  #  
  temp_c <- temp_k - 273.15
  return(temp_c)
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
> > fahr_to_celsius <- function(temp_f) {
> >   temp_k <- fahr_to_kelvin(temp_f)
> >   temp_c <- kelvin_to_celsius(temp_k)
> >   return(temp_c)
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

---
 
# Matching Arguments

To be precise, R has three ways that arguments are supplied
by you are matched to the *formal arguments* of the function definition:

1. by complete name,
2. by partial name (matching on initial *n* characters of the argument name), and
3. by position.

Arguments are matched in the manner outlined above in *that order*: by
complete name, then by partial matching of names, and finally by position.


~~~
display <- function(a, b, c) {
  result <- c(a, b, c)
  # This names each element of the vector
  names(result) <- c("a", "b", "c")
  return(result)
}
display(1, 2, 3)
~~~
{: .r}



~~~
a b c 
1 2 3 
~~~
{: .output}



~~~
display(3, 2, 1)
~~~
{: .r}



~~~
a b c 
3 2 1 
~~~
{: .output}

Now lets call the function with named arguments.


~~~
display(a = 3, b = 2, c = 1)
~~~
{: .r}



~~~
a b c 
3 2 1 
~~~
{: .output}



~~~
display(c = 1, b = 2, a = 3)
~~~
{: .r}



~~~
a b c 
3 2 1 
~~~
{: .output}
In that case the order does not matter.

# Defining default function arguments

This is handy: if we usually want a function to work one way, but occasionally
need it to do something else, we can allow people to pass an argument when they
need to but provide a default to make the normal case easier.


~~~
display <- function(a = 1, b = 2, c = 3) {
  result <- c(a, b, c)
  # This names each element of the vector
  names(result) <- c("a", "b", "c")
  return(result)
}
~~~
{: .r}
We can now call the function without providing any arguments because we defined
a set of default values.


~~~
display()
~~~
{: .r}

In such a case, the usage of named argument becomes even more important.


~~~
display(9)
~~~
{: .r}



~~~
a b c 
9 2 3 
~~~
{: .output}



~~~
display(c = 9)
~~~
{: .r}



~~~
a b c 
1 2 9 
~~~
{: .output}

With that in hand, let's look at the help for `read.csv()`:


~~~
?read.csv
~~~
{: .r}

There's a lot of information there, but the most important part is the first
couple of lines:


~~~
read.csv(file, header = TRUE, sep = ",", quote = "\"",
         dec = ".", fill = TRUE, comment.char = "", ...)
~~~
{: .r}

This tells us that `read.csv()` has one argument, `file`, that doesn't have a
default value, and six others that do.
Now we understand why the following gives an error:


~~~
dat <- read.csv(FALSE, "data/inflammation-01.csv")
~~~
{: .r}



~~~
Error in read.table(file = file, header = header, sep = sep, quote = quote, : 'file' must be a character string or connection
~~~
{: .error}

It fails because `FALSE` is assigned to `file` and the filename is assigned to
the argument `header`.

However, using the "correct" style the order does not matter.


~~~
dat <- read.csv(header = FALSE, file = "data/inflammation-01.csv")
~~~
{: .r}
#

### Testing and Documenting

Once we start putting things in functions so that we can re-use them, we need
to start testing that those functions are working correctly.  To see how to do
this, let's write a function to center a dataset around a particular value (By
centering a dataset we subtract the men from and add the particular value to
each value of the dataset). For illustration purpose only, we are going to
write both function, the custom function that computes the _mean_, and the
`center` function that makes use of our `custom_mean` function.


~~~
custom_mean = function(data_vect){
  temp  = sum(data_vect) / length(data_vect)
  return(temp)
}

center <- function(data, desired) {
  new_data <- (data - custom_mean(data)) + desired
  return(new_data)
}
~~~
{: .r}

We could test this on our actual data, but since we don't know what the values
ought to be, it will be hard to tell if the result was correct.  Instead, let's
create a vector of 0s and then center that around 3. This will make it simple
to see if our function is working as expected:

For the `custom_mean` function:

~~~
a = c(1, 2, 3)
a
~~~
{: .r}



~~~
[1] 1 2 3
~~~
{: .output}



~~~
custom_mean(a)
~~~
{: .r}



~~~
[1] 2
~~~
{: .output}



~~~
b = c(2, 2, 2)
b
~~~
{: .r}



~~~
[1] 2 2 2
~~~
{: .output}



~~~
custom_mean(b)
~~~
{: .r}



~~~
[1] 2
~~~
{: .output}



~~~
d = c(-1, -2, -3)
d
~~~
{: .r}



~~~
[1] -1 -2 -3
~~~
{: .output}



~~~
custom_mean(d)
~~~
{: .r}



~~~
[1] -2
~~~
{: .output}

For the `center` function:

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



~~~
z <- c(3, 3, 3, 3)
z
~~~
{: .r}



~~~
[1] 3 3 3 3
~~~
{: .output}



~~~
center(z, -3)
~~~
{: .r}



~~~
[1] -3 -3 -3 -3
~~~
{: .output}
As we substract a constant from each eleemt of the vector, the standard
deviation does not change as we apply our `center` function. Another option to
test our function.


~~~
# original standard deviation
sd(z)
~~~
{: .r}



~~~
[1] 0
~~~
{: .output}



~~~
# centered standard deviation
sd(center(z, 4))
~~~
{: .r}



~~~
[1] 0
~~~
{: .output}

> 'Whenever you are tempted to type something into a print statement or a debugger
> expression, write it as a test instead.' — Martin Fowler
> [testthat](http://r-pkgs.had.co.nz/tests.html)
{: .callout}

If your project has multiple functions that make use of each other, it is becoming
tedious to rewrite the statements above again and again. Instead, put them
into separate __tests*__ file, the validate your code after you changed
something. The [testthat](http://r-pkgs.had.co.nz/tests.html) provides a
couple of functions to automate and ease the process of testing. Before we start with 
some examples, lets make the advantages of an integrated testing very clear. 

* Code structure- It is easy to write tests for functions that do one
  particular thing. So tests will help you to redefine your problem into single
  bits.
* Confidence about your code- your are more confident about parts of your code
  you wrote tests for.
* Robust code- changes to your code will immediately show failure or success,
  even for parts you did not even think about.
* Increase transferability- running your code on a computer of your colleague
  or on another operating system, your test-suite will show flaws of your
  software. 
* Good entry point to pick up on an older project

But now lets start with some examples and the
[testthat](http://r-pkgs.had.co.nz/tests.html) package.


~~~
library(testthat)
~~~
{: .r}

We will go through the two main structures of the package, that are _tests_ and
_expectations_.  _Expectations_,  help you to formalize your interactive tests
and print statements. _Expectations_ are called via the family of functions
that start with `expect_*` and evaluate the properties between __two__ R
objects. Putting our last interactive test into an expectations.


~~~
expect_equal(sd(center(z, 33)), sd(z))
~~~
{: .r}

In case the expression within `expect_that` evaluates to `FALSE`, an error is given.

~~~
# expect_equal(2, 3)
~~~
{: .r}

_Tests_, via the `test_that` function on the other site, help us to organize
our expectations by grouping expectations for a single function or an
interaction between multiple functions. That looks like that, if we take the
one of the three interactive tests for our `custom_mean` function.


~~~
test_that('Testing the custom_mean function', {
  a = c(1, 2, 3)
  expect_equal(custom_mean(a), 2)
})
~~~
{: .r}
> ## Challenge 4
>
> Write a _test_ as that incoorperates two examples from our `center` function.
>
>
> > ## Solution to challenge 4
> >
> > Write a _test_ as that incoorperates two examples from our `center` function.
> >
> > 
> > ~~~
> > test_that('Testing the center function', {
> >   z <- c(0, 0, 0, 0)
> >   centered = center(z, 3)
> >   expect_equal(centered, rep(3, 4))
> >   # testing the standard deviation
> >   expect_equal(sd(centered), sd(z))
> > })
> > ~~~
> > {: .r}
> {: .solution}
{: .challenge}

The __testthat__ package provides as set of functions to run test as convenient
as possible. We will see two examples, namely the `test_file()` and `test_dir()`
functions. The `test_file()` function will run the specified source file. The
functionality is similar to the `source` function, but the output is more
informative. The `test_dir()` on the other hand, will run all files that start
with _test_ in the given directory. Let's put our tests into a file next to our
functions (functions-lesson.R) and see how it works. So we create file called
'test-functions-lesson.R'. The file looks like that:



~~~
# read the file with the functions we want to test
source('functions-lesson.R')

# Test for custom_mean
test_that('Testing the custom_mean function', {
  a = c(1, 2, 3)
  expect_equal(custom_mean(a), 2)
})

# Test for center
test_that('Testing the center function', {
  z <- c(0, 0, 0, 0)
  centered = center(z, 3)
  expect_equal(centered, rep(3, 4))
  # testing the standard deviation
  expect_equal(sd(centered), sd(z))
})
~~~
{: .r}

Applying the `test_file` function.

~~~
test_file('./functions/test-functions-lesson.R')
~~~
{: .r}



~~~
✔ | OK F W S | Context
⠋ |  1       | 0⠙ |  2       | 0⠹ |  3       | 0⠸ |  4       | 0⠼ |  5       | 0⠴ |  6       | 0⠦ |  7       | 0
══ Results ════════════════════════════════════════════════════════════════
OK:       7
Failed:   0
Warnings: 0
Skipped:  0
~~~
{: .output}

Applying the `test_dir` function.

~~~
test_dir('./functions')
~~~
{: .r}



~~~
✔ | OK F W S | Context
⠋ |  1       | 0⠙ |  2       | 0⠹ |  3       | 0⠸ |  4       | 0⠼ |  5       | 0⠴ |  6       | 0⠦ |  7       | 0
══ Results ════════════════════════════════════════════════════════════════
OK:       7
Failed:   0
Warnings: 0
Skipped:  0
~~~
{: .output}
> ## Challenge 5
>
> Extent the file 'test-functions-lesson.R' by writing a test that fails. How
> does the results look like and what does it tell us.
>
> > ## Solution to challenge 5
> >
> > 
> > ~~~
> > test_that('Testing the center function', {
> >   z <- c(0, 0, 0, 0)
> >   centered = center(z, 3)
> >   # change the value of the vector to 2, so the lenght is still the same,
> >   # but the value is wrong.
> >   expect_equal(centered, rep(2, 4))
> >   # testing the standard deviation
> >   expect_equal(sd(centered), sd(z))
> > })
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > ~~~
> > Error: Test failed: 'Testing the center function'
> > * `centered` not equal to rep(2, 4).
> > 4/4 mismatches (average diff: 1)
> > [1] 3 - 2 == 1
> > [2] 3 - 2 == 1
> > [3] 3 - 2 == 1
> > [4] 3 - 2 == 1
> > ~~~
> > {: .error}
> {: .solution}
{: .challenge}

> ## Challenge 6
>
> Think about other options that are worth testing with regard to the functions
> we used during this leesson.
>
> > ## Solution to challenge 6
> > 
> > Examples: 
> > * test the return type of your function
> > * test for a certain error message
> > * test object dimensions of your return type
> > 
> > ```
> {: .solution}
{: .challenge}

The `auto_test` function constantly runs yours tests whenever the code of your
functions or the code of your tests was written to disk. So once started, you
"only" switch between your `functions.R` and your `test.R` file (or
whatever name you chose). Put a line `context("any kind of string here")` at the
beginging of your test-file (see [here](https://github.com/r-lib/testthat/issues/700)).

> ## Challenge 7
>
> Use the `auto_test` function to implement one of the discussed test. 
>
> > ## Solution to challenge 7
> >
> > 
> > ~~~
> > test_that('Testing the kelvin_to_celsius error message', {
> >  # aboslut zero
> >  expect_equal(kelvin_to_celsius(temp_k = 273.15), 0)
> >  # testing whether an error is given in case we use character
> >  expect_error(kelvin_to_celsius("a"), "Numeric input required")
> >  # testing whether an error is given in case we use temp below absolute zero
> >  expect_error(kelvin_to_celsius(temp_k = -10), 
> >               "Can not process temperatures below absolute zero")
> >  expect_error(kelvin_to_celsius(temp_k = -0.0001), 
> >               "Can not process temperatures below absolute zero")
> > })
> > ~~~
> > {: .r}
> {: .solution}
{: .challenge}
