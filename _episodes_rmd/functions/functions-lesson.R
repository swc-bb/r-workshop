# -------------------------------------
# General function definition
# -------------------------------------

my_sum <- function(a, b) {
  the_sum <- a + b
  return(the_sum)
}

# -------------------------------------
fahr_to_kelvin <- function(temp) {
  kelvin <- ((temp - 32) * (5 / 9)) + 273.15
  return(kelvin)
}

# -------------------------------------
kelvin_to_celsius <- function(temp) {
  celsius <- temp - 273.15
  return(celsius)
}

# -------------------------------------
custom_mean = function(data_vect){
  temp  = sum(data_vect) / length(data_vect)
  return(temp)
}

# -------------------------------------
center <- function(data, desired) {
  new_data <- (data - custom_mean(data)) + desired
  return(new_data)
}
