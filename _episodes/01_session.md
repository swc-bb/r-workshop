---
title: ggplot2
teaching: 60
exercises: 60
questions:
- "How can I convert a dataframe from wide to long format?"
- "How is categorical data represented in R?"
- "How do I work with factors?"
- "How can I create publication-quality graphics in R?"
objectives:
- "Understand how to represent categorical data in R."
- "Know the difference between ordered and unordered factors."
- "Be aware of some of the problems encountered when using factors."
- "To be able to use ggplot2 to generate publication quality graphics."
- "To understand the basic grammar of graphics, including the aesthetics and
  geometry layers, adding statistics, transforming scales, and coloring or
  panelling by groups."
keypoints:
- "The answer to the most questions in R: convert it to long format (normalize your data)"
- "Factors are used to represent categorical data."
- "Factors can be *ordered* or *unordered*."
- "Some R functions have special methods for handling factors."
- "Use `ggplot2` to create plots."
- "Think about graphics in layers: aesthetics, geometry, statistics, scale
  transformation, and grouping."

source: Rmd
---

# Wide vs long data format


```r
library(tidyverse)
```

```
## ── Attaching packages ────────────────────────────────── tidyverse 1.2.1 ──
```

```
## ✔ ggplot2 3.1.0.9000     ✔ readr   1.1.1     
## ✔ tibble  1.4.2          ✔ purrr   0.2.5     
## ✔ tidyr   0.8.1          ✔ dplyr   0.7.6     
## ✔ ggplot2 3.1.0.9000     ✔ forcats 0.3.0
```

```
## ── Conflicts ───────────────────────────────────── tidyverse_conflicts() ──
## ✖ dplyr::filter() masks stats::filter()
## ✖ dplyr::lag()    masks stats::lag()
```

```r
# Make a data frame in wide format, gdp per country
df_wide = data.frame(year = c("2001", "2001"),
                     austria = c(100, 200),
                     sweden = c(300, 400))

# Imagine adding another variable, that you want to compare with the gdp later
# If we strictly stick to the wide format, that may look like that.

df_wide = data.frame(year = c("2001", "2001"),
                     austria_gdp = c(100, 200),
                     austria_lifeexp = c(81, 82),
                     sweden_gdp = c(300, 400),
                     sweden_lifeexp = c(83, 84))
```

# Data manipulation with the "wide" format
How do you continue to work with that kind of data, if you are ask to
compute summary stats for each country and variable.
  * using indices 
  * using regular expressions to find toe correct columns
  * ... 

What if a colleague has a similar question and thinks very similar, but
only similar :-)


```r
df_wide = data.frame(year = c("2001", "2001"),
                     gdp_austria = c(100, 200),
                     gdp_sweden = c(300, 400),
                     lifeexp_austria = c(81, 82),
                     lifeexp_sweden = c(83, 84))
```


```r
How does the index approach work ... ? Not at all!
The solution: long format instead of the wide format.

df_long = tidyr::gather(df_wide, variable_mix, value, -year)

# This is first half of the cake:

df_long = tidyr::separate(df_long, 
                          variable_mix, c("variable", "country"), sep = "_")
```

```
## Error: <text>:1:5: unexpected symbol
## 1: How does
##         ^
```


# Factors

Factors are used to represent categorical data. Factors can be ordered or
unordered and are an important class for statistical analysis and for plotting.

Factors are stored as integers, and have labels associated with these unique
integers. While factors look (and often behave) like character vectors, they are
actually integers under the hood, and you need to be careful when treating them
like strings.

Once created, factors can only contain a pre-defined set values, known as
*levels*. By default, R always sorts *levels* in alphabetical order. For
instance, if you have a factor with 2 levels:

> ## The `factor()` Command
>
> The `factor()` command is used to create and modify factors in R:
>
> 
> 
> ```r
> sex <- factor(c("male", "female", "female", "male"))
> ```

R will assign `1` to the level `"female"` and `2` to the level `"male"` (because
`f` comes before `m`, even though the first element in this vector is
`"male"`). You can check this by using the function `levels()`, and check the
number of levels using `nlevels()`:



```r
levels(sex)
```

```
## [1] "female" "male"
```



```r
nlevels(sex)
```

```
## [1] 2
```

Sometimes, the order of the factors does not matter, other times you might want
to specify the order because it is meaningful (e.g., "low", "medium", "high") or
it is required by particular type of analysis. Additionally, specifying the
order of the levels allows us to compare levels:



```r
food <- factor(c("low", "high", "medium", "high", "low", "medium", "high"))
levels(food)
```

```
## [1] "high"   "low"    "medium"
```


```r
food <- factor(food, levels = c("low", "medium", "high"))
levels(food)
```

```
## [1] "low"    "medium" "high"
```


```r
min(food) ## doesn't work
```

```
## Error in Summary.factor(structure(c(1L, 3L, 2L, 3L, 1L, 2L, 3L), .Label = c("low", : 'min' not meaningful for factors
```


```r
food <- factor(food, levels = c("low", "medium", "high"), ordered=TRUE)
levels(food)
```

```
## [1] "low"    "medium" "high"
```


```r
min(food) ## works!
```

```
## [1] low
## Levels: low < medium < high
```

In R's memory, these factors are represented by numbers (1, 2, 3). They are
better than using simple integer labels because factors are self describing:
`"low"`, `"medium"`, and `"high"`" is more descriptive than `1`, `2`, `3`. Which
is low?  You wouldn't be able to tell with just integer data. Factors have this
information built in. It is particularly helpful when there are many levels
(like the subjects in our example data set).

> ## Representing Data in R
>
> You have a vector representing levels of exercise undertaken by 5 subjects
>
> **"l","n","n","i","l"** ; n=none, l=light, i=intense
>
> What is the best way to represent this in R?
>
> a) exercise <- c("l", "n", "n", "i", "l")
>
> b) exercise <- factor(c("l", "n", "n", "i", "l"), ordered = TRUE)
>
> c) exercise < -factor(c("l", "n", "n", "i", "l"), levels = c("n", "l", "i"), ordered = FALSE)
>
> d) exercise <- factor(c("l", "n", "n", "i", "l"), levels = c("n", "l", "i"), ordered = TRUE)
{: .challenge}


###  Converting Factors

Converting from a factor to a number can cause problems:



```r
f <- factor(c(3.4, 1.2, 5))
as.numeric(f)
```

```
## [1] 2 1 3
```

This does not behave as expected (and there is no warning).
The recommended way is to use the integer vector to index the factor levels:



```r
levels(f)[f]
```

```
## [1] "3.4" "1.2" "5"
```


This returns a character vector, the `as.numeric()` function is still required
to convert the values to the proper type (numeric).



```r
f <- levels(f)[f]
f <- as.numeric(f)
```

---

# ggplot2

Plotting our data is one of the best ways to
quickly explore it and the various relationships
between variables.

There are three main plotting systems in R,
the [base plotting system][base], the [lattice][lattice]
package, and the [ggplot2][ggplot2] package.

[base]: http://www.statmethods.net/graphs/
[lattice]: http://www.statmethods.net/advgraphs/trellis.html
[ggplot2]: http://www.statmethods.net/advgraphs/ggplot2.html

Today we'll be learning about the ggplot2 package, because
it is the most effective for creating publication quality
graphics.

ggplot2 is built on the grammar of graphics, the idea that any plot can be
expressed from the same set of components: a **data** set, a
**coordinate system**, and a set of **geoms**--the visual representation of data
points.

The key to understanding ggplot2 is thinking about a figure in layers.
This idea may be familiar to you if you have used image editing programs like
Photoshop, Illustrator, or Inkscape.

Let's start off with an example:


```r
library(ggplot2)

gapminder = read.table("./data/gapminder-FiveYearData.csv",
                       sep = ",", header = T)

ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point()
```

![plot of chunk unnamed-chunk-15](../figure/unnamed-chunk-15-1.png)

So the first thing we do is call the `ggplot` function. This function lets R
know that we're creating a new plot, and any of the arguments we give the
`ggplot` function are the *global* options for the plot: they apply to all
layers on the plot.

We've passed in two arguments to `ggplot`. First, we tell `ggplot` what data we
want to show on our figure, in this example the gapminder data we read in
earlier. For the second argument we passed in the `aes` function, which
tells `ggplot` how variables in the **data** map to *aesthetic* properties of
the figure, in this case the **x** and **y** locations. Here we told `ggplot` we
want to plot the "gdpPercap" column of the gapminder data frame on the x-axis, and
the "lifeExp" column on the y-axis. Notice that we didn't need to explicitly
pass `aes` these columns (e.g. `x = gapminder[, "gdpPercap"]`), this is because
`ggplot` is smart enough to know to look in the **data** for that column!

By itself, the call to `ggplot` isn't enough to draw a figure:



```r
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp))
```

![plot of chunk unnamed-chunk-16](figure/unnamed-chunk-16-1.png)


We need to tell `ggplot` how we want to visually represent the data, which we
do by adding a new **geom** layer. In our example, we used `geom_point`, which
tells `ggplot` we want to visually represent the relationship between **x** and
**y** as a scatterplot of points:



```r
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point()
```

![plot of chunk unnamed-chunk-17](figure/unnamed-chunk-17-1.png)

> ## Challenge 1
>
> Modify the example so that the figure shows how life expectancy has
> changed over time:
>
> 
> 
> ```r
> ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) + geom_point()
> ```
> 
> ![plot of chunk unnamed-chunk-18](figure/unnamed-chunk-18-1.png)
>
> Hint: the gapminder dataset has a column called "year", which should appear
> on the x-axis.
>
> > ## Solution to challenge 1
> >
> > Here is one possible solution:
> >
> > 
> > 
> > ```r
> > ggplot(data = gapminder, aes(x = year, y = lifeExp)) + geom_point()
> > ```
> > 
> > ![plot of chunk unnamed-chunk-19](figure/unnamed-chunk-19-1.png)
> > 
> >
> {: .solution}
{: .challenge}

>
> ## Challenge 2
>
> In the previous examples and challenge we've used the `aes` function to tell
> the scatterplot **geom** about the **x** and **y** locations of each point.
> Another *aesthetic* property we can modify is the point *color*. Modify the
> code from the previous challenge to **color** the points by the "continent"
> column. What trends do you see in the data? Are they what you expected?
>
> > ## Solution to challenge 2
> >
> > In the previous examples and challenge we've used the `aes` function to tell
> > the scatterplot **geom** about the **x** and **y** locations of each point.
> > Another *aesthetic* property we can modify is the point *color*. Modify the
> > code from the previous challenge to **color** the points by the "continent"
> > column. What trends do you see in the data? Are they what you expected?
> >
> > 
> > 
> > ```r
> > ggplot(data = gapminder, aes(x = year, y = lifeExp, color=continent)) +
> >   geom_point()
> > ```
> > 
> > ![plot of chunk unnamed-chunk-20](figure/unnamed-chunk-20-1.png)
> > 
> >
> {: .solution}
{: .challenge}


## Layers

Using a scatterplot probably isn't the best for visualizing change over time.
Instead, let's tell `ggplot` to visualize the data as a line plot:



```r
ggplot(data = gapminder, aes(x=year, y=lifeExp, by=country, color=continent)) +
  geom_line()
```

![plot of chunk unnamed-chunk-21](figure/unnamed-chunk-21-1.png)

Instead of adding a `geom_point` layer, we've added a `geom_line` layer. We've
added the **by** *aesthetic*, which tells `ggplot` to draw a line for each
country.

But what if we want to visualize both lines and points on the plot? We can
simply add another layer to the plot:


```r
ggplot(data = gapminder, aes(x=year, y=lifeExp, by=country, color=continent)) +
  geom_line() + geom_point()
```

![plot of chunk unnamed-chunk-22](figure/unnamed-chunk-22-1.png)

It's important to note that each layer is drawn on top of the previous layer. In
this example, the points have been drawn *on top of* the lines. Here's a
demonstration:



```r
ggplot(data = gapminder, aes(x=year, y=lifeExp, by=country)) +
  geom_line(aes(color=continent)) + geom_point()
```

![plot of chunk unnamed-chunk-23](figure/unnamed-chunk-23-1.png)

In this example, the *aesthetic* mapping of **color** has been moved from the
global plot options in `ggplot` to the `geom_line` layer so it no longer applies
to the points. Now we can clearly see that the points are drawn on top of the
lines.

> ## Tip: Setting an aesthetic to a value instead of a mapping
>
> So far, we've seen how to use an aesthetic (such as **color**) as a *mapping*
> to a variable in the data. For example, when we use
> `geom_line(aes(color=continent))`, ggplot will give a different color to each
> continent. But what if we want to change the colour of all lines to blue? You
> may think that `geom_line(aes(color="blue"))` should work, but it doesn't.
> Since we don't want to create a mapping to a specific variable, we simply
> move the color specification outside of the `aes()` function, like this:
> `geom_line(color="blue")`.
{: .callout}

> ## Challenge 3
>
> Switch the order of the point and line layers from the previous example. What
> happened?
>
> > ## Solution to challenge 3
> >
> > Switch the order of the point and line layers from the previous example. What
> > happened?
> >
> > 
> > 
> > ```r
> > ggplot(data = gapminder, aes(x=year, y=lifeExp, by=country)) +
> >  geom_point() + geom_line(aes(color=continent))
> > ```
> > 
> > ![plot of chunk unnamed-chunk-24](figure/unnamed-chunk-24-1.png)
> > 
> >
> > The lines now get drawn over the points!
> >
> {: .solution}
{: .challenge}

## Transformations and statistics

ggplot also makes it easy to overlay statistical models over the data. To
demonstrate we'll go back to our first example:



```r
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp, color=continent)) +
  geom_point()
```

![plot of chunk unnamed-chunk-25](figure/unnamed-chunk-25-1.png)

Currently it's hard to see the relationship between the points due to some strong
outliers in GDP per capita. We can change the scale of units on the x axis using
the *scale* functions. These control the mapping between the data values and
visual values of an aesthetic. We can also modify the transparency of the
points, using the *alpha* function, which is especially helpful when you have
a large amount of data which is very clustered.



```r
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(alpha = 0.5) + scale_x_log10()
```

![plot of chunk unnamed-chunk-26](figure/unnamed-chunk-26-1.png)

The `log10` function applied a transformation to the values of the gdpPercap
column before rendering them on the plot, so that each multiple of 10 now only
corresponds to an increase in 1 on the transformed scale, e.g. a GDP per capita
of 1,000 is now 3 on the y axis, a value of 10,000 corresponds to 4 on the y
axis and so on. This makes it easier to visualize the spread of data on the
x-axis.

> ## Tip Reminder: Setting an aesthetic to a value instead of a mapping
>
> Notice that we used `geom_point(alpha = 0.5)`. As the previous tip mentioned, using a setting outside of the `aes()` function will cause this value to be used for all points, which is what we want in this case. But just like any other aesthetic setting, *alpha* can also be mapped to a variable in the data. For example, we can give a different transparency to each continent with `geom_point(aes(alpha = continent))`.
{: .callout}

We can fit a simple relationship to the data by adding another layer,
`geom_smooth`:


```r
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
   geom_point() + scale_x_log10() + geom_smooth(method="lm")
```

![plot of chunk unnamed-chunk-27](figure/unnamed-chunk-27-1.png)

We can make the line thicker by *setting* the **size** aesthetic in the
`geom_smooth` layer:


```r
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point() + scale_x_log10() + geom_smooth(method="lm", size=1.5)
```

![plot of chunk unnamed-chunk-28](figure/unnamed-chunk-28-1.png)


There are two ways an *aesthetic* can be specified. Here we *set* the **size**
aesthetic by passing it as an argument to `geom_smooth`. Previously in the
lesson we've used the `aes` function to define a *mapping* between data
variables and their visual representation.

> ## Challenge 4a
>
> Modify the color and size of the points on the point layer in the previous
> example.
>
> Hint: do not use the `aes` function.
>
> > ## Solution to challenge 4a
> >
> > Modify the color and size of the points on the point layer in the previous
> > example.
> >
> > Hint: do not use the `aes` function.
> >
> > 
> > 
> > ```r
> > ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
> >  geom_point(size=3, color="orange") + scale_x_log10() +
> >  geom_smooth(method="lm", size=1.5)
> > ```
> > 
> > ![plot of chunk unnamed-chunk-29](figure/unnamed-chunk-29-1.png)
> {: .solution}
{: .challenge}


> ## Challenge 4b
>
> Modify your solution to Challenge 6a so that the
> points are now a different shape and are colored by continent with new
> trendlines.  Hint: The color argument can be used inside the aesthetic.
>
> > ## Solution to challenge 4b
> >
> > Modify Challenge 6a so that the points are now a different shape and are
> > colored by continent with new trendlines.
> >
> > Hint: The color argument can be used inside the aesthetic.
> >
> >
> > 
> > ```r
> > ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp, color = continent)) +
> > geom_point(size=3, shape=17) + scale_x_log10() +
> > geom_smooth(method="lm", size=1.5)
> > ```
> > 
> > ![plot of chunk unnamed-chunk-30](figure/unnamed-chunk-30-1.png)
> >
> {: .solution}
{: .challenge}

## Multi-panel figures

Earlier we visualized the change in life expectancy over time across all
countries in one plot. Alternatively, we can split this out over multiple panels
by adding a layer of **facet** panels. Focusing only on those countries with
names that start with the letter "A" or "Z".

> ## Tip
>
> We start by subsetting the data.  We use the `substr` function to
> pull out a part of a character string; in this case, the letters that occur
> in positions `start` through `stop`, inclusive, of the `gapminder$country`
> vector. The operator `%in%` allows us to make multiple comparisons rather
> than write out long subsetting conditions (in this case,
> `starts.with %in% c("A", "Z")` is equivalent to
> `starts.with == "A" | starts.with == "Z"`)
{: .callout}


```r
starts.with <- substr(gapminder$country, start = 1, stop = 1)
az.countries <- gapminder[starts.with %in% c("A", "Z"), ]
ggplot(data = az.countries, aes(x = year, y = lifeExp, color=continent)) + 
  geom_line() + facet_wrap( ~ country)
```

![plot of chunk unnamed-chunk-31](figure/unnamed-chunk-31-1.png)

The `facet_wrap` layer took a "formula" as its argument, denoted by the tilde
(~). This tells R to draw a panel for each unique value in the country column
of the gapminder dataset.

## Modifying text

To clean this figure up for a publication we need to change some of the text
elements. The x-axis is too cluttered, and the y axis should read
"Life expectancy", rather than the column name in the data frame.

We can do this by adding a couple of different layers. The **theme** layer
controls the axis text, and overall text size, and there are special layers
for changing the axis labels. To change the legend title, we need to use the
**scales** layer.



```r
starts.with <- substr(gapminder$country, start = 1, stop = 1)
az.countries <- gapminder[starts.with %in% c("A", "Z"), ]
ggplot(data = az.countries, aes(x = year, y = lifeExp, color=continent)) +
  geom_line() + facet_wrap( ~ country) +
  xlab("Year") + ylab("Life expectancy") + ggtitle("Figure 1") +
  scale_colour_discrete(name="Continent") +
  theme(axis.text.x=element_blank(), axis.ticks.x=element_blank())
```

![plot of chunk unnamed-chunk-32](figure/unnamed-chunk-32-1.png)



> ## Challenge 5
>
> Create a density plot of GDP per capita, filled by continent.
>
> Advanced:
>  - Transform the x axis to better visualise the data spread.
>  - Add a facet layer to panel the density plots by year.
>
> > ## Solution to challenge 5
> >
> > Create a density plot of GDP per capita, filled by continent.
> >
> > Advanced:
> >  - Transform the x axis to better visualise the data spread.
> >  - Add a facet layer to panel the density plots by year.
> >
> > 
> > 
> > ```r
> > ggplot(data = gapminder, aes(x = gdpPercap, fill=continent)) +
> >  geom_density(alpha=0.6) + facet_wrap( ~ year) + scale_x_log10()
> > ```
> > 
> > ![plot of chunk unnamed-chunk-33](figure/unnamed-chunk-33-1.png)
> {: .solution}
{: .challenge}

## Geospatial datasets
Different ways to visiualize data are specified by the `geom` used in the ggplot statement.
Open community supports new and individual geoms, easily created and adapted.
Here we will have a quick look, how we can use `geom_sf` to plot geospatial datasets.


```r
# load library for spatial data
library(sf)
```

```
## Linking to GEOS 3.7.0, GDAL 2.4.0, PROJ 5.2.0
```

```r
# shape file location
shp_file_countries = "./data/Countries/cntry00.shp"

# read shapefile
shp_countries = read_sf(shp_file_countries)


# plot all data entries for 2002
countries_joined = gapminder %>%
  dplyr::rename(CNTRY_NAME = country) %>%
  dplyr::inner_join(shp_countries) %>%
  dplyr::filter(year == 2002) %>% 
  st_as_sf()
```

```
## Joining, by = "CNTRY_NAME"
```

```
## Warning: Column `CNTRY_NAME` joining factor and character vector, coercing
## into character vector
```

```r
# plot data: plain
ggplot(countries_joined) + geom_sf()
```

![plot of chunk unnamed-chunk-34](figure/unnamed-chunk-34-1.png)

```r
# plot only Europe for 2002
countries_joined = gapminder %>%
  dplyr::rename(CNTRY_NAME = country) %>%
  dplyr::inner_join(shp_countries) %>%
  dplyr::filter(year == 2002) %>%
  dplyr::filter(continent == "Europe") %>%
  st_as_sf()
```

```
## Joining, by = "CNTRY_NAME"
```

```
## Warning: Column `CNTRY_NAME` joining factor and character vector, coercing
## into character vector
```

```r
# plot data: plain
ggplot(countries_joined) + geom_sf()
```

![plot of chunk unnamed-chunk-34](figure/unnamed-chunk-34-2.png)

```r
# plot data: colour value
ggplot(countries_joined) + geom_sf(aes(fill = lifeExp))
```

![plot of chunk unnamed-chunk-34](figure/unnamed-chunk-34-3.png)


```r
# load library for spatial data
library(sf)

# shape file location
shp_file_continents = "./data/Continents/continent.shp"

# read shapefile
shp_continents = read_sf(shp_file_continents)

# join datasets
continents_joined = gapminder %>%
  dplyr::rename(CONTINENT = continent) %>%
  dplyr::right_join(shp_continents) %>%
  dplyr::filter(year == 2002) %>%
  st_as_sf()
```

```
## Joining, by = "CONTINENT"
```

```
## Warning: Column `CONTINENT` joining factor and character vector, coercing
## into character vector
```

```r
# plot data: colour value
ggplot(continents_joined) + geom_sf(aes(fill = lifeExp))
```

![plot of chunk unnamed-chunk-35](figure/unnamed-chunk-35-1.png)
> ## Challenge 6
>
> Why is the plot above flickering as it builds up? 
>
> > ## Solution to challenge 6
> >
> > Why is the plot above flickering as it builds up? 
> >
> > Because it plots the column "lifeExp" multiple times (for each country)
> > over the same polygon (Continent). The plot it not meaningful like that
> > unless we aggregate this column.
> > 
> >
> >
> > 
> > ```r
> > continents_joined %>%
> >   dplyr::group_by(CONTINENT) %>%
> >   dplyr::summarize(mean_lifeExp = mean(lifeExp, na.rm = T)) %>%
> >   dplyr::ungroup() %>%
> >   ggplot() + geom_sf(aes(fill = mean_lifeExp))
> > ```
> > 
> > ![plot of chunk unnamed-chunk-36](figure/unnamed-chunk-36-1.png)
> {: .solution}
{: .challenge}

This is a taste of what you can do with `ggplot2`. RStudio provides a
really useful [cheat sheet][cheat] of the different layers available, and more
extensive documentation is available on the [ggplot2 website][ggplot-doc].
Finally, if you have no idea how to change something, a quick Google search will
usually send you to a relevant question and answer on Stack Overflow with reusable
code to modify!

[cheat]: http://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf
[ggplot-doc]: http://docs.ggplot2.org/current/
