# Simple Operations


## This is how R does addition

12 + 6

## This is how R does subtraction

12 - 6

## This is how we store data as variables
## days of the week for this current example

days <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")

# Let's find the 5th entry
days[5]

# Pull out a range of entries
days[1:3]

# Pull out the end of the week
days[5:7]

# Pull out specific days
days[c(1,2,5,7)]

# Subset our days variable and create weekdays
weekdays = days[1:5]

print(weekdays)
