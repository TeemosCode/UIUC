
# Question 1. output the number of movies in result.csv that were released before a given year (the given year is an input argument) (4pts)
awk -F "," -v param="$1" 'BEGIN{ count=0 }  { if ($(NF-1) < param ){count=count + 1} }  
END{printf("\nQuestion 1. Output the number of movies in result.csv that were released before a given year\n\nNumber of movies released befor %s:  %s\n", param, count ) }' result.csv 

# awk -F "," -v param="1980" 'BEGIN{  }  { if ($(NF-1) < param ){count[1]++} }  
# END{printf("Number of movies released befor %s:  %s", param, count[1] ) }' result.csv

#Question 2. output the title and the ratings of the movies from result.csv before the given year in (1.)
awk -F "," -v param="$1" 'BEGIN{ printf("\nQuestion 2. output the title and the ratings of the movies from result.csv before the given year in (1.)\n%-40s  %-s\n\n", "TITLE", "RATINGS") }  
{ if ($(NF-1) < param ) {printf("%-40s  %-s\n"), $(NF-2) , $(NF)} }  
END{}' result.csv  

echo "========= Below I call on a new delimeter using Awk on the 'result_notcommaseperated.csv' file, so it won't mess up the output with titles containing commas for certain movies======="

awk -F "~" -v param="$1" 'BEGIN{ printf("\nQuestion 2. output the title and the ratings of the movies from result.csv before the given year in (1.)\n%-40s  %-s\n\n", "TITLE", "RATINGS") }  
{ if ($(NF-1) < param ) {printf("%-40s  %-s\n"), $(NF-2) , $(NF)} }  
END{}' result_notcommaseperated.csv

