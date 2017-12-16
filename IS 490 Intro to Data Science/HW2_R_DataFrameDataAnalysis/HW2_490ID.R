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
dim(mtcars) # [1] 32 11  a data frame with 32 observations (rows) and 11 variables (columns)
summary(mtcars) 
head(mtcars, 5) 
help(mtcars) 

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

# Ans: From my point of view, I alway thought that car speeds must have been affected by a general reason.
#      Such as cars having more gears, more weights not just because of its sure horse power.
#      However, from the summary, the data shows that the difference is quite large with a 13.5 difference in maximum and minimum mpg value. 
#      Yet, gears and weights have relatively small max and min difference compared to mpg.
#      And the one that also has a relatively high difference in min max value is the horse power.
#      Which may prove that what I used to assume isn't correct, gears and weights have may have little affect on speed of cars.
#      It's the horse power that makes the real difference in the speed and usage of gasoline.

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
mpg_index = id_val[mtcars$am + 1]
# Finally, us mpg_index and mpg column to create the desired vector, and
# call it mpg_cl2.

### Your code below
mpg_cl2 = mtcars$mpg > mpg_index

# Q4.(2 pts)
# Make a plot of the variable disp against the variable weight. Color cars with different 
# mpg_cl value differently, and also format your plots with appropriate labels. Describe any 
# notable observations you have of the plot.

### Your code below

plot(mtcars$disp, mtcars$wt, col = ifelse(mtcars$am == 1, "blue", "red"), xlab = "Displacement (disp)", ylab = "Weight (wt)" )

### Your answer here
# Ans: For both cars, Weight (wt) and Displacement (disp) are highly correlated with a linear association.
#      For manual cars, most of those cares are light with few weight and few displacement.
#      As for Automatic cars, they tend to have a higher weight and displacement than manual cars.
#      I am guessing that Automatic cars are more intricate, so must have more gears for its system
#      thus having a much more higher weight and displacement than manual cars.

#PART 2.  San Francisco Housing Data
#
# Load the data into R.
load(url("https://www.stanford.edu/~vcs/StatData/SFHousing.rda"))

# Q5. (2 pts.)
# What objects are in SFHousing.rda? Give the name and class of each.

### Your code below
objects(housing)
names(housing)
sapply(housing, names)
class(housing)
sapply(housing, class)

objects(cities)
names(cities)
sapply(cities, names)
class(cities)
sapply(cities, class)


summary(housing)
summary(cities)
### Your answer here

# Objects in housing
# > objects(housing)
# [1] "br"      "bsqft"   "city"    "county"  "date"    "lat"     "long"    "lsqft"  
# [9] "match"   "price"   "quality" "street"  "wk"      "year"    "zip" 

# Names in housing
# > names(housing)
# [1] "county"  "city"    "zip"     "street"  "price"   "br"      "lsqft"   "bsqft"  
# [9] "year"    "date"    "long"    "lat"     "quality" "match"   "wk"  

#Objects in cities
# > objects(cities)
# [1] "county"      "latitude"    "longitude"   "medianBR"    "medianPrice" "medianSize" 
# [7] "numHouses"  

# Names in cities
# > names(cities)
# [1] "longitude"   "latitude"    "county"      "medianPrice" "medianSize" 
# [6] "numHouses"   "medianBR"  


# Names of housing objects : All Null
# > sapply(housing, names)
# $county
# NULL
# $city
# NULL
# $zip
# NULL
# $street
# NULL
# $price
# NULL
# $br
# NULL
# $lsqft
# NULL
# $bsqft
# NULL
# $year
# NULL
# $date
# NULL
# $long
# NULL
# $lat
# NULL
# $quality
# NULL
# $match
# NULL
# $wk
# NULL

# Names of Cities objects:
# > sapply(cities, names)
# $longitude
# [1] "Alameda"                     "Alamo"                      
# [3] "Albany"                      "Almaden"                    
# [5] "American Canyon"             "Angwin"                     
# [7] "Antioch"                     "Atherton"                   
# [9] "Bay Point"                   "Belmont"                    
# [11] "Belvedere"                   "Belvedere/tiburon"          
# [13] "Belvedere/Tiburon"           "Benicia"                    
# [15] "Berkeley"                    "Berryessa"                  
# [17] "Bethel Island"               "Blossom Hill"               
# [19] "Blossom Valley"              "Bodega Bay"                 
# [21] "Bolinas"                     "Brentwood"                  
# [23] "Brisbane"                    "Burlingame"                 
# [25] "Calistoga"                   "Cambrian"                   
# [27] "Campbell"                    "Castro Valley"              
# [29] "Cazadero"                    "Clayton"                    
# [31] "Cloverdale"                  "Concord"                    
# [33] "Corte Madera"                "Cotati"                     
# [35] "Crockett"                    "Cupertino"                  
# [37] "Daly City"                   "Danville"                   
# [39] "Diablo"                      "Dillon Beach"               
# [41] "Discovery Bay"               "Dixon"                      
# [43] "Dublin"                      "East Palo Alto"             
# [45] "East San Jose"               "El Cerrito"                 
# [47] "El Granada"                  "El Sobrante"                
# [49] "Emerald Hills"               "Emeryville"                 
# [51] "Evergreen"                   "Fairfax"                    
# [53] "Fairfield"                   "Forest Knolls"              
# [55] "Forestville"                 "Foster City"                
# [57] "Fremont"                     "Fulton"                     
# [59] "Geyserville"                 "Gilroy"                     
# [61] "Glen Ellen"                  "Graton"                     
# [63] "Greater Downtown-metro Area" "Greenbrae"                  
# [65] "Guerneville"                 "Half Moon Bay"              
# [67] "Hayward"                     "Healdsburg"                 
# [69] "Hercules"                    "Hillsborough"               
# [71] "Inverness"                   "Jenner"                     
# [73] "Kensington"                  "Kentfield"                  
# [75] "Kenwood"                     "La Honda"                   
# [77] "Lafayette"                   "Lagunitas"                  
# [79] "Larkspur"                    "Livermore"                  
# [81] "Los Altos"                   "Los Altos Hills"            
# [83] "Los Gatos"                   "Martinez"                   
# [85] "Menlo Park"                  "Mill Valley"                
# [87] "Millbrae"                    "Milpitas"                   
# [89] "Montara"                     "Monte Rio"                  
# [91] "Monte Sereno"                "Moraga"                     
# [93] "Morgan Hill"                 "Moss Beach"                 
# [95] "Mountain View"               "Muir Beach"                 
# [97] "Napa"                        "Newark"                     
# [99] "Nicasio"                     "North San Jose"             
# [101] "Novato"                      "Oakland"                    
# [103] "Oakley"                      "Occidental"                 
# [105] "Orinda"                      "Pacheco"                    
# [107] "Pacifica"                    "Palo Alto"                  
# [109] "Penngrove"                   "Petaluma"                   
# [111] "Piedmont"                    "Pinole"                     
# [113] "Pittsburg"                   "Pleasant Hill"              
# [115] "Pleasanton"                  "Pope Valley"                
# [117] "Portola Valley"              "Redwood City"               
# [119] "Richmond"                    "Rio Vista"                  
# [121] "Rodeo"                       "Rohnert Park"               
# [123] "Rose Garden"                 "Ross"                       
# [125] "San Anselmo"                 "San Bruno"                  
# [127] "San Carlos"                  "San Francisco"              
# [129] "San Jose"                    "San Leandro"                
# [131] "San Lorenzo"                 "San Martin"                 
# [133] "San Mateo"                   "San Pablo"                  
# [135] "San Rafael"                  "San Ramon"                  
# [137] "Santa Clara"                 "Santa Rosa"                 
# [139] "Santa Teresa"                "Saratoga"                   
# [141] "Sausalito"                   "Sea Ranch"                  
# [143] "Sebastopol"                  "Sonoma"                     
# [145] "South San Francisco"         "South San Jose"             
# [147] "St Helena"                   "Stinson Beach"              
# [149] "Suisun City"                 "Sunnyvale"                  
# [151] "Sunol"                       "Tiburon"                    
# [153] "Union City"                  "Vacaville"                  
# [155] "Vallejo"                     "Walnut Creek"               
# [157] "West San Jose"               "Willow Glen"                
# [159] "Windsor"                     "Winters"                    
# [161] "Woodacre"                    "Woodside"                   
# [163] "Yountville"                 
# $latitude
# [1] "Alameda"                     "Alamo"                      
# [3] "Albany"                      "Almaden"                    
# [5] "American Canyon"             "Angwin"                     
# [7] "Antioch"                     "Atherton"                   
# [9] "Bay Point"                   "Belmont"                    
# [11] "Belvedere"                   "Belvedere/tiburon"          
# [13] "Belvedere/Tiburon"           "Benicia"                    
# [15] "Berkeley"                    "Berryessa"                  
# [17] "Bethel Island"               "Blossom Hill"               
# [19] "Blossom Valley"              "Bodega Bay"                 
# [21] "Bolinas"                     "Brentwood"                  
# [23] "Brisbane"                    "Burlingame"                 
# [25] "Calistoga"                   "Cambrian"                   
# [27] "Campbell"                    "Castro Valley"              
# [29] "Cazadero"                    "Clayton"                    
# [31] "Cloverdale"                  "Concord"                    
# [33] "Corte Madera"                "Cotati"                     
# [35] "Crockett"                    "Cupertino"                  
# [37] "Daly City"                   "Danville"                   
# [39] "Diablo"                      "Dillon Beach"               
# [41] "Discovery Bay"               "Dixon"                      
# [43] "Dublin"                      "East Palo Alto"             
# [45] "East San Jose"               "El Cerrito"                 
# [47] "El Granada"                  "El Sobrante"                
# [49] "Emerald Hills"               "Emeryville"                 
# [51] "Evergreen"                   "Fairfax"                    
# [53] "Fairfield"                   "Forest Knolls"              
# [55] "Forestville"                 "Foster City"                
# [57] "Fremont"                     "Fulton"                     
# [59] "Geyserville"                 "Gilroy"                     
# [61] "Glen Ellen"                  "Graton"                     
# [63] "Greater Downtown-metro Area" "Greenbrae"                  
# [65] "Guerneville"                 "Half Moon Bay"              
# [67] "Hayward"                     "Healdsburg"                 
# [69] "Hercules"                    "Hillsborough"               
# [71] "Inverness"                   "Jenner"                     
# [73] "Kensington"                  "Kentfield"                  
# [75] "Kenwood"                     "La Honda"                   
# [77] "Lafayette"                   "Lagunitas"                  
# [79] "Larkspur"                    "Livermore"                  
# [81] "Los Altos"                   "Los Altos Hills"            
# [83] "Los Gatos"                   "Martinez"                   
# [85] "Menlo Park"                  "Mill Valley"                
# [87] "Millbrae"                    "Milpitas"                   
# [89] "Montara"                     "Monte Rio"                  
# [91] "Monte Sereno"                "Moraga"                     
# [93] "Morgan Hill"                 "Moss Beach"                 
# [95] "Mountain View"               "Muir Beach"                 
# [97] "Napa"                        "Newark"                     
# [99] "Nicasio"                     "North San Jose"             
# [101] "Novato"                      "Oakland"                    
# [103] "Oakley"                      "Occidental"                 
# [105] "Orinda"                      "Pacheco"                    
# [107] "Pacifica"                    "Palo Alto"                  
# [109] "Penngrove"                   "Petaluma"                   
# [111] "Piedmont"                    "Pinole"                     
# [113] "Pittsburg"                   "Pleasant Hill"              
# [115] "Pleasanton"                  "Pope Valley"                
# [117] "Portola Valley"              "Redwood City"               
# [119] "Richmond"                    "Rio Vista"                  
# [121] "Rodeo"                       "Rohnert Park"               
# [123] "Rose Garden"                 "Ross"                       
# [125] "San Anselmo"                 "San Bruno"                  
# [127] "San Carlos"                  "San Francisco"              
# [129] "San Jose"                    "San Leandro"                
# [131] "San Lorenzo"                 "San Martin"                 
# [133] "San Mateo"                   "San Pablo"                  
# [135] "San Rafael"                  "San Ramon"                  
# [137] "Santa Clara"                 "Santa Rosa"                 
# [139] "Santa Teresa"                "Saratoga"                   
# [141] "Sausalito"                   "Sea Ranch"                  
# [143] "Sebastopol"                  "Sonoma"                     
# [145] "South San Francisco"         "South San Jose"             
# [147] "St Helena"                   "Stinson Beach"              
# [149] "Suisun City"                 "Sunnyvale"                  
# [151] "Sunol"                       "Tiburon"                    
# [153] "Union City"                  "Vacaville"                  
# [155] "Vallejo"                     "Walnut Creek"               
# [157] "West San Jose"               "Willow Glen"                
# [159] "Windsor"                     "Winters"                    
# [161] "Woodacre"                    "Woodside"                   
# [163] "Yountville"                 
# $county
# NULL
# $medianPrice
# [1] "Alameda"                     "Alamo"                      
# [3] "Albany"                      "Almaden"                    
# [5] "American Canyon"             "Angwin"                     
# [7] "Antioch"                     "Atherton"                   
# [9] "Bay Point"                   "Belmont"                    
# [11] "Belvedere"                   "Belvedere/tiburon"          
# [13] "Belvedere/Tiburon"           "Benicia"                    
# [15] "Berkeley"                    "Berryessa"                  
# [17] "Bethel Island"               "Blossom Hill"               
# [19] "Blossom Valley"              "Bodega Bay"                 
# [21] "Bolinas"                     "Brentwood"                  
# [23] "Brisbane"                    "Burlingame"                 
# [25] "Calistoga"                   "Cambrian"                   
# [27] "Campbell"                    "Castro Valley"              
# [29] "Cazadero"                    "Clayton"                    
# [31] "Cloverdale"                  "Concord"                    
# [33] "Corte Madera"                "Cotati"                     
# [35] "Crockett"                    "Cupertino"                  
# [37] "Daly City"                   "Danville"                   
# [39] "Diablo"                      "Dillon Beach"               
# [41] "Discovery Bay"               "Dixon"                      
# [43] "Dublin"                      "East Palo Alto"             
# [45] "East San Jose"               "El Cerrito"                 
# [47] "El Granada"                  "El Sobrante"                
# [49] "Emerald Hills"               "Emeryville"                 
# [51] "Evergreen"                   "Fairfax"                    
# [53] "Fairfield"                   "Forest Knolls"              
# [55] "Forestville"                 "Foster City"                
# [57] "Fremont"                     "Fulton"                     
# [59] "Geyserville"                 "Gilroy"                     
# [61] "Glen Ellen"                  "Graton"                     
# [63] "Greater Downtown-metro Area" "Greenbrae"                  
# [65] "Guerneville"                 "Half Moon Bay"              
# [67] "Hayward"                     "Healdsburg"                 
# [69] "Hercules"                    "Hillsborough"               
# [71] "Inverness"                   "Jenner"                     
# [73] "Kensington"                  "Kentfield"                  
# [75] "Kenwood"                     "La Honda"                   
# [77] "Lafayette"                   "Lagunitas"                  
# [79] "Larkspur"                    "Livermore"                  
# [81] "Los Altos"                   "Los Altos Hills"            
# [83] "Los Gatos"                   "Martinez"                   
# [85] "Menlo Park"                  "Mill Valley"                
# [87] "Millbrae"                    "Milpitas"                   
# [89] "Montara"                     "Monte Rio"                  
# [91] "Monte Sereno"                "Moraga"                     
# [93] "Morgan Hill"                 "Moss Beach"                 
# [95] "Mountain View"               "Muir Beach"                 
# [97] "Napa"                        "Newark"                     
# [99] "Nicasio"                     "North San Jose"             
# [101] "Novato"                      "Oakland"                    
# [103] "Oakley"                      "Occidental"                 
# [105] "Orinda"                      "Pacheco"                    
# [107] "Pacifica"                    "Palo Alto"                  
# [109] "Penngrove"                   "Petaluma"                   
# [111] "Piedmont"                    "Pinole"                     
# [113] "Pittsburg"                   "Pleasant Hill"              
# [115] "Pleasanton"                  "Pope Valley"                
# [117] "Portola Valley"              "Redwood City"               
# [119] "Richmond"                    "Rio Vista"                  
# [121] "Rodeo"                       "Rohnert Park"               
# [123] "Rose Garden"                 "Ross"                       
# [125] "San Anselmo"                 "San Bruno"                  
# [127] "San Carlos"                  "San Francisco"              
# [129] "San Jose"                    "San Leandro"                
# [131] "San Lorenzo"                 "San Martin"                 
# [133] "San Mateo"                   "San Pablo"                  
# [135] "San Rafael"                  "San Ramon"                  
# [137] "Santa Clara"                 "Santa Rosa"                 
# [139] "Santa Teresa"                "Saratoga"                   
# [141] "Sausalito"                   "Sea Ranch"                  
# [143] "Sebastopol"                  "Sonoma"                     
# [145] "South San Francisco"         "South San Jose"             
# [147] "St Helena"                   "Stinson Beach"              
# [149] "Suisun City"                 "Sunnyvale"                  
# [151] "Sunol"                       "Tiburon"                    
# [153] "Union City"                  "Vacaville"                  
# [155] "Vallejo"                     "Walnut Creek"               
# [157] "West San Jose"               "Willow Glen"                
# [159] "Windsor"                     "Winters"                    
# [161] "Woodacre"                    "Woodside"                   
# [163] "Yountville"                 
# $medianSize
# [1] "Alameda"                     "Alamo"                      
# [3] "Albany"                      "Almaden"                    
# [5] "American Canyon"             "Angwin"                     
# [7] "Antioch"                     "Atherton"                   
# [9] "Bay Point"                   "Belmont"                    
# [11] "Belvedere"                   "Belvedere/tiburon"          
# [13] "Belvedere/Tiburon"           "Benicia"                    
# [15] "Berkeley"                    "Berryessa"                  
# [17] "Bethel Island"               "Blossom Hill"               
# [19] "Blossom Valley"              "Bodega Bay"                 
# [21] "Bolinas"                     "Brentwood"                  
# [23] "Brisbane"                    "Burlingame"                 
# [25] "Calistoga"                   "Cambrian"                   
# [27] "Campbell"                    "Castro Valley"              
# [29] "Cazadero"                    "Clayton"                    
# [31] "Cloverdale"                  "Concord"                    
# [33] "Corte Madera"                "Cotati"                     
# [35] "Crockett"                    "Cupertino"                  
# [37] "Daly City"                   "Danville"                   
# [39] "Diablo"                      "Dillon Beach"               
# [41] "Discovery Bay"               "Dixon"                      
# [43] "Dublin"                      "East Palo Alto"             
# [45] "East San Jose"               "El Cerrito"                 
# [47] "El Granada"                  "El Sobrante"                
# [49] "Emerald Hills"               "Emeryville"                 
# [51] "Evergreen"                   "Fairfax"                    
# [53] "Fairfield"                   "Forest Knolls"              
# [55] "Forestville"                 "Foster City"                
# [57] "Fremont"                     "Fulton"                     
# [59] "Geyserville"                 "Gilroy"                     
# [61] "Glen Ellen"                  "Graton"                     
# [63] "Greater Downtown-metro Area" "Greenbrae"                  
# [65] "Guerneville"                 "Half Moon Bay"              
# [67] "Hayward"                     "Healdsburg"                 
# [69] "Hercules"                    "Hillsborough"               
# [71] "Inverness"                   "Jenner"                     
# [73] "Kensington"                  "Kentfield"                  
# [75] "Kenwood"                     "La Honda"                   
# [77] "Lafayette"                   "Lagunitas"                  
# [79] "Larkspur"                    "Livermore"                  
# [81] "Los Altos"                   "Los Altos Hills"            
# [83] "Los Gatos"                   "Martinez"                   
# [85] "Menlo Park"                  "Mill Valley"                
# [87] "Millbrae"                    "Milpitas"                   
# [89] "Montara"                     "Monte Rio"                  
# [91] "Monte Sereno"                "Moraga"                     
# [93] "Morgan Hill"                 "Moss Beach"                 
# [95] "Mountain View"               "Muir Beach"                 
# [97] "Napa"                        "Newark"                     
# [99] "Nicasio"                     "North San Jose"             
# [101] "Novato"                      "Oakland"                    
# [103] "Oakley"                      "Occidental"                 
# [105] "Orinda"                      "Pacheco"                    
# [107] "Pacifica"                    "Palo Alto"                  
# [109] "Penngrove"                   "Petaluma"                   
# [111] "Piedmont"                    "Pinole"                     
# [113] "Pittsburg"                   "Pleasant Hill"              
# [115] "Pleasanton"                  "Pope Valley"                
# [117] "Portola Valley"              "Redwood City"               
# [119] "Richmond"                    "Rio Vista"                  
# [121] "Rodeo"                       "Rohnert Park"               
# [123] "Rose Garden"                 "Ross"                       
# [125] "San Anselmo"                 "San Bruno"                  
# [127] "San Carlos"                  "San Francisco"              
# [129] "San Jose"                    "San Leandro"                
# [131] "San Lorenzo"                 "San Martin"                 
# [133] "San Mateo"                   "San Pablo"                  
# [135] "San Rafael"                  "San Ramon"                  
# [137] "Santa Clara"                 "Santa Rosa"                 
# [139] "Santa Teresa"                "Saratoga"                   
# [141] "Sausalito"                   "Sea Ranch"                  
# [143] "Sebastopol"                  "Sonoma"                     
# [145] "South San Francisco"         "South San Jose"             
# [147] "St Helena"                   "Stinson Beach"              
# [149] "Suisun City"                 "Sunnyvale"                  
# [151] "Sunol"                       "Tiburon"                    
# [153] "Union City"                  "Vacaville"                  
# [155] "Vallejo"                     "Walnut Creek"               
# [157] "West San Jose"               "Willow Glen"                
# [159] "Windsor"                     "Winters"                    
# [161] "Woodacre"                    "Woodside"                   
# [163] "Yountville"                 
# $numHouses
# [1] "Alameda"                     "Alamo"                      
# [3] "Albany"                      "Almaden"                    
# [5] "American Canyon"             "Angwin"                     
# [7] "Antioch"                     "Atherton"                   
# [9] "Bay Point"                   "Belmont"                    
# [11] "Belvedere"                   "Belvedere/tiburon"          
# [13] "Belvedere/Tiburon"           "Benicia"                    
# [15] "Berkeley"                    "Berryessa"                  
# [17] "Bethel Island"               "Blossom Hill"               
# [19] "Blossom Valley"              "Bodega Bay"                 
# [21] "Bolinas"                     "Brentwood"                  
# [23] "Brisbane"                    "Burlingame"                 
# [25] "Calistoga"                   "Cambrian"                   
# [27] "Campbell"                    "Castro Valley"              
# [29] "Cazadero"                    "Clayton"                    
# [31] "Cloverdale"                  "Concord"                    
# [33] "Corte Madera"                "Cotati"                     
# [35] "Crockett"                    "Cupertino"                  
# [37] "Daly City"                   "Danville"                   
# [39] "Diablo"                      "Dillon Beach"               
# [41] "Discovery Bay"               "Dixon"                      
# [43] "Dublin"                      "East Palo Alto"             
# [45] "East San Jose"               "El Cerrito"                 
# [47] "El Granada"                  "El Sobrante"                
# [49] "Emerald Hills"               "Emeryville"                 
# [51] "Evergreen"                   "Fairfax"                    
# [53] "Fairfield"                   "Forest Knolls"              
# [55] "Forestville"                 "Foster City"                
# [57] "Fremont"                     "Fulton"                     
# [59] "Geyserville"                 "Gilroy"                     
# [61] "Glen Ellen"                  "Graton"                     
# [63] "Greater Downtown-metro Area" "Greenbrae"                  
# [65] "Guerneville"                 "Half Moon Bay"              
# [67] "Hayward"                     "Healdsburg"                 
# [69] "Hercules"                    "Hillsborough"               
# [71] "Inverness"                   "Jenner"                     
# [73] "Kensington"                  "Kentfield"                  
# [75] "Kenwood"                     "La Honda"                   
# [77] "Lafayette"                   "Lagunitas"                  
# [79] "Larkspur"                    "Livermore"                  
# [81] "Los Altos"                   "Los Altos Hills"            
# [83] "Los Gatos"                   "Martinez"                   
# [85] "Menlo Park"                  "Mill Valley"                
# [87] "Millbrae"                    "Milpitas"                   
# [89] "Montara"                     "Monte Rio"                  
# [91] "Monte Sereno"                "Moraga"                     
# [93] "Morgan Hill"                 "Moss Beach"                 
# [95] "Mountain View"               "Muir Beach"                 
# [97] "Napa"                        "Newark"                     
# [99] "Nicasio"                     "North San Jose"             
# [101] "Novato"                      "Oakland"                    
# [103] "Oakley"                      "Occidental"                 
# [105] "Orinda"                      "Pacheco"                    
# [107] "Pacifica"                    "Palo Alto"                  
# [109] "Penngrove"                   "Petaluma"                   
# [111] "Piedmont"                    "Pinole"                     
# [113] "Pittsburg"                   "Pleasant Hill"              
# [115] "Pleasanton"                  "Pope Valley"                
# [117] "Portola Valley"              "Redwood City"               
# [119] "Richmond"                    "Rio Vista"                  
# [121] "Rodeo"                       "Rohnert Park"               
# [123] "Rose Garden"                 "Ross"                       
# [125] "San Anselmo"                 "San Bruno"                  
# [127] "San Carlos"                  "San Francisco"              
# [129] "San Jose"                    "San Leandro"                
# [131] "San Lorenzo"                 "San Martin"                 
# [133] "San Mateo"                   "San Pablo"                  
# [135] "San Rafael"                  "San Ramon"                  
# [137] "Santa Clara"                 "Santa Rosa"                 
# [139] "Santa Teresa"                "Saratoga"                   
# [141] "Sausalito"                   "Sea Ranch"                  
# [143] "Sebastopol"                  "Sonoma"                     
# [145] "South San Francisco"         "South San Jose"             
# [147] "St Helena"                   "Stinson Beach"              
# [149] "Suisun City"                 "Sunnyvale"                  
# [151] "Sunol"                       "Tiburon"                    
# [153] "Union City"                  "Vacaville"                  
# [155] "Vallejo"                     "Walnut Creek"               
# [157] "West San Jose"               "Willow Glen"                
# [159] "Windsor"                     "Winters"                    
# [161] "Woodacre"                    "Woodside"                   
# [163] "Yountville"                 
# $medianBR
# [1] "Alameda"                     "Alamo"                      
# [3] "Albany"                      "Almaden"                    
# [5] "American Canyon"             "Angwin"                     
# [7] "Antioch"                     "Atherton"                   
# [9] "Bay Point"                   "Belmont"                    
# [11] "Belvedere"                   "Belvedere/tiburon"          
# [13] "Belvedere/Tiburon"           "Benicia"                    
# [15] "Berkeley"                    "Berryessa"                  
# [17] "Bethel Island"               "Blossom Hill"               
# [19] "Blossom Valley"              "Bodega Bay"                 
# [21] "Bolinas"                     "Brentwood"                  
# [23] "Brisbane"                    "Burlingame"                 
# [25] "Calistoga"                   "Cambrian"                   
# [27] "Campbell"                    "Castro Valley"              
# [29] "Cazadero"                    "Clayton"                    
# [31] "Cloverdale"                  "Concord"                    
# [33] "Corte Madera"                "Cotati"                     
# [35] "Crockett"                    "Cupertino"                  
# [37] "Daly City"                   "Danville"                   
# [39] "Diablo"                      "Dillon Beach"               
# [41] "Discovery Bay"               "Dixon"                      
# [43] "Dublin"                      "East Palo Alto"             
# [45] "East San Jose"               "El Cerrito"                 
# [47] "El Granada"                  "El Sobrante"                
# [49] "Emerald Hills"               "Emeryville"                 
# [51] "Evergreen"                   "Fairfax"                    
# [53] "Fairfield"                   "Forest Knolls"              
# [55] "Forestville"                 "Foster City"                
# [57] "Fremont"                     "Fulton"                     
# [59] "Geyserville"                 "Gilroy"                     
# [61] "Glen Ellen"                  "Graton"                     
# [63] "Greater Downtown-metro Area" "Greenbrae"                  
# [65] "Guerneville"                 "Half Moon Bay"              
# [67] "Hayward"                     "Healdsburg"                 
# [69] "Hercules"                    "Hillsborough"               
# [71] "Inverness"                   "Jenner"                     
# [73] "Kensington"                  "Kentfield"                  
# [75] "Kenwood"                     "La Honda"                   
# [77] "Lafayette"                   "Lagunitas"                  
# [79] "Larkspur"                    "Livermore"                  
# [81] "Los Altos"                   "Los Altos Hills"            
# [83] "Los Gatos"                   "Martinez"                   
# [85] "Menlo Park"                  "Mill Valley"                
# [87] "Millbrae"                    "Milpitas"                   
# [89] "Montara"                     "Monte Rio"                  
# [91] "Monte Sereno"                "Moraga"                     
# [93] "Morgan Hill"                 "Moss Beach"                 
# [95] "Mountain View"               "Muir Beach"                 
# [97] "Napa"                        "Newark"                     
# [99] "Nicasio"                     "North San Jose"             
# [101] "Novato"                      "Oakland"                    
# [103] "Oakley"                      "Occidental"                 
# [105] "Orinda"                      "Pacheco"                    
# [107] "Pacifica"                    "Palo Alto"                  
# [109] "Penngrove"                   "Petaluma"                   
# [111] "Piedmont"                    "Pinole"                     
# [113] "Pittsburg"                   "Pleasant Hill"              
# [115] "Pleasanton"                  "Pope Valley"                
# [117] "Portola Valley"              "Redwood City"               
# [119] "Richmond"                    "Rio Vista"                  
# [121] "Rodeo"                       "Rohnert Park"               
# [123] "Rose Garden"                 "Ross"                       
# [125] "San Anselmo"                 "San Bruno"                  
# [127] "San Carlos"                  "San Francisco"              
# [129] "San Jose"                    "San Leandro"                
# [131] "San Lorenzo"                 "San Martin"                 
# [133] "San Mateo"                   "San Pablo"                  
# [135] "San Rafael"                  "San Ramon"                  
# [137] "Santa Clara"                 "Santa Rosa"                 
# [139] "Santa Teresa"                "Saratoga"                   
# [141] "Sausalito"                   "Sea Ranch"                  
# [143] "Sebastopol"                  "Sonoma"                     
# [145] "South San Francisco"         "South San Jose"             
# [147] "St Helena"                   "Stinson Beach"              
# [149] "Suisun City"                 "Sunnyvale"                  
# [151] "Sunol"                       "Tiburon"                    
# [153] "Union City"                  "Vacaville"                  
# [155] "Vallejo"                     "Walnut Creek"               
# [157] "West San Jose"               "Willow Glen"                
# [159] "Windsor"                     "Winters"                    
# [161] "Woodacre"                    "Woodside"                   
# [163] "Yountville"                 

# Class of housing
# > class(housing)
# [1] "data.frame"

# Class of housing objects:
# > sapply(housing, class)
# $county
# [1] "factor"
# $city
# [1] "factor"
# $zip
# [1] "factor"
# $street
# [1] "character"
# $price
# [1] "numeric"
# $br
# [1] "integer"
# $lsqft
# [1] "numeric"
# $bsqft
# [1] "integer"
# $year
# [1] "integer"
# $date
# [1] "POSIXt"  "POSIXct"
# $long
# [1] "numeric"
# $lat
# [1] "numeric"
# $quality
# [1] "factor"
# $match
# [1] "factor"
# $wk
# [1] "Date"


# Class of cities
# > class(cities)
# [1] "data.frame"

# Class of cities objects
# > sapply(cities, class)
# longitude    latitude      county medianPrice  medianSize   numHouses    medianBR 
# "array"     "array"    "factor"     "array"     "array"     "array"     "array" 



# Give a summary of each object, including a summary of each variable and the dimension of the object.


### Your code below
dim(housing)
summary(housing)
sapply(housing, summary)
dim(cities)
summary(cities)
sapply(cities, summary)
### Your answer here

# Dimensions
#> dim(housing)
# [1] 281506     15

# > dim(cities)
# [1] 163   7

# Summarry
#> summary(housing)
# county                 city             zip            street         
# Santa Clara County :70424   Oakland      : 14730   94565  :  4595   Length:281506     
# Alameda County     :60410   Santa Rosa   :  9917   94509  :  4302   Class :character  
# Contra Costa County:59381   Fremont      :  9414   95123  :  4023   Mode  :character  
# Solano County      :23404   San Francisco:  8137   95687  :  3652                     
# San Mateo County   :22558   Evergreen    :  7947   94533  :  3472                     
# Sonoma County      :21676   Antioch      :  7726   (Other):261457                     
# (Other)            :23653   (Other)      :223635   NA's   :     5                     
# price                br            lsqft               bsqft              year     
# Min.   :   22000   Min.   :1.000   Min.   :       19   Min.   :    122   Min.   :   0  
# 1st Qu.:  400000   1st Qu.:2.000   1st Qu.:     4000   1st Qu.:   1121   1st Qu.:1954  
# Median :  530000   Median :3.000   Median :     5760   Median :   1430   Median :1971  
# Mean   :  602000   Mean   :3.024   Mean   :    65939   Mean   :   1624   Mean   :1966  
# 3rd Qu.:  700000   3rd Qu.:4.000   3rd Qu.:     7701   3rd Qu.:   1882   3rd Qu.:1985  
# Max.   :20000000   Max.   :8.000   Max.   :418611600   Max.   :1868120   Max.   :3894  
# NA's   :21687       NA's   :426       NA's   :9202  
# date                          long             lat       
# Min.   :2003-04-27 02:00:00   Min.   :-123.6   Min.   :36.98  
# 1st Qu.:2004-02-08 02:00:00   1st Qu.:-122.3   1st Qu.:37.50  
# Median :2004-10-24 02:00:00   Median :-122.1   Median :37.77  
# Mean   :2004-11-01 18:06:12   Mean   :-122.1   Mean   :37.78  
# 3rd Qu.:2005-07-24 02:00:00   3rd Qu.:-121.9   3rd Qu.:38.00  
# Max.   :2006-06-04 02:00:00   Max.   :-121.5   Max.   :38.85  
# NA's   :23316    NA's   :23316  
# quality                    match       
# QUALITY_ADDRESS_RANGE_INTERPOLATION      :170719   Exact           :197044  
# gpsvisualizer                            : 31084   Relaxed         : 30570  
# QUALITY_CITY_CENTROID                    : 20473   Relaxed; Soundex: 23338  
# QUALITY_EXACT_PARCEL_CENTROID            : 17208   Soundex         :  2573  
# QUALITY_ZIP_CODE_TABULATION_AREA_CENTROID: 14980   1               :  2244  
# (Other)                                  :  3726   (Other)         :  2421  
# NA's                                     : 23316   NA's            : 23316  
# wk            
# Min.   :2003-04-21  
# 1st Qu.:2004-02-01  
# Median :2004-10-18  
# Mean   :2004-10-26  
# 3rd Qu.:2005-07-18  
# Max.   :2006-05-29  
# 

# > sapply(housing, summary)
# $county
# Alameda County  Contra Costa County         Marin County          Napa County 
# 60410                59381                10450                 5066 
# San Francisco County     San Mateo County   Santa Clara County        Solano County 
# 8137                22558                70424                23404 
# Sonoma County 
# 21676 
# 
# $city
# Oakland                  Santa Rosa                     Fremont 
# 14730                        9917                        9414 
# San Francisco                   Evergreen                     Antioch 
# 8137                        7947                        7726 
# Vallejo                     Concord                     Hayward 
# 7183                        7109                        6565 
# Fairfield                   Vacaville                    Richmond 
# 5734                        5439                        5298 
# Walnut Creek                   Livermore               West San Jose 
# 4932                        4843                        4694 
# Berryessa                   Sunnyvale                 Santa Clara 
# 4396                        4062                        4028 
# San Leandro                    Cambrian                        Napa 
# 4023                        3967                        3878 
# San Ramon                  Pleasanton                   San Mateo 
# 3754                        3632                        3486 
# Danville                   Pittsburg                Blossom Hill 
# 3412                        3341                        3273 
# Brentwood                      Novato                Redwood City 
# 3234                        3027                        2932 
# Union City                    Petaluma                   Daly City 
# 2896                        2868                        2754 
# Milpitas               Mountain View                    Berkeley 
# 2676                        2592                        2540 
# Willow Glen              Blossom Valley               East San Jose 
# 2506                        2501                        2474 
# Gilroy              South San Jose                  San Rafael 
# 2446                        2414                        2405 
# Martinez               Castro Valley                     Alameda 
# 2400                        2373                        2339 
# Dublin                 Morgan Hill                      Oakley 
# 2239                        2237                        2193 
# Cupertino                Rohnert Park                      Newark 
# 2108                        2090                        2014 
# Pleasant Hill                 Suisun City                    Campbell 
# 1947                        1925                        1914 
# Los Gatos                   San Pablo              North San Jose 
# 1909                        1891                        1778 
# Greater Downtown-metro Area                     Almaden         South San Francisco 
# 1754                        1705                        1692 
# Hercules                     Benicia                      Sonoma 
# 1634                        1534                        1521 
# Mill Valley                    San Jose                    Pacifica 
# 1488                        1397                        1377 
# Discovery Bay                   Palo Alto                   Los Altos 
# 1364                        1362                        1351 
# San Bruno                  San Carlos                    Saratoga 
# 1350                        1343                        1335 
# Windsor                 San Lorenzo                   Bay Point 
# 1324                        1269                        1255 
# Foster City                  Menlo Park                       Dixon 
# 1200                        1040                        1022 
# Lafayette                     Belmont                  El Cerrito 
# 1018                        1001                         986 
# Burlingame                Santa Teresa                  Sebastopol 
# 981                         964                         909 
# Pinole                      Orinda                      Moraga 
# 868                         852                         849 
# Clayton                       Alamo                 El Sobrante 
# 781                         760                         755 
# East Palo Alto                 San Anselmo                    Millbrae 
# 679                         665                         656 
# Albany               Half Moon Bay                  Healdsburg 
# 640                         633                         561 
# Rio Vista                  Cloverdale                   Kentfield 
# 548                         530                         481 
# (Other) 
# 9530 
# 
# $zip
# 94565   94509   95123   95687   94533   94531   94591   94536   94513   94587   94583 
# 4595    4302    4023    3652    3472    3427    3369    3292    3235    2896    2784 
# 94521   94558   95035   95125   94806   95127   94553   94544   95111   94551   95020 
# 2779    2757    2676    2646    2617    2607    2549    2524    2494    2467    2446 
# 95124   94550   94538   94534   94568   95037   94561   94541   95051   95014   94539 
# 2390    2376    2279    2274    2240    2237    2193    2186    2169    2126    2124 
# 94928   94605   95122   94560   95403   94526   94590   95136   94523   94804   95008 
# 2090    2084    2063    2014    2012    1958    1957    1957    1940    1931    1914 
# 94585   94566   94577   95148   94589   95121   94546   95404   94087   95688   95132 
# 1911    1892    1871    1856    1853    1851    1838    1797    1787    1787    1778 
# 94520   95120   94588   95401   95118   95409   94555   94954   94080   94611   94015 
# 1753    1746    1740    1734    1725    1723    1719    1711    1692    1672    1648 
# 94547   94501   94518   95116   94603   94510   95129   95476   94941   95131   94506 
# 1634    1619    1590    1590    1552    1534    1532    1521    1488    1470    1454 
# 95407   94010   94403   94621   94044   94514   94404   94066   94801   94597   94070 
# 1451    1426    1417    1414    1377    1363    1355    1350    1348    1344    1343 
# 94947   95070   94602   95492   94598   94803   94578   95135   94901   95032 (Other) 
# 1338    1335    1330    1324    1312    1310    1291    1289    1288    1285   83020 
# NA's 
# 5 
# 
# $street
# Length     Class      Mode 
# 281506 character character 
# 
# $price
# Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
# 22000   400000   530000   602000   700000 20000000 
# 
# $br
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 1.000   2.000   3.000   3.024   4.000   8.000 
# 
# $lsqft
# Min.   1st Qu.    Median      Mean   3rd Qu.      Max.      NA's 
# 19      4000      5760     65939      7701 418611600     21687 
# 
# $bsqft
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
# 122    1121    1430    1624    1882 1868120     426 
# 
# $year
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
# 0    1954    1971    1966    1985    3894    9202 
# 
# $date
# Min.               1st Qu.                Median                  Mean 
# "2003-04-27 02:00:00" "2004-02-08 02:00:00" "2004-10-24 02:00:00" "2004-11-01 18:06:12" 
# 3rd Qu.                  Max. 
# "2005-07-24 02:00:00" "2006-06-04 02:00:00" 
# 
# $long
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
# -123.6  -122.3  -122.1  -122.1  -121.9  -121.5   23316 
# 
# $lat
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
# 36.98   37.50   37.77   37.78   38.00   38.85   23316 
# 
# $quality
# 1                                         2 
# 2593                                       605 
# 3                                         4 
# 199                                        69 
# 5       QUALITY_ADDRESS_RANGE_INTERPOLATION 
# 3                                    170719 
# QUALITY_CITY_CENTROID       QUALITY_COUNTY_SUBDIVISION_CENTROID 
# 20473                                       160 
# QUALITY_EXACT_PARCEL_CENTROID         QUALITY_UNIFORM_LOT_INTERPOLATION 
# 17208                                        96 
# QUALITY_ZIP_CODE_TABULATION_AREA_CENTROID                             gpsvisualizer 
# 14980                                     31084 
# gpsvisualzer                                      NA's 
# 1                                     23316 
# 
# $match
# 1                2                3                4                5 
# 2244              823              319               80                3 
# Address        CityLevel            Exact          Relaxed Relaxed; Soundex 
# 287               36           197044            30570            23338 
# Relaxed;Soundex          Soundex      StreetLevel        Substring     ZipCodeLevel 
# 379             2573                0              491                2 
# cityLevel             NA's 
# 1            23316 
# 
# $wk
# Min.      1st Qu.       Median         Mean      3rd Qu.         Max. 
# "2003-04-21" "2004-02-01" "2004-10-18" "2004-10-26" "2005-07-18" "2006-05-29" 

# > sapply(cities, summary)
# $longitude
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
# -123.5  -122.5  -122.3  -122.3  -122.0  -121.6       6 
# 
# $latitude
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
# 37.01   37.54   37.89   37.87   38.09   38.80       6 
# 
# $county
# Alameda County  Contra Costa County         Marin County          Napa County 
# 17                   29                   24                    7 
# San Francisco County     San Mateo County   Santa Clara County        Solano County 
# 1                   24                   30                    8 
# Sonoma County 
# 23 
# 
# $medianPrice
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 324000  477500  605500  711043  800000 2200000 
# 
# $medianSize
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 861    1322    1460    1565    1672    3140 
# 
# $numHouses
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 11.0   138.5   981.0  1727.0  2409.5 14730.0 
# 
# $medianBR
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 1.000   3.000   3.000   2.908   3.000   4.000 

# > summary(cities)
# longitude         latitude                     county    medianPrice        medianSize  
# Min.   :-123.5   Min.   :37.01   Santa Clara County :30   Min.   : 324000   Min.   : 861  
# 1st Qu.:-122.5   1st Qu.:37.54   Contra Costa County:29   1st Qu.: 477500   1st Qu.:1322  
# Median :-122.3   Median :37.89   Marin County       :24   Median : 605500   Median :1460  
# Mean   :-122.3   Mean   :37.87   San Mateo County   :24   Mean   : 711043   Mean   :1565  
# 3rd Qu.:-122.0   3rd Qu.:38.09   Sonoma County      :23   3rd Qu.: 800000   3rd Qu.:1672  
# Max.   :-121.6   Max.   :38.80   Alameda County     :17   Max.   :2200000   Max.   :3140  
# NA's   :6        NA's   :6       (Other)            :16                                   
# numHouses          medianBR    
# Min.   :   11.0   Min.   :1.000  
# 1st Qu.:  138.5   1st Qu.:3.000  
# Median :  981.0   Median :3.000  
# Mean   : 1727.0   Mean   :2.908  
# 3rd Qu.: 2409.5   3rd Qu.:3.000  
# Max.   :14730.0   Max.   :4.000

# After exploring the data (maybe using the summary() function), describe in words the connection
# between the two objects.

### Write your response here
# Ans:
# Some places such as Santa Clara,Sonoma County,Alameda County, Contra Costa County have high numbers in both housing and cities.
# Which shows there is a high correlation with houshing and cities, as there are more cities, there are more housing.
# Also it shows the correlation of prices as both cities and housing have about the same distribution in prices, as both also
# have a very high maximum of the price (An outlier).


# Describe in words two problems that you see with the data.


### Write your response here
# Ans:
# The pricing problem. The maximum price of both cities and housing are far too large and away from the mean.
# Also a problem with the number of houses in cities and lsqft, bsqft number in housing as both maximum number 
# are very very large, far larger than the mean. Proving there are some problems with these two variables' data.


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
dim(SelectArea) # [1] 28843     7

# Q7. (3 pts.)
# We are interested in making plots of price and size of house, but before we do this
# we will further subset the housing dataframe to remove the unusually large values.
# Use the quantile function to determine the 95th percentile of price and bsqft
# and eliminate all of those houses that are above either of these 95th percentiles
# Call this new data frame SelectArea (replacing the old one) as well. It should 
# have 26459 observations.

### Your code below
SelectArea = SelectArea[ SelectArea$price < quantile(SelectArea$price, c(0.95), na.rm=T) 
                         & SelectArea$bsqft < quantile(SelectArea$bsqft, c(0.95), na.rm=T), ]
#Check if I got the observations right
length(s[,1]) # [1] 26459
dim(SelectArea) # [1] 26459     7

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
br_new[br_new >= 5] # It only contains the number 5, which proves the above code is correct

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
# checking if the answer and length is correct
length(brCols) # [1] 26459,  which is the same row length as the data frame


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

# Ans:
# I initially thought that houses with more bedrooms and a larger size should be more expensive
# and that it would have a higher price per square foot. Yet the plot shows otherwise,
# instead the lesser square feet and bedrooms a house have, its price per square tends to be higher.
# Which is totally different than what I had initially anticipated.
