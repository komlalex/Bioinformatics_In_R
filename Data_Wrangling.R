# DATA WRANGLING WITH R

library(tidyverse)

my_data <- nycflights13::flights

head(my_data)
tail(my_data)

# First we will just look at the data on the October 14th

filter(my_data, month == 10, day == 14)

# If we want to subset into a new variable, we do the following

october_14_flights <- filter(my_data, month == 10, day == 14)

# What if we want to do both print and save variable at once

(october_14_flights2 <- filter(my_data, month == 10, day == 14))

# If you want to filter based on different operators, you can use the following:

# Equals: ==
# Not equal to: !=
# Greater than: >
# Less than: <
# Greater than or equal to: >=
# Less than or equal to: <=

(flights_through_september <- filter(my_data, month < 10))



# If we don't use the == to mean equals, we get this:
#(October_14_flights2 <- filter(my_data, month = 10, day = 14))

# We can also use logical operators to be more selective
# And: &
# Or: |
# Not !

# Let's use "or" function to pick flights in March and April
March_April_Flights <- filter(my_data, (month == 3 | month == 4))

March_April_Flights2 <- filter(my_data, month == 3 & day == 4)

Non_Jan_Flights = filter(my_data, month != 1)

