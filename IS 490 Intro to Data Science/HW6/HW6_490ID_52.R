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
confidence_interval = c(X_bar - SE, X_bar + SE)
# > confidence_interval
# [1] 7.641772 7.918228
# Ans: Confidence Interval = [mean +- SE] = [7.78 +- 0.1382283] = [7.641772, 7.918228]

#(c) Now use the simulation to estimate the distribution of X_bar and create confidence intervals for it using that distribution.
##(1) Form a set of X_bar by repeating B = 1000 times the individual experiment. You may want to create a matrix to save those values.(1 pts)
L = list()
for(index in 1:1000){
  L[[index]] = rbinom(100, 10, 0.8)
}

##(2) Get a estimate for mean X_bar for each experiment in (c)(1) and save it to a vector X_bar_estimate(length B vector).(1 pts)
X_bar_estimate = sapply(L, mean)

##(3) Now use X_bar_estimate to create a sampling distribution for X_bar, using the hist function to show the distribution.(Recall HW5 graphing techniques)
## Does the distribution look normal? (2 pts)
hist(X_bar_estimate, main = "Mean Sampling Distribution for X_bar", xlab = "Mean Point Estimates")
# Yes, it looks bell shaped, symmetric like a normal distribution.

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
for(i in 1:5){
  sz = sample(50:250 , 1, replace = T)
  B = sample(900: 1500, 1 , replace = T)
  if(i == 1){
    CIs = matrix(MC_sample(sz,B), ncol = 2)
  }else{
    CIs = rbind(CIs, MC_sample(sz,B))
  }
}
plot(CIs)
# Ans:


################################### Part 2: Regular Expression(Regular Expression or R) (22 pts) ##############################################

#(a) Write down a general regular expression to match the following:(General Regular Expression)
##(1) Words/tokens only have 's' as start or end. For example, stats, specifies, start, ends etc.(1 pts)
# Ans: ^s?[a-z]*s|s[a-z]*s?$

##(2) A string with the format <a>text</a>, <b>xxx</b> etc.(1 pts)
# Ans: <[a-z]>.*<\/[a-z]>

##(3) An email address that ends with .com, .edu, .net, .org, or .gov(1 pts)
# Ans: [a-zA-Z0-9._-]+@[a-zA-Z0-9._+-]+\.(com|edu|net|org|gov)

#(b) Carry out the following exercises on the State of the Union Speeches dataset(available in moodle, stateoftheunion1790-2012.txt). (R)
# (Suggestion: check the .txt data before coding the solutions and also lapply could be really helpful)
setwd("./Desktop/gitHub-UIUC/IS 490 Intro to Data Science/HW6/")

##(1) Use readLines() to read in the speeches where the return value is: character vector with one element/character string per line in the file save as su_data (1 pts)
su_data = readLines("stateoftheunion1790-2012.txt")
##(2) Use regular expressions and R to return the number of speeches in the dataset, and the number of presidents that gave speeches.(2 pts)
#####  number of speeches  #####
regSpeech = "[A-Z][a-z\ ]+,\ [A-Z][A-Za-z\ ]+,\ [A-Z][A-Za-z\ 0-9]+,\ [0-9]+"
length(grep(regSpeech, su_data))
### ANS: 221 ###
# > length(grep(regSpeech, su_data))
# [1] 221
#####  number of presidents that gave speeches  #####
speeches = su_data[grep(regSpeech, su_data)]
speechInfo = strsplit(speeches, ',')

SpeechInfoExtract = function(lst, pos, func){
  vec = c()
  for(i in 1:length(lst)){
    vec[i] = lst[[i]][pos]
  }
  return(func(vec))
}

pres = SpeechInfoExtract(speechInfo, 1, unique)
length(pres)
### ANS: 41 ###
# > length(pres)
# [1] 41

##(3) Use regular expressions to identify the date of the speech (save as su_date), extract the name of the speaker (save as su_speaker)
## extract the year (save as su_year) and the month of the date (save as su_month) (4 pts)
su_date = SpeechInfoExtract(speechInfo, 3, c)
su_speaker = SpeechInfoExtract(speechInfo, 1, c)
su_year = SpeechInfoExtract(speechInfo, 4, c)
su_month = SpeechInfoExtract(strsplit(su_date, ' '), 2, unique)

##(4) Merge the lines up into a list named su_speeches. Each element of the list is a character vector containing one speech. 
## The length of su_speeches should be the number of speeches in the data. Check: does the length of your list match your answer above? (3 pts)
su_speeches = c()
try = paste(su_data, collapse = '')
try_str = as.character(try)
splits = strsplit(try_str, "***", fixed = T)
for(i in 2:223){
  su_speeches[i-1] = splits[[1]][i] 
}
length(su_speeches)
# > length(su_speeches)
# [1] 222
# Ans: 222, it is longer than it by 1.

##(5) Eliminate apostrophes, numbers, and the phrase: (Applause.) and make all the characters lowercase for each element in su_speeches. (3 pts)

##(6) Split the speeches in su_speeches by blanks, punctuations. Drop any empty words that resulted from this split. 
## Save the result to another list su_tokens.Each element in the su_tokens should be a vector of words in the speeches.(2 pts)

##(7) Based on su_tokens, create a list called su_frequency to calculate the token frequency for each token in each speech.(1 pts)

##(8) Carry out some exploratory analysis of the data and term frequencies. For example, find the number of sentences, extract the
## long words, and the political party. Plot and interpret the term frequencies. What are your observations? (3 pts)
  
  


