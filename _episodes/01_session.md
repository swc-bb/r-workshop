---
title: "Introduction to R and RStudio"
teaching: 45
exercises: 10
questions:
- "How to find your way around RStudio?"
- "How to interact with R?"
- "How to manage your environment?"
- "How to install packages?"
objectives:
- "To gain familiarity with the various panes in the RStudio IDE"
- "To gain familiarity with the buttons, short cuts and options in the RStudio IDE"
- "To understand variables and how to assign to them"
- "To be able to manage your workspace in an interactive R session"
- "To be able to use mathematical and comparison operations"
- "To be able to call functions"
- "Introduction to package management"
keypoints:
- "Use RStudio to write and run R programs."
- "R has the usual arithmetic operators and mathematical functions."
- "Use `<-` to assign values to variables."
- "Use `ls()` to list the variables in a program."
- "Use `rm()` to delete objects in a program."
- "Use `install.packages()` to install packages (libraries)."
source: Rmd
---


## Motivation

Science is a multi-step process: once you've designed an experiment and collected data, the real fun begins! 
This lesson will teach you how to start this process using R and RStudio. 
We will begin with an exercise on basic R syntax, learn about reading files an plotting for exploratory analyses, 
obtain an overview of R objects, practice installing packages and linear regression.
This example starts with a [treesize dataset](http://bit.ly/swc_tree).


## Before Starting The Workshop

Please ensure you have the latest version of R and RStudio installed on your machine. 
This is important, as some packages used in the workshop may not install correctly (or at all) if R is not up to date.

[Download and install the latest version of R here](https://www.r-project.org/)  
[Download and install RStudio here](https://www.rstudio.com/)

## Introduction to RStudio

Welcome to the R portion of the Software Carpentry workshop.

Throughout this lesson, we're going to teach you some of the fundamentals of
the R language as well as some best practices for organizing code for
scientific projects that will make your life easier.

We'll be using RStudio: a free, open source R integrated development
environment. It provides a built in editor, works on all platforms (including
on servers) and provides many advantages such as integration with version
control and project management.

## Slides

We'll be using custom slides for this lesson.

* [PDF version](https://github.com/swc-bb/2017-05-17-r-workshop/raw/gh-pages/_episodes/SWC_Rstudio_Berry.pdf)
* [Presentation version](https://github.com/swc-bb/2017-05-17-r-workshop/raw/gh-pages/_episodes/SWC_Rstudio_Berry_pres.pdf)
* [Rnw source code](https://github.com/swc-bb/2017-05-17-r-workshop/blob/gh-pages/_episodes/SWC_Rstudio_Berry.Rnw)

> ## Tip: Warnings vs. Errors
>
> Pay attention when R does something unexpected! Errors, like above,
> are thrown when R cannot proceed with a calculation. Warnings on the
> other hand usually mean that the function has run, but it probably
> hasn't worked as expected.
>
> In both cases, the message that R prints out usually give you clues
> how to fix a problem.
>
{: .callout}

## R Packages

It is possible to add functions to R by writing a package, or by
obtaining a package written by someone else. As of this writing, there
are over 10,000 packages available on CRAN (the comprehensive R archive
network). R and RStudio have functionality for managing packages:

* You can see what packages are installed by typing
  `installed.packages()`
* You can install packages by typing `install.packages("packagename")`,
  where `packagename` is the package name, in quotes.
* You can update installed packages by typing `update.packages()`
* You can remove a package with `remove.packages("packagename")`
* You can make a package available for use with `library(packagename)`

> ## Challenge 1
>
> Which of the following are valid R variable names?
> 
> ~~~
> min_height
> max.height
> _age
> .mass
> MaxLength
> min-length
> 2widths
> celsius2kelvin
> ~~~
> {: .r}
>
> > ## Solution to challenge 1
> >
> > The following can be used as R variables:
> > 
> > ~~~
> > min_height
> > max.height
> > MaxLength
> > celsius2kelvin
> > ~~~
> > {: .r}
> >
> > The following creates a hidden variable:
> > 
> > ~~~
> > .mass
> > ~~~
> > {: .r}
> >
> > The following will not be able to be used to create a variable
> > 
> > ~~~
> > _age
> > min-length
> > 2widths
> > ~~~
> > {: .r}
> {: .solution}
{: .challenge}

> ## Challenge 2
>
> What will be the value of each  variable  after each
> statement in the following program?
>
> 
> ~~~
> mass <- 47.5
> age <- 122
> mass <- mass * 2.3
> age <- age - 20
> ~~~
> {: .r}
>
> > ## Solution to challenge 2
> >
> > 
> > ~~~
> > mass <- 47.5
> > ~~~
> > {: .r}
> > This will give a value of 47.5 for the variable mass
> >
> > 
> > ~~~
> > age <- 122
> > ~~~
> > {: .r}
> > This will give a value of 122 for the variable age
> >
> > 
> > ~~~
> > mass <- mass * 2.3
> > ~~~
> > {: .r}
> > This will multiply the existing value of 47.5 by 2.3 to give a new value of
> > 109.25 to the variable mass.
> >
> > 
> > ~~~
> > age <- age - 20
> > ~~~
> > {: .r}
> > This will subtract 20 from the existing value of 122 to give a new value
> > of 102 to the variable age.
> {: .solution}
{: .challenge}


> ## Challenge 3
>
> Run the code from the previous challenge, and write a command to
> compare mass to age. Is mass larger than age?
>
> > ## Solution to challenge 3
> >
> > One way of answering this question in R is to use the `>` to set up the following:
> > 
> > ~~~
> > mass > age
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > ~~~
> > [1] TRUE
> > ~~~
> > {: .output}
> > This should yield a boolean value of TRUE since 109.25 is greater than 102.
> {: .solution}
{: .challenge}


> ## Challenge 4
>
> Clean up your working environment by deleting the mass and age
> variables.
>
> > ## Solution to challenge 4
> >
> > We can use the `rm` command to accomplish this task
> > 
> > ~~~
> > rm(age, mass)
> > ~~~
> > {: .r}
> {: .solution}
{: .challenge}

> ## Challenge 5
>
> Install the following packages: `ggplot2`, `plyr`, `gapminder`
>
> > ## Solution to challenge 5
> >
> > We can use the `install.packages()` command to install the required packages.
> > 
> > ~~~
> > install.packages("ggplot2")
> > install.packages("plyr")
> > install.packages("gapminder")
> > ~~~
> > {: .r}
> {: .solution}
{: .challenge}
