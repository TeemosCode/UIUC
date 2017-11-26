#!/bin/bash
# Do not remove any of the comments. These are marked by #


# HW 8 - Due Monday Nov 27, 2017 in moodle and hardcopy in class.
 
# Upload .sh file to Moodle with filename: HW8_490IDS_52.sh
# Please make sure all the commands work in google cloud, we will
# test your script by choosing other arguments.  

# In your hard copy report, please include the UNIX / Linux script,
# input arguments, and results you get when running your script in UNIX.


# For this assignment we will use some basic commends of UNIX / Linux.  
# The text Homework_8.txt and dataset menu.csv are uploaded to Moodle.


# You can use the following commands to run the script on google cloud:
# chmod +x HW8_490IDS_YOURCLASSID.sh
# ./HW8_490IDS_YOURCLASSID.sh Argument_1 Argument_2 Argument_3 Argument_4 

# Here is a list of your input arguments:
# Argument_1: a positive number
# Argument_2: text file (Homework_8.txt)
# Argument_3: a word
# Argument_4: a positve interger which is less than 15 


# Q1. Calculate the square root of the input number(Argument_1)
#     and print your result. (5 points)
#     (Hint: bc)

# install bc package
# sudo apt-get install bc

echo "************ Q1 ************"
echo "The square root of $1:"
# Your answer here:
ans=`echo "sqrt ( "$1" )" | bc -l`
echo $ans



# Q2. Check whether your input integer(Argument_4) is even or odd 
#     and print your result. (5 points)
echo "************ Q2 ************"
# Your answer here:
if (($4%2 == 0))
then
	echo "Argument_4 '$4' is 'EVEN' number"
else
	echo "Argument_4 '$4' is 'ODD' number" 
fi



# Q3. Input a lowercase letter(Argument_3) and convert it to uppercase
#     and print your result. (5 points)
#     (Hint: tr)
echo "************ Q3 ************"
# Your answer here:
echo -e "'$3' Uppercase -->   \c"
echo "$3" | tr '[a-z]' '[A-Z]'


# Q4. Convert the following phrase "CS 498/LIS 490/STAT 430:INTRODUCTION
#     TO DATA SCIENCE" into separate words, and put each word on its own
#     line (ignoring space,'/' and ':'). (5 points)

# The output would look like:

# CS
# 498
# LIS
# 490
# STAT
# 430
# INTRODUCTION
# TO
# DATA
# SCIENCE

echo "************ Q4 ************"
# Your answer here:
IFS=" /:"
words="CS 498/LIS 490/STAT 430:INTRODUCTION TO DATA SCIENCE"
for word in $words
do
	echo $word
done



# Q5. Sort the answer in Q4 by descending order. (5 points)

# The output would look like:

# TO
# STAT
# SCIENCE
# LIS
# INTRODUCTION
# DATA
# CS
# 498
# 490
# 430

echo "************ Q5 ************"
# Your answer here:

for word in $words
do
	echo $word
done | sort -r




# Q6. The dataset menu.csv provides some nutrition facts for McDonald's
#     menu, calculate how many items are there in each category
#     and print your result. (5 points)
#     (Hint: awk)

echo "************ Q6 ************"
# Your answer here:
awk -F "," 'BEGIN{ printf("%-20s  %-s\n", "ITEMS", "NUMBERS") }  {menu[$1]++}  
END{for (item in menu) printf("%-20s  %-s\n", item, menu[item]) }' menu.csv


# Q7. For your output in Q6, change the format of categories, replace "&"
#     with word "and", and connect the words by "_". 
#     For example: "Chicken & Fish" ---> "Chicken_and_Fish" (5 points)
#     (Hint: sed)

# The output would look like:

# Smoothies_and_Shakes 28
# Coffee_and_Tea 95
# Salads 6
# ......

echo "************ Q7 ************"
# Your answer here:
awk -F "," 'BEGIN{ printf("%-20s  %-s\n", "ITEMS", "NUMBERS") }  {menu[$1]++}  
END{for (item in menu) printf("%-20s  %-s\n", item, menu[item]) }' menu.csv | sed "s/\ &\ /_and_/g"


# Q8. Count the lines of your text file(Argument_2). (5 points)
#     (Hint: wc)

echo "************ Q8 ************"
echo "The number of lines in $2:"
# Your answer here:
lines=`cat "$2" | wc -l | tr -d ' '`
# echo "Answer: --> '`cat "$2" | wc -l | tr -d ' '`'" 
echo "Answer: --> '`expr $lines + 1`'"  # gota manually add 1 because of windows and unix difference


# Q9. Count the frequency of a input word(Argument_3) in a text
#     file(Argument_2), and print "The frequency of word ____ is ____ ".
#     (5 points)
#     (Hint: grep)

echo "************ Q9 ************"
echo "The frequency of word '$3':"
# Your answer here:
echo "Answer: --> '`grep -ow "$3" "$2" | wc -w | tr -d " "`'"



# Q10. Print the number of unique words in the text file(Argument_2).
#     (5 points) 
#     (Hint: uniq, sort) 

echo "************ Q10 ************"
echo "The number of unique words in text file:"
# Your answer here:

echo "Answer: --> '`cat "$2" | tr " " "\n" | tr -d " " | sed "s/[[:punct:]]//g" | sort | uniq | wc -w | tr -d " "`'"



# Q11. Print the number of words that begin with the letter 'a' in the
#     text file(Argument_2) (5 points).

echo "************ Q11 ************"
echo "The number of words that begins with letter 'a':"
# Your answer here:
echo "Answer --> '`cat "$2" | tr " " "\n" | tr -d " " | grep -ow "^a.*" | wc -w | tr -d " "`'"



# Q12. Print top-k(Argument_4) and find the most frequent word and their frequencies.
#      (5 points).
#      (Hint: head) 

echo "************ Q12 ************"
echo "Top-$4 words are:"
# Your answer here:
echo "Answer - top'$4':"
#echo `cat "$2" | tr " " "\n" | tr -d " " | tr -d "[:punct:]" | sort | uniq -c | sort -r | head -"$4"`
echo `cat "$2" | tr " " "\n" | tr -d " " | sed "s/[[:punct:]]//g" | sort | uniq -c | sort -nr | head -"$4"`
echo ""


#mostfreq="`cat "$2" | tr " " "\n" | tr -d " " | tr -d "[:punct:]" | sort | uniq -c | sort -r | head -1`"
mostfreq="`cat "$2" | tr " " "\n" | tr -d " " | sed "s/[[:punct:]]//g" | sort | uniq -c | sort -nr | head -1`"
frequency="`echo "$mostfreq" | cut -d " " -f 3`"
word="`echo "$mostfreq" | cut -d " " -f 4`"

echo "Most Frequent Word, Frequency:==> '$word', '$frequency'"
echo "====================END of FILE=========================="

