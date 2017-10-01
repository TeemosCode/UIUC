# HW 3 - Due Monday  Oct 2, 2017. Upload R file to Moodle with name: HW3_490IDS_YOURCLASSID.R
# Do Not remove any of the comments. These are marked by #
# The .R file will contain your code and answers to questions.

#ClassID: 52

# Main topic: Using the "apply" family of functions

#Q1 (5 pts)
# Given a function below,
myfunc <- function(z) return(c(z,z^2,(z^2+z)%/%2))
#(a) explain in words what myfunc is doing.

### Your explanation here
# Ans:
#   The 'myfunc' function takes in an argument 'z' and returns a numeric vector containing the value
#   of z, z square and the modulo 2 of z square plus z.

#(b) Examine the following code, and briefly explain what it is doing.
y = 1:8
myfunc(y)
matrix(myfunc(y),ncol=3)

### Your explanation here
# Ans:
#   First it creates a numeric vector containing the integer values of 1 to 8 and 
#   assign this vector to the variable 'y'.
#   Then it passes the 'y' variable to the 'myfunc' function as its argument, with 
#   'myfunc' function performing its defined calculation on the 'y' variable.
#   Finally, it uses the built-in 'matrix' function to create a matrix with 3 columns based
#   on the numeric vector calculated and returned by the 'myfunc' function.


#(c) Simplify the code in (b) using one of the "apply" functions and save the result as m.
###code & result
# m = t(sapply( y, myfunc))
m = matrix(sapply(c(1:8), myfunc), ncol = 3, byrow=T)
# Result:
# > m = matrix(sapply(c(1:8), myfunc), ncol = 3, byrow=T)
# > m
#     [,1] [,2] [,3]
# [1,]    1    1    1
# [2,]    2    4    3
# [3,]    3    9    6
# [4,]    4   16   10
# [5,]    5   25   15
# [6,]    6   36   21
# [7,]    7   49   28
# [8,]    8   64   36


#(d) Find the column product of m.
###code & result
apply(m, 2, prod)
# Results:
# > apply(m, 2, prod)
# [1]      40320 1625702400   57153600
# Meaning, column1 product=40320, column2 product=1625702400, column3 product=57153600

column.product = function(matrix.param, colnums.vector){
  ans = colnums.vector
  for(colnums in colnums.vector){
    col.pro = 1
    for(num in matrix.param[,colnums]){
      col.pro = col.pro * num
    }
    ans[colnums] = col.pro
  }
  return(ans)
}
m.col.product = column.product(m, 1:ncol(m))
#Results:
# Each index of the vector matches the column number in matrix 'm'
# > m.col.product = column.product(m, 1:ncol(m))
# > m.col.product
# [1]      40320 1625702400   57153600
# Meaning, column1 product=40320, column2 product=1625702400, column3 product=57153600


#(e) Find the row sum of m in two ways.
###code & result
# First way
row.sum = function(matrix.param, rownums.vector){
  ans = rownums.vector
  for(rownums in rownums.vector){
    row.sum = 0
    for(num in matrix.param[rownums,]){
      row.sum = row.sum + num
    }
    ans[rownums] = row.sum
  }
  return(ans)
}
m.row.sum = row.sum(m, 1:nrow(m))

#Result1:
# Each index of the vector matches the row number in matrix 'm'
# > m.row.sum = row.sum(m, 1:nrow(m))
# > m.row.sum
# [1]   3   9  18  30  45  63  84 108
# Meaning, row1 sum=3, row2 sum=9, row3 sum=18, row4 sum=30, row5 sum=45, row6 sum=63
# row7 sum=84, row8 sum=108

# Second way:
row.sum = apply(m, 1, sum)
row.sum

#(f) Multiple all the values by 2 in two different ways:
### 1. code & result
matrix(sapply(m, function(x) x*2), ncol = 3)
# Result1:
# > matrix(sapply(m, function(x) x*2), ncol = 3)
#      [,1] [,2] [,3]
# [1,]    2    2    2
# [2,]    4    8    6
# [3,]    6   18   12
# [4,]    8   32   20
# [5,]   10   50   30
# [6,]   12   72   42
# [7,]   14   98   56
# [8,]   16  128   72

### 2. code & result
matrix.times2 = function(matrix.varname, matrixrow.vector, matrixcol.vector){
  for(row in matrixrow.vector){
    for(col in matrixcol.vector){
      matrix.varname[row, col] = matrix.varname[row, col] * 2
    }
  }
  return(matrix.varname)
}

m.times2 = matrix.times2(m, 1:nrow(m), 1:ncol(m))
m.times2
# Result2:
# > m.times2 = matrix.times2(m, 1:nrow(m), 1:ncol(m))
# > m.times2
#      [,1] [,2] [,3]
# [1,]    2    2    2
# [2,]    4    8    6
# [3,]    6   18   12
# [4,]    8   32   20
# [5,]   10   50   30
# [6,]   12   72   42
# [7,]   14   98   56
# [8,]   16  128   72

m * 2

#Q2 (10 pts)
#Create a list l with 2 elements as follows:
l <- list(a = 1:10, b = 21:30)

#(a) What is the sum of the values in each element?
###code & result
lapply(l, sum)
# Result:
# > lapply(l, sum)
# $a
# [1] 55
# 
# $b
# [1] 255
# Ans: For a, the sum is 55. For b, the sum is 255.


#(b) What is the (sample) variance of the values in each element?
###code & result
lapply(l, var)
#  Result:
# > lapply(l, var)
# $a
# [1] 9.166667
# 
# $b
# [1] 9.166667
#  Ans: For a, the variance is 9.166667. For b, the variance is 9.166667.


#(c) Use the help() function to check what type of output object will you expect if you use sapply and lapply. 
# Show your R code that finds these answers and briefly explain if the results agree with your expectation.

###code
help(sapply)
help(lapply)
lapply(l, sum)
sapply(l, sum)
class(lapply(l, sum))
class(sapply(l, sum))


###written explanation

# The output answer of the R Documentation:
# Description
# 
# lapply returns a list of the same length as X, 
# each element of which is the result of applying FUN to the corresponding element of X.
# 
# sapply is a user-friendly version and wrapper of lapply by default returning a vector, matrix or, 
# if simplify = "array", an array if appropriate, by applying simplify2array(). 
# sapply(x, f, simplify = FALSE, USE.NAMES = FALSE) is the same as lapply(x, f).

# With the above code. The outputs are:
# > lapply(l, sum)
# $a
# [1] 55
# 
# $b
# [1] 255
# 
# > sapply(l, sum)
# a   b 
# 55 255 
# > class(lapply(l, sum))
# [1] "list"
# > class(sapply(l, sum))
# [1] "integer"
# From the above we can see that lapply returns a list and sapply returns a integer vector. Thus,
# the result does agree with my expectation.


#(d) Change one of them to make the two statement return the same results (type of object):
###code & result

lapply(l, sum)
lapply(l, var)
class(lapply(l, sum))
class(lapply(l, var))

as.list(sapply(l, sum))
as.list(sapply(l, var))
class(as.list(sapply(l, sum)))
class(as.list(sapply(l, var)))
# Results:
# > lapply(l, sum)
# $a
# [1] 55
# 
# $b
# [1] 255
# 
# > lapply(l, var)
# $a
# [1] 9.166667
# 
# $b
# [1] 9.166667
# 
# > class(lapply(l, sum))
# [1] "list"
# > class(lapply(l, var))
# [1] "list"
# 
# Both statements have the same class of "list" when both use lapply.
# > as.list(sapply(l, sum))
# $a
# [1] 55
# 
# $b
# [1] 255
# 
# > as.list(sapply(l, var))
# $a
# [1] 9.166667
# 
# $b
# [1] 9.166667
# 
# > class(as.list(sapply(l, sum)))
# [1] "list"
# > class(as.list(sapply(l, var)))
# [1] "list"
# As we can see, coericing sapply to list with as.list still has the same value and with a same type: list.


# Now create the following list:
l.2 <- list(c = c(11:20), d = c(31:40))
#(e) What is the sum of the corresponding elements of l and l.2, using one function call? Your result should be a 
# single vector with length 10.
###code & result
mapply(sum, l$a, l$b, l.2$c, l.2$d)


#(f) Take the log of each element in the list l:
###code & result
sapply(l, log)
# Result:
# > sapply(l, log)
# a        b
# [1,] 0.0000000 3.044522
# [2,] 0.6931472 3.091042
# [3,] 1.0986123 3.135494
# [4,] 1.3862944 3.178054
# [5,] 1.6094379 3.218876
# [6,] 1.7917595 3.258097
# [7,] 1.9459101 3.295837
# [8,] 2.0794415 3.332205
# [9,] 2.1972246 3.367296
# [10,] 2.3025851 3.401197


#(g) First change l and l.2 into matrixes, make each element in the list as column,
###code & result
l = matrix(c(l$a, l$b), ncol = 2 )
l.2 = matrix(c(l.2$c, l.2$d), ncol = 2)



#Then, form a list named mylist using l,l.2 and m (from Q1) (in that order).
###code & result
mylist = list(l, l.2, m)


#Then, select the second column of each elements in mylist in one function call (hint '[' is the select operator).
###code & result
!!!!!!!!!!!!!!!!!!!!!!!!
mapply()



#Q3 (3 pts)
# Let's load the family data again.
load(url("http://courseweb.lis.illinois.edu/~jguo24/family.rda"))
#(a) Find the mean bmi by gender in one function call.
###code & result #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
aggregate(family$bmi, by = list(family$gender), FUN = mean)
# Result:
# > aggregate(family$bmi, by = list(family$gender), FUN = mean)
# Group.1        x
# 1       m 25.73898
# 2       f 23.02564
# Ans: Male's mean bmi is 25.73898.
#      Female's mean bmi is 23.02564.


#(b) Could you get a vector of what the type of variables the dataset is made of???
###code & result
sapply(family, class)
# Result:
# > sapply(family, class)
# firstName    gender       age    height    weight       bmi    overWt 
# "factor"  "factor" "integer" "numeric" "integer" "numeric" "logical"
class(sapply(family, class))
# Result:
# > class(sapply(family, class))
# [1] "character" 
# The sapply(family, class) returns a vector of the types of each variables in the family dataset.
# Each type of the variable is written under the variable name.


#(c) Could you sort the firstName in bmi descending order?
###code & result
#!!!!!!!!!!!!!!!!!!!!!!!!
family[sort(family$bmi, decreasing = T), "firstName"]
aggregate(family$bmi, by = list(family$gender), FUN = mean)


#Q4 (2 pts)
# There is a famous dataset in R called "iris." It should already be loaded
# in R for you. If you type in ?iris you can see some documentation. Familiarize 
# yourself with this dataset.
#(a) Find the mean petal width by species.
### code & result
aggregate(iris$Petal.Width, by = list(iris$Species), FUN = mean)
# Result:
# > aggregate(iris$Petal.Width, by = list(iris$Species), FUN = mean)
# Group.1     x
# 1     setosa 0.246
# 2 versicolor 1.326
# 3  virginica 2.026
# Ans: The mean of petal width with the species:
      # setosa = 0.246
      # versicolor = 1.326
      # virginica = 2.026


#(b) Now obtain the mean of the first 4 variables, by species, but using only one function call.
### code & result
#!!!!!!!!!!!!
aggregate(iris, by = list(iris$Species), FUN = mean)

#Q5. (5 pts) Now with the "iris" data, fit a simple linear regression model using lm() to predict 
# Petal length from Petal width. Place your code and output (the model) below. 
lm(iris$Petal.Length ~ iris$Petal.Width, data = iris)

# Output:
# > lm(iris$Petal.Length ~ iris$Petal.Width, data = iris)
# 
# Call:
#   lm(formula = iris$Petal.Length ~ iris$Petal.Width, data = iris)
# 
# Coefficients:
#     (Intercept)  iris$Petal.Width  
#           1.084             2.230  

# How do you interpret this model?
# From the output we can see the intercept is 1.084 and the coefficient of the "iris" Petal width data is 2.230.
# Which means that the predicted iris petal length increases by 2.230 for every unit increase in petal width, and that they are positively correlated.
# From the output we can also tell that the complete regression equation is "iris_Petal_length = 2.23 * iris_Petal_width + 1.084".

# Create a scatterplot of Petal length vs Petal width. Add the linear regression line you found above.
# Provide an interpretation for your plot.
### code & result
plot(iris$Petal.Width, iris$Petal.Length, main = "IRIS Petal Width vs Petal Length",
     xlab="Petal Width", ylab="Petal Length")
abline(lm(iris$Petal.Length ~ iris$Petal.Width, data = iris), col = 'blue', lwd= 2)
