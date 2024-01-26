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

# List and Data Frames
HSPA1A <- list(gene = "HSPA1A",amino.acids = 641, nucleotides = 2400)
print(HSPA1A)

# Let's pull out just the amino acids
HSPA1A$amino.acids

# Let's create three(3) lists and combine them into data frames
gene <- c("HSPA4", "HSPA5", "HSPA8", 'HSPA9', 'HSPA1A', "HSPA1B")

nucleotides <- c(54537, 6491, 4648, 21646, 2400, 2517)

aminoAcids <- c(840, 654, 493, 679, 641, 641)

HSPs <- data.frame(gene, nucleotides, aminoAcids)

# Let's pull out just the genes
HSPs$genes

# Let's pull out just the nucleotides
HSPs$nucleotides

# Let's search for a specific gene
HSPs$aminoAcids[HSPs$gene == "HSPA8"]

# OBJECT CLASSES

print(gene)
print(HSPs)

class(HSPs$gene)
class(HSPs$nucleotides)
class(HSPs$aminoAcids)

x <- 15+ 38
x
class(x)

z <- as.character(c(1,2,3,4,5,6))
z

class(z)

y <- as.character(c(9,8,7,6,5,4,3,2,1))
y + z

z2 <- c(1,2,3,4,5,6) 
y2 <- c(9,8,7,6,5,4)

z2 + y2

class(z2)

class(HSPs)

y = as.numeric(y)
class(y)

a = TRUE
class(a)

class(exampleFunction)

# MODELS AND FORMULAS
# y ~ x1 + x2

dataset <- iris

# Let's look at the top few rows
head(dataset)

# Let's look at the bottom few rows
tail(dataset)

dataset

# Let's look at the total number of rows in our dataset
nrow(dataset)

# Let's look at the total number of columns in our dataset
ncol(dataset)

# Let's start a simple linear model
petals.lm <- lm(formula = Petal.Length ~ Petal.Width, data = dataset)
petals.lm
summary(petals.lm)

# CHARTS AND GRAPHS
names(iris)


hist(iris$Sepal.Length)

# Let's increase the number of bins in our histogram
hist(iris$Sepal.Length, breaks = 25)

# Let's add some labels
hist(iris$Sepal.Length, breaks = 25, xlab="Sepal Length", main = "Sepal Length Frequency")

plot(iris$Sepal.Length ~ iris$Sepal.Width, xlab = "Sepal Length", ylab = "Sepal Width")

library(lattice)

# Let's use the lattice dotplot
dotplot(Sepal.Width ~ Sepal.Length|Species, data = iris)

# Let's use the lattice dotplot to look at petal length vs width
dotplot(Petal.Length ~ Petal.Width|Species, data = dataset)

#################################
# Stringr
##############################

library(tidyverse)
library(stringr)

# You can create strings using double or single quotes
str1 <- "This is a string"
str2 <- 'This is also a "string"'

str2

# If you forget to close the string, you get this 
str3 <- "where is this going?"
str3

# Just hit the escape and try again

# multiple strings are stored in character vectors
str4 <- c("one", "two", "three")
str4

# measuring string length
str_length(str3)
str_length(str4)

# Let's combine two strings
str_c("x", "y")
str_c(str1, str2)

# You can use sep to control how they are seperated
str_c(str1, str2, sep = " ")

str_c("x", "y", "c", sep = "_")

################################################ Subsetting strings
###############################################

HSP <- c("HSP123", "HSP234", "HSP456")
str_sub(HSP, 4,6)

# This just drops the first four letters from the string
# Or you can use negetives to count from the end
str_sub(HSP, -3, -1)

# you can convert the cases of strings like follows:
HSP
HSP_Lower <- str_to_lower(HSP)

str_to_upper(HSP_Lower)


################################################ Regualar Expressions
install.packages("htmlwidgets")
########################################

x <- c("ATTAGA", "CGCCCCCGGAT", "TATTA")
str_view(x, "TA")

# The next step is , "." where the "." matches an entry
str_view(x, ".G.")

# Anchors allow you to match at the start or the ending
str_view(x, "^TA")
str_view(x, "TA$")

# Character classes/alternatives
#\d matches any digit
#\s matches any space
#[abc] matches a, b and c
str_view(x, "TA[GT]")
# [^anc] matches anything but, a, b, or c
str_view(x, "TA[^T]")

# You can also use the | to pick between two alternatives
str_view(x, "TA[G|T]")

################################################ Detecting Matches
#######################################
# str_match() returns a logical vector the same length  of input 
y <- c("apple", "banana", "pear")
y
str_detect(y, "e")

# How many words start with letter e
words

sum(str_detect(words, "^e"))

# Let's get more complex,what proportion of words end in a vowel?

mean(str_detect(words, "[aeiou]$"))

# What proportion of words do not start with a vowel

mean(str_detect(words, "^[^aeiou]"))

# Lets find all the words that don't contain o or u
no_ou <- !str_detect(words, "[ou]")
no_ou

# Now let's extract 
words[!str_detect(words, "[ou]")]

# you can also use str_count to say how many matches there are in string
str_count(x, "[GC]")

# Let's couple this with mutate
df <- tibble(
  word = words,
  index = seq_along(word)
)

df

df %>%
  mutate(vowels = str_count(words, "[aeiou]"),
  consonants = str_count(words, "[^aeiou]"))
