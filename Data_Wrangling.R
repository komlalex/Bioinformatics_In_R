# DATA WRANGLING WITH R

library(tidyverse)

my_data <- nycflights13::flights

head(my_data)
tail(my_data)

######################################
# FILTERING
#####################################
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

#########################################ARRANGE
###########################################

# Arrange allows us to arrange the dataset based on the variables we desire
arrange(my_data, year, day, month)

# We can also arrange in descending fashion
desc_data <- arrange(my_data, desc(year), desc(day), desc(month))

# Missing values a always placed at the end of the data frame regardless of whether we are arranging in ascending or descending order

####################################### SELECT #################################

# we can also select specific columns that we want to look at

calender <- select(my_data, year, month, day)

# We also look at a range of columns
calender2 <- select(my_data, year:day)

# Let's look at all columns, month through carrier
calender3 <- select(my_data, month:carrier)

# We also choose which columns not to include
everythingelse <- select(my_data, -(year:day))

# In this case, we can also use the NOT (!)  operator

everythingelse2 <- select(my_data, !(year:day))    

# There also some other helper functions that can help you select the columns or data you desire:

# starts_with("xyz") -- will select the values that start with xyz.
days_only <- select(my_data, starts_with("day"))

# ends_with("xyz)
months_only <- select(my_data, ends_with("th"))

# contains("xyz)
contains_dep <- my_data %>% select(contains("dep"))

# matches("xyz) : Matches identically value xyz
matches_day <- select(my_data, matches("day"))

####################################### RENAMING
#####################################
new_data = rename(my_data, depature_time = dep_time)


###################################### MUTATE
####################################

# Let's add new columns to our data? We have the mutate function for that.

# First let's make a smaller data frame so we can see what we're doing
my_small_data <- select(my_data, year:day, distance, air_time)

# Let's calculate the speed of the flight

mutant_data <- mutate(my_small_data, speed = distance / air_time * 60 )

# What if we want to create a new data frame with ONLY the calculation? (transmute)
airspeed <- transmute(my_small_data, speed = distance / air_time * 60,  speed2 = distance / air_time, PI = 3.14)

############################################ SUMMARIZE and by_group()
###########################################

# We can use summarize to run a function on a data column to get a single return
data_summary <- summarise(my_data, delay = mean(dep_delay, na.rm = TRUE))

# So we can see that the average delay is about 12 minutes

# We gain additional value in summarize by pairing it with by_group()

by_day <- group_by(my_data, year, month, day)

data_summary_by_day <- summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))

# As you can see, we now have the delays by the days of the year

############################################ MISSING DATA
###########################################

# What happens if we don't tell R what to do with missing data
new_summary <- summarise(my_data, delay = mean(dep_delay))

# We can also filter our data based on NA
not_cancelled <- filter(my_data, !is.na(dep_delay), !is.na(arr_delay))

summarise(not_cancelled, delay = mean(dep_delay))

######################################### COUNTS
#######################################

# We can also count the number of variables that are in our dataset
sum(is.na(my_data$dep_delay))

# We can also count the numbers that are NOT NA
sum(!is.na(my_data$dep_delay))
