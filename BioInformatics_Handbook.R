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

# Let's start with the array function
months <- array(c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"), dim = c(3,4) )
months[2,3]
months[2, ]
months[,2]
# Compare it to a simple list function
months1 <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")

months1

# Let's now look at a matrix
months2 = matrix(data = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"), nrow = 3, ncol = 4)

months2

# making a 3d array
array3d <- array(data = c(2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36), dim = c(3,3,2))

array3d

array3d[1,3,2]
array3d[,3,2]

# If you want to pull an entire row or col
array3d[2,,1]
array3d[,3,2]
array3d[2,2,]





















