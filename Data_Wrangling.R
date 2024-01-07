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

######################################### PIPING
########################################

# with tibble datasets (more on them soon), we can pipe results to get rid of the need to use $ sign
# We can then summarize the number of flights by minutes delayed

my_data %>%
  group_by(year, month, day) %>%
  summarise(mean = mean(dep_time, na.rm = TRUE))

########################################### TIBBLES
#########################################
library(tibble)
# Now we will take the time to explore tibbles. Tibbles are modified data frames which tweak some of the older features from frames. R is an old language, and useful things from 20 years ago are not useful anymore.

as_tibble(iris)

# As we can see, we have the same data frame, but we have different features.

# You can also create a tibble from scratch with tibble()
tibble(
  x = 1:5,
  y = 1,
  z = x^2 + y
)

# We can also use tribble() for basic data creation
tribble(
  ~genea, ~geneb, ~genec,
  #####################
  110, 112, 114,
  6, 5, 4
)

# Tibbles are built to not overwhelm your console when printing data, only showing the first few lines.

# This is how data frames prints
print(by_day)
as.data.frame(by_day)
head(by_day)

nycflights13::flights %>%
  print(n=10, width=Inf)


########################################### SUBSETTING TIBBLES
######################################

# Subsetting tibbles is easy, similar to data.frames
df_tibble <- tibble(nycflights13::flights)

df_tibble

# We can subset by column name using the $
df_tibble$carrier

# We can subset by position using [[]]
df_tibble[[2]]

# If you want to use this in a pipe, you need to use the "." placeholder

df_tibble %>%
  .$carrier

# Some older functions do not like tibles. Thus you might have to convert them back to data.frames
class(df_tibble)

df_tibble2 <- as.data.frame((df_tibble))

class(df_tibble2)

head(df_tibble)

head(df_tibble2)
