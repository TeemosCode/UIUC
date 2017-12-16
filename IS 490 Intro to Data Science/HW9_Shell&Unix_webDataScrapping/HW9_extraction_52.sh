# Question 1.
# Using commands to Extract the html from the url - "http://www.imdb.com/chart/top" with curl command and assigning the output to a temp.html file
`curl "http://www.imdb.com/chart/top" > temp.html`

# Question 2.

# Save the commands that outputs starting from the <td class="titleColum"> and the number of lines (-A lineNumbers) behind it to two variables for further easier use
htmldata_top8=`cat temp.html | grep -A 8 "titleColumn"| sed "s/\n//g"`
htmldata_top1=`cat temp.html | grep -A 1 "titleColumn"| sed "s/\n//g"`

# Ratings
echo $htmldata_top8 | grep -oP "[0-9]\.[0-9]</strong>" | sed "s/<\/strong>//g" > ratings.txt

# Year
echo $htmldata_top8 | grep -oP "[0-9]+\)" | sed "s/)//g" > year.txt

# Ranking
echo $htmldata_top1 | grep -oP "[0-9]+" > rankings.txt

# Title
cat temp.html | grep -A 8 "titleColumn"| sed "s/\n//g" | grep -oP ">(.*)</a>" | sed "s/>//g" | sed "s/<\/a//g" | sed -e 's/^\|$/"/g' > title.txt


# I wrote two commands with very small changes with regards to the commas in the title. Yet still keeping the result.csv as (comma seperated)
# create the result.csv comma seperated file of our results
paste -d "," rankings.txt title.txt year.txt ratings.txt > result.csv

# create the result.csv with '~' seperated file of our results so when later called with Awk 'result_notcommaseperated.csv' file, it won't mess up the output with titles containing commas
paste -d "~" rankings.txt title.txt year.txt ratings.txt > result_notcommaseperated.csv