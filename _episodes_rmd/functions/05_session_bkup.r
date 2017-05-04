########################################
## Tidyverse and plotting with ggplot
########################################

## set working directory to workshop repo
setwd("/home/mreich/Dokumente/orga/SoftwareCarpentry/Workshops_May2017/2017-05-17-r-workshop/_episodes_rmd")

####################
## Factors
####################

## Factors introduction
sex <- factor(c("male", "female", "female", "male"))

levels(sex)
nlevels(sex)

food <- factor(c("low", "high", "medium", "high", "low", "medium", "high"))
levels(food)
food <- factor(food, levels = c("low", "medium", "high"))
levels(food)
min(food) ## doesn't work
food <- factor(food, levels = c("low", "medium", "high"), ordered=TRUE)
levels(food)
min(food) ## works!

## Converting Factors

# Converting from a factor to a number can cause problems:
f <- factor(c(3.4, 1.2, 5))
as.numeric(f)

# The recommended way is to use the integer vector to index the factor levels:
levels(f)[f]

# This returns a character vector, the `as.numeric()` function is still required to convert the values to the proper type (numeric).
f <- levels(f)[f]
f <- as.numeric(f)

####################
## dplyr package
####################

# Read in data first:
gapminder <- read.csv("./data/gapminder-FiveYearData.csv", header=TRUE)

# Operation examples using normal base R:
mean(gapminder[gapminder$continent == "Africa", "gdpPercap"])
mean(gapminder[gapminder$continent == "Americas", "gdpPercap"])
mean(gapminder[gapminder$continent == "Asia", "gdpPercap"])

# dplyr grammar (basic)

# 1. select()
# 2. filter()
# 3. group_by()
# 4. summarize()
# 5. mutate()

# install package and load

install.packages('dplyr')
library("dplyr")

## Using select()
year_country_gdp <- select(gapminder,year,country,gdpPercap)

# including pipe structure
year_country_gdp <- gapminder %>% select(year,country,gdpPercap)

## Using filter()

year_country_gdp_euro <- gapminder %>%
    filter(continent=="Europe") %>%
    select(year,country,gdpPercap)

####################
## Challenge 1

# Write a single command (which can span multiple lines and includes pipes) that
# will produce a dataframe that has the African values for `lifeExp`, `country`
# and `year`, but not for other Continents.  How many rows does your dataframe
# have and why?

## Solution to Challenge 1
year_country_lifeExp_Africa <- gapminder %>%
                            filter(continent=="Africa") %>%
                            select(year,country,lifeExp)
####################

## Using group_by() and summarize()

str(gapminder)

str(gapminder %>% group_by(continent))

## Using summarize()

gdp_bycontinents <- gapminder %>%
    group_by(continent) %>%
    summarize(mean_gdpPercap=mean(gdpPercap))

####################
## Challenge 2

# Calculate the average life expectancy per country. Which has the longest average life
# expectancy and which has the shortest average life expectancy?

## Solution to Challenge 2
lifeExp_bycountry <- gapminder %>%
    group_by(country) %>%
    summarize(mean_lifeExp=mean(lifeExp))
lifeExp_bycountry %>% 
    filter(mean_lifeExp == min(mean_lifeExp) | mean_lifeExp == max(mean_lifeExp))

# Another way to do this is to use the `dplyr` function `arrange()`, which 
# arranges the rows in a data frame according to the order of one or more 
# variables from the data frame.  It has similar syntax to other functions from 
# the `dplyr` package. You can use `desc()` inside `arrange()` to sort in 
# descending order.

lifeExp_bycountry %>%
    arrange(mean_lifeExp) %>%
    head(1)
lifeExp_bycountry %>%
    arrange(desc(mean_lifeExp)) %>%
    head(1)
####################

# The function `group_by()` allows us to group by multiple variables. Let's group by `year` and `continent`.

gdp_bycontinents_byyear <- gapminder %>%
    group_by(continent,year) %>%
    summarize(mean_gdpPercap=mean(gdpPercap))

# That is already quite powerful, but it gets even better! You're not limited to defining 1 new variable in `summarize()`.

gdp_pop_bycontinents_byyear <- gapminder %>%
    group_by(continent,year) %>%
    summarize(mean_gdpPercap=mean(gdpPercap),
              sd_gdpPercap=sd(gdpPercap),
              mean_pop=mean(pop),
              sd_pop=sd(pop))

## Using mutate()

# We can also create new variables prior to (or even after) summarizing information using `mutate()`.

gdp_pop_bycontinents_byyear <- gapminder %>%
    mutate(gdp_billion=gdpPercap*pop/10^9) %>%
    group_by(continent,year) %>%
    summarize(mean_gdpPercap=mean(gdpPercap),
              sd_gdpPercap=sd(gdpPercap),
              mean_pop=mean(pop),
              sd_pop=sd(pop),
              mean_gdp_billion=mean(gdp_billion),
              sd_gdp_billion=sd(gdp_billion))

####################
## ggplot2 package
####################

# [ggplot2]: http://www.statmethods.net/advgraphs/ggplot2.html

# The key to understanding ggplot2 is thinking about a figure in layers.
# This idea may be familiar to you if you have used image editing programs like Photoshop, Illustrator, or
# Inkscape.

# Let's start off with an example:
install.packages("ggplot2")
library("ggplot2")

ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point()

# By itself, the call to `ggplot` isn't enough to draw a figure:

ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp))

####################
## Challenge 3

# Modify the example so that the figure shows how life expectancy has
# changed over time:

ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) + geom_point()

# Hint: the gapminder dataset has a column called "year", which should appear
# on the x-axis.

## Solution to challenge 3

# Here is one possible solution:

ggplot(data = gapminder, aes(x = year, y = lifeExp)) + geom_point()
####################

####################
## Challenge 4

# In the previous examples and challenge we've used the `aes` function to tell
# the scatterplot **geom** about the **x** and **y** locations of each point.
# Another *aesthetic* property we can modify is the point *color*. Modify the
# code from the previous challenge to **color** the points by the "continent"
# column. What trends do you see in the data? Are they what you expected?

## Solution to challenge 4

# In the previous examples and challenge we've used the `aes` function to tell
# the scatterplot **geom** about the **x** and **y** locations of each point.
# Another *aesthetic* property we can modify is the point *color*. Modify the
# code from the previous challenge to **color** the points by the "continent"
# column. What trends do you see in the data? Are they what you expected?

ggplot(data = gapminder, aes(x = year, y = lifeExp, color=continent)) +
  geom_point()
####################

## Layers

# Using a scatterplot probably isn't the best for visualizing change over time.
# Instead, let's tell `ggplot` to visualize the data as a line plot:

ggplot(data = gapminder, aes(x=year, y=lifeExp, by=country, color=continent)) +
  geom_line()

# Instead of adding a `geom_point` layer, we've added a `geom_line` layer. We've
# added the **by** *aesthetic*, which tells `ggplot` to draw a line for each
# country.
# 
# But what if we want to visualize both lines and points on the plot? We can
# simply add another layer to the plot:

ggplot(data = gapminder, aes(x=year, y=lifeExp, by=country, color=continent)) +
  geom_line() + geom_point()

# Order of layers
ggplot(data = gapminder, aes(x=year, y=lifeExp, by=country)) +
  geom_line(aes(color=continent)) + geom_point()

# In this example, the *aesthetic* mapping of **color** has been moved from the
# global plot options in `ggplot` to the `geom_line` layer so it no longer applies
# to the points. Now we can clearly see that the points are drawn on top of the
# lines.

## Tip: Setting an aesthetic to a value instead of a mapping

####################
## Challenge 5

# Switch the order of the point and line layers from the previous example. What
# happened?

## Solution to challenge 5

# Switch the order of the point and line layers from the previous example. What
# happened?

ggplot(data = gapminder, aes(x=year, y=lifeExp, by=country)) +
 geom_point() + geom_line(aes(color=continent))

# The lines now get drawn over the points!
####################

## Transformations and statistics

# Ggplot also makes it easy to overlay statistical models over the data. To
# demonstrate we'll go back to our first example:

ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp, color=continent)) +
  geom_point()

# Currently it's hard to see the relationship between the points due to some strong
# outliers in GDP per capita. We can change the scale of units on the x axis using
# the *scale* functions. These control the mapping between the data values and
# visual values of an aesthetic. We can also modify the transparency of the
# points, using the *alpha* function, which is especially helpful when you have
# a large amount of data which is very clustered.

ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(alpha = 0.5) + scale_x_log10()

# The `log10` function applied a transformation to the values of the gdpPercap
# column before rendering them on the plot, so that each multiple of 10 now only
# corresponds to an increase in 1 on the transformed scale, e.g. a GDP per capita
# of 1,000 is now 3 on the y axis, a value of 10,000 corresponds to 4 on the y
# axis and so on. This makes it easier to visualize the spread of data on the
# x-axis.

## Tip Reminder: Setting an aesthetic to a value instead of a mapping

# Notice that we used `geom_point(alpha = 0.5)`. As the previous tip mentioned, using a setting outside of the `aes()` function will cause this value to be used for all points, which is what we want in this case. But just like any other aesthetic setting, *alpha* can also be mapped to a variable in the data. For example, we can give a different transparency to each continent with `geom_point(aes(alpha = continent))`.

# We can fit a simple relationship to the data by adding another layer,
# geom_smooth()=:

ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point() + scale_x_log10() + geom_smooth(method="lm")

# We can make the line thicker by *setting* the **size** aesthetic in the
# geom_smooth() layer:

ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point() + scale_x_log10() + geom_smooth(method="lm", size=1.5)

# There are two ways an *aesthetic* can be specified. Here we *set* the **size**
# aesthetic by passing it as an argument to `geom_smooth`. Previously in the
# lesson we've used the `aes` function to define a *mapping* between data
# variables and their visual representation.

####################
## Challenge 6a

# Modify the color and size of the points on the point layer in the previous
# example.

# Hint: do not use the `aes` function.

## Solution to challenge 6a

# Modify the color and size of the points on the point layer in the previous
# example.

# Hint: do not use the `aes` function.

ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
 geom_point(size=3, color="orange") + scale_x_log10() +
 geom_smooth(method="lm", size=1.5)
####################

####################
## Challenge 6b

# Modify your solution to Challenge 6a so that the
# points are now a different shape and are colored by continent with new
# trendlines.  Hint: The color argument can be used inside the aesthetic.

## Solution to challenge 6b

# Modify Challenge 6a so that the points are now a different shape and are
# colored by continent with new trendlines.

# Hint: The color argument can be used inside the aesthetic.

ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp, color = continent)) +
geom_point(size=3, shape=17) + scale_x_log10() +
geom_smooth(method="lm", size=1.5)
####################

## Multi-panel figures

# Earlier we visualized the change in life expectancy over time across all
# countries in one plot. Alternatively, we can split this out over multiple panels
# by adding a layer of **facet** panels. Focusing only on those countries with
# names that start with the letter "A" or "Z".

## Tip

# We start by subsetting the data.  We use the `substr` function to
# pull out a part of a character string; in this case, the letters that occur
# in positions `start` through `stop`, inclusive, of the `gapminder$country`
# vector. The operator `%in%` allows us to make multiple comparisons rather
# than write out long subsetting conditions (in this case,
# `starts.with %in% c("A", "Z")` is equivalent to
# `starts.with == "A" | starts.with == "Z"`)

# Using `dplyr` functions also helps us simplify things, for example we could
# combine the first two steps:

gapminder %>%
    # Filter countries that start with "A" or "Z"
	filter(substr(country, start = 1, stop = 1) %in% c("A", "Z")) %>%
	# Make the plot
	ggplot(aes(x = year, y = lifeExp, color = continent)) + 
	geom_line() + 
	facet_wrap( ~ country)

# The `facet_wrap` layer took a "formula" as its argument, denoted by the tilde
# (~). This tells R to draw a panel for each unique value in the country column
# of the gapminder dataset.


####################
## Challenge 7

# Create a density plot of GDP per capita, filled by continent.

# Advanced:
#  - Transform the x axis to better visualise the data spread.
#  - Add a facet layer to panel the density plots by year.

## Solution to challenge 7

# Create a density plot of GDP per capita, filled by continent.

# Advanced:
#  - Transform the x axis to better visualise the data spread.
#  - Add a facet layer to panel the density plots by year.

ggplot(data = gapminder, aes(x = gdpPercap, fill=continent)) +
 geom_density(alpha=0.6) + facet_wrap( ~ year) + scale_x_log10()
####################
