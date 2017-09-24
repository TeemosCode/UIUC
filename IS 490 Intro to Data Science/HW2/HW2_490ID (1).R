# HW 2 Due Monday Sept 25, 2017. Upload R file to Moodle with name: HW1_490ID_CLASSID.R
# You can upload plots to Moodle in separate files and refer to them in your R file, or use an 
# R notebook http://rmarkdown.rstudio.com/r_notebooks.html

# Do not remove any of the comments. These are marked by #

### Class ID:   52

# In this assignment you will practice how to manipulate a dataframe, 
# such as taking subsets and creating new variables, with the goal of creating a plot.

# You will work with the mtcars data in R library and a dataset called SFHousing. 

# Before beginning with the housing data however, you will do some warm up 
# exercises with the small mtcars data set.

# PART 1. mtcars Data
# Q1.(2 pts.)
# Use R to generate descriptions of the mtcars data which is already included in R base. 
# The description could be a summary of each column and the dimensions of the dataset (hint: 
# you may find the summary() command useful). Write up your descriptive findings and observations
# of the R output.

### Your code below
data(mtcars) # load in the mtcars data
class(mtcars) # [1] "data.frame"
names(mtcars) # [1] "mpg"  "cyl"  "disp" "hp"   "drat" "wt"   "qsec" "vs"   "am"   "gear" "carb"
dim(mtcars) # [1] 32 11
summary(mtcars) #
head(mtcars, 5) #
help(mtcars) #

#---------------------------------
### Your answer here
  # column names of mtcars : [1] "mpg"  "cyl"  "disp" "hp"   "drat" "wt"   "qsec" "vs"   "am"   "gear" "carb"
  # 
  # > summary(mtcars)
  # mpg             cyl             disp             hp             drat      
  # Min.   :10.40   Min.   :4.000   Min.   : 71.1   Min.   : 52.0   Min.   :2.760  
  # 1st Qu.:15.43   1st Qu.:4.000   1st Qu.:120.8   1st Qu.: 96.5   1st Qu.:3.080  
  # Median :19.20   Median :6.000   Median :196.3   Median :123.0   Median :3.695  
  # Mean   :20.09   Mean   :6.188   Mean   :230.7   Mean   :146.7   Mean   :3.597  
  # 3rd Qu.:22.80   3rd Qu.:8.000   3rd Qu.:326.0   3rd Qu.:180.0   3rd Qu.:3.920  
  # Max.   :33.90   Max.   :8.000   Max.   :472.0   Max.   :335.0   Max.   :4.930  
  # wt             qsec             vs               am              gear      
  # Min.   :1.513   Min.   :14.50   Min.   :0.0000   Min.   :0.0000   Min.   :3.000  
  # 1st Qu.:2.581   1st Qu.:16.89   1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:3.000  
  # Median :3.325   Median :17.71   Median :0.0000   Median :0.0000   Median :4.000  
  # Mean   :3.217   Mean   :17.85   Mean   :0.4375   Mean   :0.4062   Mean   :3.688  
  # 3rd Qu.:3.610   3rd Qu.:18.90   3rd Qu.:1.0000   3rd Qu.:1.0000   3rd Qu.:4.000  
  # Max.   :5.424   Max.   :22.90   Max.   :1.0000   Max.   :1.0000   Max.   :5.000  
  # carb      
  # Min.   :1.000  
  # 1st Qu.:2.000  
  # Median :2.000  
  # Mean   :2.812  
  # 3rd Qu.:4.000  
  # Max.   :8.000  

# > head(mtcars, 5)
# mpg cyl disp  hp drat    wt  qsec vs am gear carb
# Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
# Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
# Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
# Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
# Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
#-----------------------------

# > help(mtcars)
# A data frame with 32 observations on 11 variables.
# 
# [, 1]	mpg	Miles/(US) gallon
# [, 2]	cyl	Number of cylinders
# [, 3]	disp	Displacement (cu.in.)
# [, 4]	hp	Gross horsepower
# [, 5]	drat	Rear axle ratio
# [, 6]	wt	Weight (1000 lbs)
# [, 7]	qsec	1/4 mile time
# [, 8]	vs	V/S
# [, 9]	am	Transmission (0 = automatic, 1 = manual)
# [,10]	gear	Number of forward gears
# [,11]	carb	Number of carburetors

# Q2.(2 pts)
# Create a vector mpg_cl based on mpg in the dataset. 
# For automatic cars, the vector should have value TRUE when mpg > 16 and value FALSE when mpg <= 16.
# For manual cars, the vector should have value TRUE when mpg > 20 and value FALSE when mpg <= 20.

### Your code below
mpg_cl = (mtcars$mpg > 16 & mtcars$am == 0 | mtcars$mpg > 20 & mtcars$am == 1)


# Q3.(2 pts)
# Here is an alternative way to create the same vector in Q2.

# First, we create a numeric vector mpg_index that is 16 for each automatic cars
# and 20 for each manual cars. To do this, first create a vector of length 2 called 
# id_val whose first element is 16 and second element is 20.

### Your code below
id_val = c(16, 20)
# Create the mpg_index vector by subsetting id_val by position, where the 
# positions could be represented based on am column in mtcars.

### Your code below
mpg_index = id_val
# Finally, us mpg_index and mpg column to create the desired vector, and
# call it mpg_cl2.

### Your code below

# Q4.(2 pts)
# Make a plot of the variable disp against the variable weight. Color cars with different 
# mpg_cl value differently, and also format your plots with appropriate labels. Describe any 
# notable observations you have of the plot.

### Your code below

### Your answer here

#PART 2.  San Francisco Housing Data
#
# Load the data into R.
load(url("https://www.stanford.edu/~vcs/StatData/SFHousing.rda"))

# Q5. (2 pts.)
# What objects are in SFHousing.rda? Give the name and class of each.

### Your code below
names(housing)
class(housing)
names(cities)
class(cities)
### Your answer here
#names : [1] "longitude"   "latitude"    "county"      "medianPrice" "medianSize" 

# > names(cities)
# [1] "longitude"   "latitude"    "county"      "medianPrice" "medianSize" 
# [6] "numHouses"   "medianBR"  

# > names(housing)
# [1] "county"  "city"    "zip"     "street"  "price"   "br"      "lsqft"   "bsqft"  
# [9] "year"    "date"    "long"    "lat"     "quality" "match"   "wk"   

# > class(housing)
# [1] "data.frame"

# > class(cities)
# [1] "data.frame"

# Give a summary of each object, including a summary of each variable and the dimension of the object.

### Your code below
summary(housing)
summary(cities)
### Your answer here

# After exploring the data (maybe using the summary() function), describe in words the connection
# between the two objects.

### Write your response here

# Describe in words two problems that you see with the data.

### Write your response here


# Q6. (2 pts.)
# We will work the houses in Oakland, San Francisco, Campbell, and Sunnyvale only.
# Subset the housing data frame so that we have only houses in these cities
# and keep only the variables county, city, zip, price, br, bsqft, and year.
# Call this new data frame SelectArea. This data frame should have 28843 observations
# and 7 variables. (Note you may need to reformat any factor variables so that they
# do not contain incorrect levels)

### Your code below
SelectArea = 
  housing[housing$city == "Oakland" 
          | housing$city =="San Francisco" 
          | housing$city == "Campbell" 
          | housing$city == "Sunnyvale"
          , c("county", "city", "zip", "price", "br", "bsqft", "year")]
#checking if I got the observations right
length(SelectArea[,"county"]) # [1] 28843 

# Q7. (3 pts.)
# We are interested in making plots of price and size of house, but before we do this
# we will further subset the housing dataframe to remove the unusually large values.
# Use the quantile function to determine the 95th percentile of price and bsqft
# and eliminate all of those houses that are above either of these 95th percentiles
# Call this new data frame SelectArea (replacing the old one) as well. It should 
# have 26459 observations.

### Your code below
SelectArea = SelectArea[ SelectArea$price < quantile(SelectArea$price, c(0.95), na.rm=T) & SelectArea$bsqft < quantile(SelectArea$bsqft, c(0.95), na.rm=T), ]
#checking if I got the observations right
length(s[,1]) # [1] 26459

# Q8 (2 pts.)
# Create a new vector that is called price_per_sqft by dividing the sale price by the square footage
# Add this new variable to the data frame.

### Your code below
price_per_sqft = SelectArea$price / SelectArea$bsqft
SelectArea$price_per_sqft = price_per_sqft
#print out the dataframe objects to make sure the variable price_per_sqft is added in. 
objects(SelectArea)
# > objects(SelectArea)
# [1] "br"             "bsqft"          "city"           "county"        
# [5] "price"          "price_per_sqft" "year"           "zip" 


# Q9 (2 pts.)
# Create a vector called br_new that is the number of bedrooms in the house, except
# if this number is greater than 5, it is set to 5.  That is, if a house has 5 or more
# bedrooms then br5 will be 5. Otherwise it will be the number of bedrooms.

### Your code below
br_new = SelectArea[, "br"]
br_new[SelectArea[, "br"] > 5] = 5
# checking if I got the vector correct by having it print out numbers that are larger or equal to 5
br_new[br_new >= 5] # it only contains the number 5, which proves the above code is correct

# Q10. (4 pts. 2 + 2 - see below)
# Use the rainbow function to create a vector of 5 colors, call this vector rCols.
# When you call this function, set the alpha argument to 0.25.
# Create a vector called brCols where each element's value corresponds to the color in rCols 
# indexed by the number of bedrooms in the br_new.
# For example, if the element in br_new is 3 then the color will be the third color in rCols.
# (2 pts.)

### Your code below
rCols = rainbow(5, alpha = 0.25)
brCols = rCols[br_new]

######
# We are now ready to make a plot!
# Try out the following code (check R documentation to make sure you understand it),
plot(price_per_sqft ~ bsqft, data = SelectArea,
     main = "Housing prices in the Berkeley Area",
     xlab = "Size of house (square ft)",
     ylab = "Price per square foot",
     col = brCols, pch = 19, cex = 0.5)
legend(legend = 1:5, fill = rCols, "topright")

### What interesting feature do you see that you didn't know before making this plot? 
# (2 pts.)

