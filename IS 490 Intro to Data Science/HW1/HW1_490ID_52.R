# HW 1 Due Monday Sept 18, 2017. Upload R file or notebook to Moodle with 
# filename: HW1_490ID_YOURUNI.R
# Do Not remove any of the comments. These are marked by #

###Your Unique Class ID: 52

# 1.
# Load the data for this assignment into your R session 
# with the following command:

library(ggplot2)
data(diamonds)

#(1). Check to see that the data were loaded by running:
objects(diamonds)
# This should show ten variables: 
# carat, clarity, color, cut, depth,
# price, table, x, y, z

#(2). Use the nrow() function to find out how many observations there are.
nrow(diamonds) # 53940 rows

# For the following questions, use one of: head(), summary(),
# class(), min(), max(), hist(), quantile(), table() 
# to answer the questions.

#(3). Show the summary or the structure of this dataset.
summary(diamonds) # summary : 

dim(diamonds)  # Rows: 53940, Columns: 10

#(4). List the categorical variables in this dataset.
objects(diamonds)

#(5). What was the highest price of the diamonds ?
max(diamonds$price) # 18823

#(6). What was the average price of the diamonds ?
mean(diamonds$price) #3932.8

#(7). What is the number of the Ideal cut ?
table(diamonds$cut == "Ideal") # TRUE == Ideal : 21551
summary(diamonds$cut) # Ideal : 21551

#(8). What is the number of the diamonds which are Premium and have a clarity level
#     of IF?
summary(diamonds$clarity == "IF" & diamonds$cut == "Premium") # True: 230


#(9). What is the averge price difference between the clarity level SI2 and IF?
#     Hint(Use aggregate())
#     1.
SI2.price = diamonds$price[diamonds$clarity == "SI2" ]
IF.price = diamonds$price[diamonds$clarity == "IF"]
SI2.price.avg = sum(SI2.price) / length(SI2.price)
IF.price.avg = sum(IF.price) / length(IF.price)
abs(SI2.price.avg - IF.price.avg)  # 2198.189
#     2.
aggr = aggregate(diamonds$price, by = list(diamonds$clarity), FUN=mean)
class(aggr) # data.frame
abs(aggr$x[aggr$Group.1 == "IF"] - aggr$x[aggr$Group.1 == "SI2"]) # 2198.189

#(10). Total depth percentage is represented as the depth divided by
#      the mean of the length and width of the diamond, 
# (11).
# Try running each expression in R.
# Record the error message in a comment
# Explain what it means. 
# Be sure to directly relate the wording of the error message with the problem you find in the expression.
z/mean(x, y)

### Error message here
#         Error: object 'z' not found
### Explanation here
# sdfghjkl;kjhgfdsdfghjk@!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

diamonds$z/(mean(diamonds$x, diamonds$y))
### Error message here
        #Error in mean.default(diamonds$x, diamonds$y) : 
        #'trim' must be numeric of length one
### Explanation here
#       !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

diamonds$z/(rowMeans(diamonds$x, diamonds$y))
### Error message here
        #Error in rowMeans(diamonds$x, diamonds$y) : 
        #  'x' must be an array of at least two dimensions
### Explanation here
#       !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

#(12).Study the following code about how to do the compution 
# calculation that we want for the previous question.
Depth <- (diamonds$z)/rowMeans(cbind(diamonds$x, diamonds$y))

#(13). Can you get the same result without using function?
#	      Given an expression to it.  Name the values Depth1
Depth1 = diamonds$z/ (diamonds$y + diamonds$x/((length(diamonds$y) + length(diamonds$x))))

#(14) What did you get from 
all.equal(Depth, Depth1)
#         "Mean relative difference: 0.004049661"

# 2. Run the following code to make a plot.
# (don't worry right now about what this code is doing)

plot(diamonds[1:1000,]$carat, diamonds[1:1000,]$price, xlab = "Carat", ylab = "Price", main = "Carat vs Price")

# (1) Use the Zoom button in the Plots window to enlarge the plot.
# Resize the plot so that it is long and short, so it is easier to read.
# Include this plot in the homework your turn in.
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!aadsasdasdsaaadadsdsaads~~~~~~=====!!!!!!
# (2) Make an interesting observation about the relation between
#     Carat and Price based on this plot 
# (something that you couldn't see with the calculations so far.)

### Your answer goes here
  
#  "The prices of diamonds with carat weight below around the weight of 0.5 carat
#  prices range about from 200 to 600. As for the carat weight above 0.5 carat,
#  the price ranges around 2700 to about 2950 which has a smaller range than diamonds that weigh less than 0.5 carat.
#  Also, the relation between price and carat of the diamond doesn't seem to have any correlation, as the price
#  of the diamonds don't really correspond to the carat weight of the diamond for those below and above 0.5 carat weight respectively."
  
# (3) What interesting question about the diamonds
# would you like to answer with these data, but don't yet know 
# how to do it? 

### Your answer goes here

#  "I would like to know from the data, how likely and what is the probability of a diamond 
#   having a higher price with a lower weight in weights larger than 0.5 carat be?"
!!!!!!!!!!!!!
#   " To answer this question, I would have to count the fraction of the number of diamonds with a higher price per carat
#   " than those that are heavier than itself."
!!!!!!!!!!!!
  
# For the remainder of this assignment we will work with 
# one of the random number generators in R.

# 4.
# Use the following information about you to generate some random values:
#a. Use you UIN number to set the seed in set.seed() function.
set.seed(665363548)
#b. Use your birthday month for the mean of the normal.
mean = 3
#c.	Use your birthday day for the standard deviation (sd) of the normal curve.
sd = 19
#d.	Generate 10 random values using the parameters from b and c.
rnorm(10, mean = 3, sd = 19)
#e.	Assign the values to a variable named with your first name.
Roger = rnorm(10, mean = 3, sd = 19)
#f.	Provide/Show the values generated.
Roger 
# [1]  16.0435819  -8.7419770   1.4455514   1.6544967  12.3591525 -50.8375381
# [7]  -0.3500531 -15.4846238  15.7315860  -6.9326284

# 5.
#(1). Generate a vector called "normsamps" containing
# 100 random samples from a normal distribution with
# mean 5 and SD 2.
normsamps = rnorm(100, mean = 5, sd = 2)

#(2). Calculate the mean and sd of the 100 values.
normsamps.mean = mean(normsamps) # [1] 4.956662
normsamps.sd = sd(normsamps) # [1] 1.949206
### The return values from your computation go here
# Mean = 4.956662
# SD = 1.949206

# (3). Use implicit coercion of logical to numeric to calculate
# the fraction of the values in normsamps that are more than 8.
length(normsamps[normsamps > 8]) / length(normsamps) # 0.07

# (4). Look up the help for rnorm.
# You will see a few other functions listed.  
# Use one of them to figure out about what answer you 
# should expect for the previous problem.  
# That is, find the area under the normal(5, 2) curve
# to the right of 8.  This should be the chance of getting
# a random value more than 8. 


# What value do you expect? 
 # expected with a 50 % + 34% + 11% making it close to 0.95
# What value did you get? 
pnorm(8, mean = 5, sd = 2)
#     0.9331928
# Why might they be different?
# computer calculations are way more precise than a human mind !!!

