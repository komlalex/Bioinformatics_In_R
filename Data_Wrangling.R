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

########################################### TIDYR
#########################################

library(tidyverse)

# How do we mke a tidy dataset? Well the tidyverse follows three rules:

#1 - Each variable must have its own column
#2 - Each observation must have its own row
#3 - Each value must have its own cell.

# It is impossible to satisfy two(2) of the three(3) rules.

# This leads to the following instructions for tidy data:

#1 - Put each dataset into a tibble 
#2 - Put each variable into a column
#3 - Profit

# Picking one consistent method of data storage makes for easier understanding of what is happening of your code and what is happening "under the hood" or behind the scenes

# Let's now look at working with tibbles

bmi <- tibble(women)

bmi %>%
  mutate(bmi = (703 * weight) / (height)^2)

######################################### SPREADING AND GATHERING
##############################

# Sometimes, you'll find datasets that don't fit well into a tibble.

# We'll use the built-in data from tidyverse for this part

table4a

# As ou can see from this data, we have one variable in column A (country) 
# but columns B and C are two of the same. Thus there are two observations in each row

# To fix this, we can use gather function

table4a %>%
  gather("1999", "2000", key = "year", value ="cases")

# Let's look at another example

table4b

# As you can see, we have the same problem in 4b
table4b %>%
  gather("1999", "2000", key="year", value = "population")

# What if we want to join these two table? We can use dplyr

table4a <- table4a %>%
  gather("1999", "2000", key ="year", value = "cases")

table4b <- table4b %>%
  gather("1999", "2000", key = "year", value = "population")

left_join(table4a, table4b)

#####################################
# SPREADING
##################################

# Spreading is the opposite of gathering. Let's look at table2

table2

# You can see that we have redundant info in columns 1 and 2
# We can fix that by combining rows 1&2, 3&4 etc

spread(table2, key =type, value = count)

# type is the key of what we are turning into columns, the value is what becomes rows

# In summary, spread makes long tables shorter and wider
# Gather makes wide tables narrower and longer.

######################################### SEPERATING AND PULL
########################################

# Now what happens when we have two observations stuck in one column

table3

# As you can see, rate is just the population and cases combined

table3 %>%
  separate(rate, into = c("cases", "population"))

# However, if you notice, column type is not correct
  table3 %>%
    separate(rate, into = c("cases", "population"), convert = TRUE)

# You can specify what you want to separate based on 

  table3 %>%
    separate(rate, into = c("cases", "population"), sep="/", convert = TRUE)

# Let's make this look more tidy

  
  table3 %>%
    separate(
      year, 
      into = c("century", "year"),        convert = TRUE,
      sep=2)

######################################### UNITE
########################################
  
  # What happens if we want to do the opposite of separate
table5

table5 %>%
  unite(date, century, year, sep = "", na.rm = FALSE)

######################################### MISSING VALUES
#######################################

# There are two types of missing values: NA (explicit) or just no entry (implicit)

gene_data <- tibble(
  gene = c("a", "a", "a", "a", "b", "b", "b"),
  nuc = c(20, 22, 24, 25, NA, 42, 67),
  run = c(1,2,3,4,2,3,4)
  
)

gene_data

# The nucleotide count for gene b, run 2 is explicit missing
# The nucleotide count for gene b run 1 is implicit.

# one way we can make implicit missing values explicit is by putting runs in the column

gene_data %>%
  spread(gene, nuc)

# We want to remove the missing values, we can use spread and remove, and na.rm = TRUE

gene_data %>% 
  spread(key = gene, value = nuc) %>%
  gather(gene, nuc, "a":"b", na.rm = TRUE)
  
# Sometimes, an NA is present to represent a value being carried forward

treatment <- tribble(
  ~person, ~treatment, ~response,
  ################################
  "Isaac",  1,          7,
  NA,       2,          10,
  NA,       3,          9,
  "VDB",    1,          8,
  NA,       2,          11,
  NA,       3,          10
  )

treatment

# What we can do here is use the fill option
treatment %>%
  fill(person)
