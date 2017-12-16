#!bin/bash

# Hw_FileforBoth_on_googlePlatform

cat temp.html | grep -A 8 "titleColumn" | grep -oP "[0-9]\.[0-9]</strong>" | sed "s/<\/strong>//g"  > ratings.txt
cat temp.html | grep -A 8 "titleColumn" | grep -oP "([0-9]+.)</span>" | sed "s/)<\/span>//g" > year.txt
cat temp.html | grep -A 1 "titleColumn" | grep "[0-9]" | sed "s/ //g" | sed "s/\.//g" > ranking.txt
cat temp.html | grep -A 8 "titleColumn" | grep -oP ">(.*)</a>" | sed "s/>//g" | sed "s/<\/a//g" > title.txt
sed -e 's/^\|$/"/g' title.txt > newTitle.txt

# create the result.csv comma seperated file of our results
paste -d "," ranking.txt newTitle.txt year.txt ratings.txt > result.csv


# 1. output the number of movies in result.csv that were released before a given year (the given year is an input argument) (4pts)
awk -F "," -v param="$1" 'BEGIN{ count=0 }  { if ($(NF-1) < param ){count=count + 1} }  
END{printf("\nQuestion 1. Output the number of movies in result.csv that were released before a given year\n\nNumber of movies released befor %s:  %s\n", param, count ) }' result.csv 

# awk -F "," -v param="1980" 'BEGIN{  }  { if ($(NF-1) < param ){count[1]++} }  
# END{printf("Number of movies released befor %s:  %s", param, count[1] ) }' result.csv

# 2. output the title and the ratings of the movies from result.csv before the given year in (1.)
awk -F "," -v param="$1" 'BEGIN{ printf("\nQuestion 2. output the title and the ratings of the movies from result.csv before the given year in (1.)\n%-40s  %-s\n\n", "TITLE", "RATINGS") }  { if ($(NF-1) < param ) {printf("%-40s  %-s\n"), $(NF-2) , $(NF)} }  
END{}' result.csv  