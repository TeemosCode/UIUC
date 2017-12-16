# HW 6 - Due Monday Nov 6, 2017 in moodle and hardcopy in class. 
# Upload your R file to Moodle with name: HW6_490IDS_52.R
# Do Not remove any of the comments. These are marked by #

# Please ensure that no identifying information (other than your class ID) is on your paper copy

################################### Part 1: Simulation in R (15 pts) ##############################################

## We will use the simulation techniques (Monte Carlo) introduced in class to generate confidence intervals for our estimates of distribution mean


#(a). As we will generate random numbers please set the seed using your classID. This will help with reproducibility. (1 pts)
set.seed(52)

#(b)  For this simulation problem, we will sample data from the binomial distribution with parameters n and p. 
# First, we will estimate an individual experiment.

##(1) Generate m = 100 observations of test data, with n = 10 and p = 0.8 and name it test_sample. (1 pts)
test_sample = rbinom(100, 10, 0.8)
#### OutPut ####
# > test_sample
# [1]  9  5  9 10  6  8  7 10 10 10  7  7 10  5  7  8  9  8  7  7  8  8  9  9  8  6  9  9  6  7  9  8
# [33]  7  6  5 10  9  8  8  6  8  9  6  7  7  7 10  9  7  9  8  7  9  8  8  8  9  9  9  8  9  5  9  8
# [65]  8  9  7  6  8  5  7  9  8  7  9  9  7  7  8  8  6  6  7  7  8  8  8  5  9  9  5  7  8 10  8  9
# [97]  8  8  9  4

##(2) What is your estimate mean X_bar? (1 pts)
X_bar = mean(test_sample)
#### OutPut ####
# > X_bar
# [1] 7.78

##(3) What is the confidence interval for X_bar? (Recall HW4 Q5) (1 pts) *********
SE = sd(test_sample)/sqrt(100)
# > SE
# [1] 0.1382283
# we use 95% confidence interval
confidence_interval = c(X_bar - 1.96 * SE, X_bar + 1.96 * SE)
# > confidence_interval
# [1] 7.509072 8.050928
# Ans: Confidence Interval = [mean +- SE] = [7.78 +- 0.1382283] = [7.509072, 8.050928]

#(c) Now use the simulation to estimate the distribution of X_bar and create confidence intervals for it using that distribution.
##(1) Form a set of X_bar by repeating B = 1000 times the individual experiment. You may want to create a matrix to save those values.(1 pts)
L = list()
for(index in 1:1000){
  L[[index]] = rbinom(100, 10, 0.8)
}
L
### Out Put###
#> L
# 
# [[998]]
# [1]  9  6 10  6  8  9  9  8  9  6  9  9  7  8  6  8  9  8 10  6  8  8  9  8  8  8  5 10  9  9  8  9
# [33]  6  4  7  6  7  9  7  9 10  7  8  7  5  8  7  9  5  8  9  8  9  9  8  7  7  8  9 10  7  7  7  9
# [65]  9  5  7  7  6  8  6  9  9  9  8  8  8  9 10  8  9  8  8  7  4  9  6  6  8  8  8  7  9 10  9  9
# [97]  7  7  7  6
# 
# [[999]]
# [1] 10 10  6  8  9  9  7 10  7  8  6  8  9  8  9  7 10  7  6  9  8  8  6  7  9 10  8  8  9  8  9  7
# [33]  8 10  9  9  6  8  7 10  8  5  9  8  8  7  9  5  8  8  9  7  9  7  7  9  8  7  8  8  9 10  7  9
# [65]  8  9  6  9 10  8  8  7  6  8  7  9  8  6  8  9  6  6  6  4  7  6  7  8  6  8  6  6  8  7  9 10
# [97]  9  7  8 10
# 
# [[1000]]
# [1]  8  9  9 10  8  7  8  7  8  7  9  8  8  7  9 10  8  9  9  8  6  8 10  8  7  9 10  7  7  7  8 10
# [33]  9  9  6  8  8  9  8  9  9  7  9  8  8  8  8  7  7  9 10  9  7  9  7  6  9  9  9  8  9  9  9  9
# [65]  7  8  7  8  9  6  8  8  6  8  7  8  8  9  7  8  5  9  8  9  7  8  9  8  8  9  8  7  7 10  5  8
# [97]  9 10  9  7

##(2) Get a estimate for mean X_bar for each experiment in (c)(1) and save it to a vector X_bar_estimate(length B vector).(1 pts)
X_bar_estimate = sapply(L, mean)
### OutPut ###
# > X_bar_estimate
# [1] 7.93 8.10 8.13 8.18 7.86 8.04 8.13 8.21 7.94 7.76 8.01 8.04 8.10 7.91 7.91 8.06 7.96 7.99 8.09
# [20] 8.15 8.02 8.08 8.10 8.08 8.09 7.85 7.71 7.97 8.16 8.20 7.87 7.92 7.86 8.03 7.96 7.99 8.12 7.89
# ...
# ...
# [970] 7.78 8.02 7.91 7.95 7.94 7.98 7.89 7.91 8.06 8.12 8.06 7.91 8.02 8.00 7.96 7.86 7.90 7.94 7.81
# [989] 7.88 8.17 8.09 7.83 8.16 7.97 7.97 8.10 7.95 7.80 7.86 8.10

##(3) Now use X_bar_estimate to create a sampling distribution for X_bar, using the hist function to show the distribution.(Recall HW5 graphing techniques)
## Does the distribution look normal? (2 pts)
hist(X_bar_estimate, main = "Mean Sampling Distribution for X_bar", xlab = "Mean Point Estimates")
# Ans : Yes, it looks bell shaped, symmetric like a normal distribution.

##(4) Now as we have a simulated sampling distribution of X_bar, we could calculate the standard error using the X_bar_estimate. 
## What is your 95% confidence interval?(2 pts)
SE = sd(X_bar_estimate)
# > SE
# [1] 0.1199445
confidence_interval = c(X_bar - 1.96 * SE, X_bar + 1.96 * SE)
# > confidence_interval
# [1] 7.544909 8.015091
## Ans: 95% Confidence Interval = [mean +- SE(which equals SD)] = [7.78 +- 0.1199445] = [7.544909, 8.015091]



#(d) We made some decisions when we used the simulation above that we can now question. 
# Repeat the above creation of a confidence interval in (c) for a range of settings values
# (we had our sample size fixed at 100) and a range of bootstrap values (we had B 
# fixed at 1000). Suppose the sample size varies (100, 200, 300, .... , 1000) and 
# B varies (1000, 2000, ... , 10000). You will likely find it useful to write
# functions to carry out these calculations. Your final output should be 
# upper and lower pairs for the confidence intervals produced using the bootstrap
# method for each value of sample size and B.

# generalize (c) into a function, and vary inputs of sample size and B as we did above. (2 pts)

MC_sample <- function(sample_size, B){
  #code here
  L = list()
  for(index in 1:B){
    L[[index]] = rbinom(sample_size, 10, 0.8)
  }
  X_bar_estimate = sapply(L, mean)
  SE = sd(X_bar_estimate)
  confidence_interval = c(X_bar - 1.96 * SE, X_bar + 1.96 * SE)
  return(confidence_interval)
}

#(e).Plot your CI limits to compare the effect of changing the sample size and 
# changing the number of simulation replications B (2 plots). What do you conclude? (3 pts)
# for(i in 1:10){
#   sz = sample(50:250 , 1, replace = T)
#   B = sample(900: 1500, 1 , replace = T)
#   if(i == 1){
#     CIs = matrix(MC_sample(sz,B), ncol = 2)
#   }else{
#     CIs = rbind(CIs, MC_sample(sz,B))
#   }
# }

# Change of Sample Size
CIWidth = c()
counter = 1
sample_size = seq(100, 1000, by = 100)
for(size in sample_size){
  ci = MC_sample(size, 1000)
  CIWidth[counter] = ci[2] - ci[1]
  counter = counter + 1
}

plot(sample_size, CIWidth)


# Change of Simulation Size B
CIWidth = c()
counter = 1
size_B = seq(1000, 10000, by = 1000)
for(size in size_B){
  ci = MC_sample(100, size)
  CIWidth[counter] = ci[2] - ci[1]
  counter = counter + 1
}
plot(size_B, CIWidth)
# Ans: With a larger sample size we can see that the difference in confidence interval diminishes,
# which means the larger the sample size, the more accurate we can get to the population parameter.


################################### Part 2: Regular Expression(Regular Expression or R) (22 pts) ##############################################

#(a) Write down a general regular expression to match the following:(General Regular Expression)
##(1) Words/tokens only have 's' as start or end. For example, stats, specifies, start, ends etc.(1 pts)
# Ans: ^s?[a-z]*s|s[a-z]*s?$

##(2) A string with the format <a>text</a>, <b>xxx</b> etc.(1 pts)
# Ans: <[a-z]>.*<\/[a-z]>

##(3) An email address that ends with .com, .edu, .net, .org, or .gov(1 pts)
# Ans: [a-zA-Z0-9\._-]+@[a-zA-Z0-9\._+-]+\.(com|edu|net|org|gov)

#(b) Carry out the following exercises on the State of the Union Speeches dataset(available in moodle, stateoftheunion1790-2012.txt). (R)
# (Suggestion: check the .txt data before coding the solutions and also lapply could be really helpful)
setwd("./Desktop/gitHub-UIUC/IS 490 Intro to Data Science/HW6/")

##(1) Use readLines() to read in the speeches where the return value is: character vector with one element/character string per line in the file save as su_data (1 pts)
su_data = readLines("stateoftheunion1790-2012.txt")

##(2) Use regular expressions and R to return the number of speeches in the dataset, and the number of presidents that gave speeches.(2 pts)
#####  number of speeches  #####
regSpeech = "[A-Z][a-z\ ]+,\ [A-Z][A-Za-z\ ]+,\ [A-Z][A-Za-z\ 0-9]+,\ [0-9]+"  # regex for finding the list of speeches and presidents in the CONTENT area
length(grep(regSpeech, su_data))  # length of the regex findings indicating the number of speeches
### ANS: 222 ###
# > length(grep(regSpeech, su_data))
# [1] 222
#####  number of presidents that gave speeches  #####
speeches = su_data[grep(regSpeech, su_data)] # data of regex for finding the list of speeches and presidents in the CONTENT area
speechInfo = strsplit(speeches, ',') # split the speeches with comma and save it to speechInfo for later processing
# create function to extract needed information and data from speechInfo
# the lst is the speechInfo list, pos is the position in the vector inside the list, and func is the function that would be applied to the elements in the vector
SpeechInfoExtract = function(lst, pos, func){
  vec = c()
  for(i in 1:length(lst)){
    vec[i] = lst[[i]][pos]
  }
  return(func(vec))
}

pres = SpeechInfoExtract(speechInfo, 1, unique)
length(pres)
###
# > pres
# [1] "  George Washington"     "  John Adams"            "  Thomas Jefferson"     
# [4] "  James Madison"         "  James Monroe"          "  John Quincy Adams"    
# [7] "  Andrew Jackson"        "  Martin van Buren"      "  John Tyler"           
# [10] "  James Polk"            "  Zachary Taylor"        "  Millard Fillmore"     
# [13] "  Franklin Pierce"       "  James Buchanan"        "  Abraham Lincoln"      
# [16] "  Andrew Johnson"        "  Ulysses S. Grant"      "  Rutherford B. Hayes"  
# [19] "  Chester A. Arthur"     "  Grover Cleveland"      "  Benjamin Harrison"    
# [22] "  William McKinley"      "  Theodore Roosevelt"    "  William H. Taft"      
# [25] "  Woodrow Wilson"        "  Warren Harding"        "  Calvin Coolidge"      
# [28] "  Herbert Hoover"        "  Franklin D. Roosevelt" "  Harry S. Truman"      
# [31] "  Dwight D. Eisenhower"  "  John F. Kennedy"       "  Lyndon B. Johnson"    
# [34] "  Richard Nixon"         "  Gerald R. Ford"        "  Jimmy Carter"         
# [37] "  Ronald Reagan"         "  George H.W. Bush"      "  William J. Clinton"   
# [40] "  George W. Bush"        "  Barack Obama"  
### ANS: 41 ###
# > length(pres)
# [1] 41

##(3) Use regular expressions to identify the date of the speech (save as su_date), extract the name of the speaker (save as su_speaker)
## extract the year (save as su_year) and the month of the date (save as su_month) (4 pts)
su_date = SpeechInfoExtract(speechInfo, 3, unique)
su_date = SpeechInfoExtract(speechInfo, 3, c)
# > su_date
# [1] " January 8"    " December 8"   " October 25"   " November 6"   " December 3"   " November 19" 
# [7] " December 7"   " November 22"  " November 11"  " December 15"  " October 17"   " November 8"  
# [13] " December 2"   " October 27"   " November 29"  " December 5"   " November 5"   " November 4"  
# [19] " September 20" " December 12"  " November 16"  " November 14"  " December 6"   " December 4"  
# [25] " December 1"   " December 31"  " December 19"  " December 9"   " January 3"    " January 4"   
# [31] " January 6"    " January 7"    " January 11"   " January 21"   " January 5"    " January 9"   
# [37] " February 2"   " January 10"   " January 12"   " January 30"   " January 14"   " January 17"  
# [43] " January 22"   " January 20"   " January 15"   " January 19"   " January 25"   " January 16"  
# [49] " January 26"   " February 6"   " February 4"   " January 27"   " February 9"   " January 31"  
# [55] " January 29"   " January 28"   " February 17"  " January 24"   " January 23"   " February 24"

su_speaker = SpeechInfoExtract(speechInfo, 1, unique)
su_speaker = SpeechInfoExtract(speechInfo, 1, c)
# > su_speaker
# [1] "  George Washington"     "  John Adams"            "  Thomas Jefferson"     
# [4] "  James Madison"         "  James Monroe"          "  John Quincy Adams"    
# [7] "  Andrew Jackson"        "  Martin van Buren"      "  John Tyler"           
# [10] "  James Polk"            "  Zachary Taylor"        "  Millard Fillmore"     
# [13] "  Franklin Pierce"       "  James Buchanan"        "  Abraham Lincoln"      
# [16] "  Andrew Johnson"        "  Ulysses S. Grant"      "  Rutherford B. Hayes"  
# [19] "  Chester A. Arthur"     "  Grover Cleveland"      "  Benjamin Harrison"    
# [22] "  William McKinley"      "  Theodore Roosevelt"    "  William H. Taft"      
# [25] "  Woodrow Wilson"        "  Warren Harding"        "  Calvin Coolidge"      
# [28] "  Herbert Hoover"        "  Franklin D. Roosevelt" "  Harry S. Truman"      
# [31] "  Dwight D. Eisenhower"  "  John F. Kennedy"       "  Lyndon B. Johnson"    
# [34] "  Richard Nixon"         "  Gerald R. Ford"        "  Jimmy Carter"         
# [37] "  Ronald Reagan"         "  George H.W. Bush"      "  William J. Clinton"   
# [40] "  George W. Bush"        "  Barack Obama" 

su_year = SpeechInfoExtract(speechInfo, 4, unique)
su_year = SpeechInfoExtract(speechInfo, 4, c)
# > su_year
# [1] " 1790" " 1791" " 1792" " 1793" " 1794" " 1795" " 1796" " 1797" " 1798" " 1799" " 1800" " 1801"
# [13] " 1802" " 1803" " 1804" " 1805" " 1806" " 1807" " 1808" " 1809" " 1810" " 1811" " 1812" " 1813"
# ...
# [205] " 1999" " 2000" " 2001" " 2002" " 2003" " 2004" " 2005" " 2006" " 2007" " 2008" " 2009" " 2010"
# [217] " 2011" " 2012"

su_month = SpeechInfoExtract(strsplit(su_date, ' '), 2, unique)
# The UNIQUE months
# > su_month
# [1] "January"   "December"  "October"   "November"  "September" "February" 

##(4) Merge the lines up into a list named su_speeches. Each element of the list is a character vector containing one speech. 
## The length of su_speeches should be the number of speeches in the data. Check: does the length of your list match your answer above? (3 pts)
su_speeches = c()
try_str = paste(su_data, collapse = '')
# > try_str
# [1] "The Project Gutenberg EBook of Complete State of the Union Addresses,from 1790 to the Present.
# Augmented with speeches from UCSB.Character set encoding: UTF8The addresses are separated by three asterisksCONTENTS 
# George Washington, State of the Union Address, January 8, 1790  George Washington, 
# State of the Union Address, December 8, 1790  George Washington, State of the Union Address, 
# October 25, 1791  George Washington, State of the Union Address, November 6, 1792  George Washington, State of the Union Address, December 3, 1793  George Washington, 
# State of the Union Address, November 19, 1794  George Washington, State of the Union Address, December 8, 1795  George Washington, State of the Union Address, December 7, 1796  John Adams, State of the Union Address, 
# November 22, 1797  John Adams, State of the Union Address, December 8, 1798  John Adams,
# State of the Union Address, December 3, 1799  John Adams, State of the Union Address, November 11, 1800  Thomas Jefferson, State of t... <truncated>

splits = strsplit(try_str, "***", fixed = T)
for(i in 2:223){
  su_speeches[i-1] = splits[[1]][i] 
}
length(su_speeches)
# > length(su_speeches)
# [1] 222
# Ans: 222, the same.

##(5) Eliminate apostrophes, numbers, and the phrase: (Applause.) and make all the characters lowercase for each element in su_speeches. (3 pts)
tolower(gsub("[0-9]|'|([Aa]pplause)", "", su_speeches))
### OutPut ###
# ...
# rty or political preferenc... <truncated>
#   [222] "state of the union addressbarack obamajanuary , mr. speaker, mr. vice president, members
# of congress, distinguished guests, and fellow americans: last month, i went to andrews air force base
# and welcomed home some of our last troops to serve in iraq. together, we offered a final, proud
# salute to the colors under which more than a million of our fellow citizens fought and several 
# thousand gave their lives.we gather tonight knowing that this generation of heroes has made the
# united states safer and more respected around the world. for the first time in  years, there are 
# no americans fighting in iraq. for the first time in two decades, usama bin laden is not a threat 
# to this country. most of al qaidas top lieutenants have been defeated. the talibans momentum has 
# been broken, and some troops in afghanistan have begun to come home.these achievements are a 
# testament to the courage, selflessness, and teamwork of americas armed forces. at a time when too 
# many of our institutions have le... <truncated>


##(6) Split the speeches in su_speeches by blanks, punctuations. Drop any empty words that resulted from this split. 
## Save the result to another list su_tokens.Each element in the su_tokens should be a vector of words in the speeches.(2 pts)
#no_punct = strsplit(su_speeches, "[[:punct:]]|[[:blank:]]")
# su_tokens = sapply(no_punct, function(lst) lst[lst != ""])

su_speeches = lapply(su_speeches, function(x) unlist(strsplit(x, "[[:blank:]]|[[:punct:]]")))
### OutPut ###
# [921] "American"       "values"         "Now"            "this"           "blueprint"     
# [926] "begins"         "with"           "American"       "manufacturing"  "On"            
# [931] "the"            "day"            "I"              "took"           "office"        
# [936] "our"            "auto"           "industry"       "was"            "on"            
# [941] "the"            "verge"          "of"             "collapse"       "Some"          
# [946] "even"           "said"           "we"             "should"         "let"           
# [951] "it"             "die"            "With"           "a"              "million"       
# [956] "jobs"           "at"             "stake"          "I"              "refused"       
# [961] "to"             "let"            "that"           "happen"         "In"            
# [966] "exchange"       "for"            "help"           "we"             "demanded"      
# [971] "responsibility" "We"             "got"            "workers"        "and"           
# [976] "automakers"     "to"             "settle"         "their"          "differences"   
# [981] "We"             "got"            "the"            "industry"       "to"            
# [986] "retool"         "and"            "restructure"    "Today"          "General"       
# [991] "Motors"         "is"             "back"           "on"             "top"           
# [996] "as"             "the"            "world"          "s"              "number" 
su_tokens = lapply(su_speeches, function(x) x[x!=""])
### OutPut ###
# homes                       hope                    hopeful 
# 2                          1                          1 
# house                 households                    housing 
# 1                          1                          3 
# how                       huge                      human 
# 9                          3                          2 
# hundred                   hundreds                     hunger 
# 3                          1                          1 
# hurt                       idea                      ideas 
# 2                          1                          4 
# ideologies                         if                    illegal 
# 1                         17                          2 
# immediate                immigration                     impact 
# 1                          2                          1 
# imperative                  important                   imported 
# 1                          1                          1 
# in                 incentives                   includes 
# 100                          2                          1 
# income                    incomes                 incomplete 
# 2                          1                          1 
# increase                  increased                 incredible 
# 2                          1                          1 
# indispensable                 industries                   industry 
# 1                          4                          9 
# inefficient                inexcusable                  influence 
# 1                          1                          2 
# information             infrastructure                  ingenuity 
# 1                          1                          2 
# innocent 
# 2 
# [ reached getOption("max.print") -- omitted 845 entries ]


##(7) Based on su_tokens, create a list called su_frequency to calculate the token frequency for each token in each speech.(1 pts)
#su_frequency = sapply(su_tokens, unclass(table))

su_tokens = lapply(su_speeches, function(x) table(x))
### OutPut ###
# ideologies                         if                    illegal 
# 1                         17                          2 
# immediate                immigration                     impact 
# 1                          2                          1 
# imperative                  important                   imported 
# 1                          1                          1 
# in                 incentives                   includes 
# 100                          2                          1 
# income                    incomes                 incomplete 
# 2                          1                          1 
# increase                  increased                 incredible 
# 2                          1                          1 
# indispensable                 industries                   industry 
# 1                          4                          9 
# inefficient                inexcusable                  influence 
# 1                          1                          2 
# information             infrastructure                  ingenuity 
# 1                          1                          2 
# innocent 
# 2 
# [ reached getOption("max.print") -- omitted 845 entries ]

su_frequency = lapply(su_tokens, function(x) x/sum(x))
### Output ###
# ideologies                         if                    illegal 
# 0.0001374382               0.0023364486               0.0002748763 
# immediate                immigration                     impact 
# 0.0001374382               0.0002748763               0.0001374382 
# imperative                  important                   imported 
# 0.0001374382               0.0001374382               0.0001374382 
# in                 incentives                   includes 
# 0.0137438153               0.0002748763               0.0001374382 
# income                    incomes                 incomplete 
# 0.0002748763               0.0001374382               0.0001374382 
# increase                  increased                 incredible 
# 0.0002748763               0.0001374382               0.0001374382 
# indispensable                 industries                   industry 
# 0.0001374382               0.0005497526               0.0012369434 
# inefficient                inexcusable                  influence 
# 0.0001374382               0.0001374382               0.0002748763 
# information             infrastructure                  ingenuity 
# 0.0001374382               0.0001374382               0.0002748763 
# innocent 
# 0.0002748763 
# [ reached getOption("max.print") -- omitted 845 entries ]


##(8) Carry out some exploratory analysis of the data and term frequencies. For example, find the number of sentences, extract the
## long words, and the political party. Plot and interpret the term frequencies. What are your observations? (3 pts)
explor = lapply(su_tokens, function(x) sum(x))
### OutPut ###
# ...
# 
# [[220]]
# [1] 7481
# 
# [[221]]
# [1] 7113
# 
# [[222]]
# [1] 7276
su_year = SpeechInfoExtract(speechInfo, 4, c)
plot(su_year, explor, type='h')
# As our explor variable saves up the data of the sum of words for different speech, we plot out the speech numbers correlated
# to the years when the speech was delivered to see the word changes of speeches in different years. As it provides interesting
# information that at first the speeches by the first few presidents tend to be low in word numbers, yet aroung year 1850 to 1900
# the word frequencies became rather large, also there are years where the number of words in the speech is very very large compared
# to the other years. From this combined with other data such as president names or other information, we may find some interesting 
# things as to why the frequency of words in president speeches may change.
