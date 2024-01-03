# SIMPLE OPERATION


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

# FUNCTIONS
## f (argument1, argument2, ...)
## where f is the name of the function, and argument1, 2 etc are the
## different conditions we are asking our function to evaluate

exampleFunction <- function(x,y) {
  vec = c(x+ 1, y + 10)
  return(vec)
}

exampleFunction(10, 10)

# Example built-in functions
exp(2)

# tangents
tan(2)

# log(12)
log(12)

log(x=12, base = 4)
log(12,4)

?exp

# DATA STRUCTURES
months <- array(c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"), dim = c(3,4) )




























