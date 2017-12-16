# A function to catergorize the data for easier use in the future

def dataProcess(data, file, number_of_storms):
    number_of_storms = 0
    for line in file:
        lineData = line.split(",")
        if len(lineData) != 21:
            number_of_storms += 1
            cycloneNumber = lineData[0]
            data[cycloneNumber] = {}
            
            data[cycloneNumber]["Name"] = lineData[1].strip() # clean out the spaces in the string
            data[cycloneNumber]["Tracked_Numbers"] = lineData[2].strip()
        else:
            data[cycloneNumber]["Tracked_Dates"] = data[cycloneNumber].get("Tracked_Dates", []) + [lineData[0]]
            data[cycloneNumber]["Maximun_Sustained_Wind(in_knots)"] = data[cycloneNumber].get("Maximun_Sustained_Wind(in_knots)", []) + [lineData[6].strip()]
            if lineData[2].strip() == "L":
                data[cycloneNumber]["Landfall_Numbers"] = data[cycloneNumber].get("Landfall_Numbers", 0) + 1
            else:
                data[cycloneNumber]["Landfall_Numbers"] = data[cycloneNumber].get("Landfall_Numbers", 0)
                
    
    
    for hurnum in data:
        for years in data[hurnum]["Tracked_Dates"]:
            data[hurnum]["Years"] = data[hurnum].get("Years", []) + [years[:4]]
            #creating new list value containing just the years each storm was tracked
            #print(years[:4])

    for hurnum in data:
        data[hurnum]["Maximun_Sustained_Wind"] =\
        max(data[hurnum]["Maximun_Sustained_Wind(in_knots)"]) if int(max(data[hurnum]["Maximun_Sustained_Wind(in_knots)"])) > 0 else 0
        
    return number_of_storms


def printAllNeededData(data):
    #printing out the info data we need after the needed information is written into the "data" dictionary
    for hur in data:
        print("Storm System Name: " + data[hur]["Name"])
        print("Data Range Recorded for the Storm: " + data[hur]["Tracked_Dates"][0][0:4] + '/' + data[hur]["Tracked_Dates"][0][4:6] + '/' + data[hur]["Tracked_Dates"][-1][6:] +" ~ " + data[hur]["Tracked_Dates"][0][0:4] + '/' + data[hur]["Tracked_Dates"][-1][4:6] + '/' + data[hur]["Tracked_Dates"][-1][6:])
        print("Maximun_Sustained_Wind(in_knots): " + max(data[hur]["Maximun_Sustained_Wind(in_knots)"]) )
        print("How many times it had a 'Landfall': " + str(data[hur]["Landfall_Numbers"]))
        print("==============================================")

#printAllNeededData(data)

def printTotalStromsTracked(number_of_storms):
    print("Number of Total Storm Tracked: %d " % number_of_storms)

#printTotalStromsTracked(number_of_storms)



# The Main IMPORTANT collector of all organized data
data = {} 


# reading in the file data
try:
    with open("hurdat2-1851-2016-041117.txt", "r", encoding = "UTF-8") as hur1data:
        #dataline = hur1data.readlines()
        # this will blow up the memory since it reads in all the data into a huge list --> and that blows it up
        # just use the object as an iterator

        #trying out the data

        '''
        lines = 0
        for line in hur1data:
            lines += 1
            print(line +"<------>" + str(len(line)))

            lineData = line.split(",")
            print(lineData[0], lineData)
            print("==========> " + str(len(lineData)))
            if lines == 10:
                break
            if len(line) > 21:
                print(line[38:41])
        '''
        # first method, using O(n) space to store and solve
        # creating a dictionary data structure to organize the data, saving the data we need and for easier usage for future data queries
        # using storm system cyclone number series as key, its value would be another dictionary with its corresponding key-value in it



        #call the data processing funtion to sort out the information we need into the dictionary data structure
        number_of_storms = dataProcess(data, hur1data, 0)




        #file1 closed
except:
    print("Cannot Find File!")
    

# reading in the second file data
try:
    with open("hurdat2-nepac-1949-2016-041317.txt", "r") as hur2data:
        dataProcess(data, hur2data, number_of_storms)

        #file2 closed
except:
    print("Cannot Find File!")
    
hurricanes_per_year = {}
storms_per_year = {}

def countStorms_HurricanesPerYear(hurricanes_per_year, storms_per_year):
    for hurnum in data:
        if int(data[hurnum]["Maximun_Sustained_Wind"]) >= 64:
            for years in set(data[hurnum]["Years"]): 
                # just in case some storms span across a year, using set makes each year unique with just one value of itself
                hurricanes_per_year[years] = hurricanes_per_year.get(years, 0) + 1
        else:
            for years in set(data[hurnum]["Years"]):
                storms_per_year[years] = storms_per_year.get(years, 0) + 1

countStorms_HurricanesPerYear(hurricanes_per_year, storms_per_year)


"""
# a real dumb solution
years_tracked = set() 
# using hash set is faster for the "not in" operation, because it runs linear search, thus if we use list
# it will take a long time, yet sets are faster with the 'in' operator, 
#so I changed the set into list after all years data are added then sort the list in place

def yearsInCronoList(years_tracked):
    for hurnum in data:
        for years in data[hurnum]["Tracked_Dates"]:
            if years[:4] not in years_tracked: # grabing the years tracked and put it in the list uniquely
                years_tracked.add(years[:4])

    for hurnum in data:
        for years in data[hurnum]["Tracked_Dates"]:
            data[hurnum]["Years"] = data[hurnum].get("Years", []) + [years[:4]]
            #creating new list value containing just the years each storm was tracked
            #print(years[:4])
        
    years_tracked = list(years_tracked)
    years_tracked.sort()
    
    return years_tracked

chronological_years = yearsInCronoList(years_tracked)
print(chronological_years)

def printNumbersInYears(dic = hurricanes_per_year, lst = chronological_years):
    for years in lst:
        if years in dic:
            print(years + " : " + str(dic[years]))
"""

#smarter and shorter way
def printNumbersInYears(storm_or_hurricane):
    yearList = sorted(list(storm_or_hurricane.keys()))
    for years in yearList:
        print(years + " : " + str(storm_or_hurricane[years]))

print("Hurricnaes per year:\n=====================")
printNumbersInYears(hurricanes_per_year)
print("=====================\n\n\n\n\n\n")
print("Storms per year:\n=====================")
printNumbersInYears(storms_per_year)
