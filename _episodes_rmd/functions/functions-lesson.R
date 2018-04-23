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

# -------------------------------------
custom_mean <- function(data_vect){
  temp <- sum(data_vect) / length(data_vect)
  return(temp)


# -------------------------------------
center <- function(data, desired) {
  new_data <- (data - custom_mean(data)) + desired
  return(new_data)
}
