# Group Member Names: Roger Ho, Vaishnavi Padala, Gopikrishnan Pararath Radhakrishnan
# Roger Ho
# Vaishnavi Padala
# Gopikrishnan Pararath Radhakrishnan

# The program prints out the all the needed data calculated and collected of each storm in both data source files. 
# All the data can be seen in a dictionary format with : print(data)

from pygeodesy import ellipsoidalVincenty as ev
import datetime, time

start = time.time() # The timer variable to track the time this program needs to finish processing


# A function to categorize the data for easier use in the future
def dataProcess(data, file, number_of_storms):
    """Main processing function that retrives and saves the data we need with using other defined functions.
    Butmost importantly, it keeps the flow of reading in the data and controlls variables that would be use
    across different functions and different lines of data. Thus, the process and logic of finding the informations of 
    number 10,11,12,13,14 are written in this function.
    Infomation the function retrieves and calculates:
        1. Strom Name
        2. Tracked Number
        3. Number of Landfalls
        4. Maximun Sustained Wind (In Knots)
        5. Years of the Storm Tracked
        6. Date and Time when the Maximun Sustained Wind was tracked
        7. Starting Date when each individual storm was tracked
        8. Ending Date when each individual storm was tracked
        9. Total time (in seconds) each storm was tracked
        10. Total distance the storm traveled
        11. Directional change after the first landfall
        12. Maximun Moving Speed (meters/seconds) of the Storm
        13. Average Storm moving speed (mean speed)
        14. Maximun directional change per uit time
        
    :param data: The data dictionary saving all the necessary data from the source file
    :param file: The file object that is opened for reading, the file containing the original data
    :param number_of_storms: A global variable to save the total number of storms tracked in the data from the opened file
    
    :returns number_of_storms: An integer number representing total numbers of storms tracked from the government data
    """
    # create variables to keep track of whether the loop has begun searching through a new strom in order to track information such as the starting and ending date for each storm
    # used for the functions: start_End_TrackingTime, distance_run
    tracked_date = ''
    previous_cycloneNumber = 'dummyNode' # initialize or else it'll get a key error
    data[previous_cycloneNumber] = {}
    
    # tracking distance
    previous_longlat = tuple()
    distance = 0
    
    number_of_storms = 0
    
    for line in file:
        lineData = line.split(",")
        
        # Looping through each line of the data source file, the ones that don't have the length of 21 means its a line about a different storm
        # In other words, if looped to a line length that is not 21, means its a start of data reagarding a new storm.
        # Thus this is where most variables for each Different storm gets initialized
        if len(lineData) != 21:
            dataLine = 0 # tracking the number of data looped in each storm for usage of tracking its first data
            speed = 0 # speed of storm between each data
            First_landfall_happened = False # used as a flag for checking the first happening of landfall for each storm
            landfall_happened = False # used to check with the First_landfall_happened
            
            number_of_storms += 1
            cycloneNumber = lineData[0]
            data[cycloneNumber] = {} # Create another dictionary within the main 'data' dictionary with each storms number as key and all other imformation we need as values
            data[cycloneNumber]["Name"] = lineData[1].strip() # clean out the spaces in the string
            data[cycloneNumber]["Tracked_Numbers"] = int(lineData[2].strip()) #clean out the spaces in the string
            
            data[cycloneNumber]["distance"] = 0 # initialize Total distance to 0 everytime we loop to a new storm
            data[cycloneNumber]["Total_time(in Seconds)"] = 0 # initialize time to 0 everytime we loop to a new storm
            data[cycloneNumber]["Directional_change(afterFirstLandFall)"] = 0 # initialize greatest directional change in order to calculate the percentage of max changes that may happen after hitting the first landfall. 
            data[cycloneNumber]["Max_Speed(meters/seconds)"] = 0 # initialize maximun speed of the storm
            data[cycloneNumber]["Max_dirchange_pertime"] = 0 # initialize maximum directional change per unit time (in seconds)
        else:
            
            # Function to save the Landfall numbers for the storm, and return "boolean" information on whethere there is a landfall for this current tracked data or not
            landfall_happened = get_landfall(cycloneNumber, lineData)
            
            dataLine += 1 # if it is the first line of each storm data, initialize the "previous_longlat" variable with its long and latitude in a tuple
            if dataLine == 1:
                previous_longlat = (lineData[4].strip(), lineData[5].strip()) # setting the first line of data as the initialize value to build on in the later loops
                previous_timeString = lineData[0][:4] + ":" + lineData[0][4:6] + ":" + lineData[0][6:] + ":" + lineData[1].strip()[:2] + ":" + lineData[1].strip()[:2] # time string to work with python datetime module # tracking the time of each strom data
                max_dirchange_pertime = 0
            else:
                current_timeString = lineData[0][:4] + ":" + lineData[0][4:6] + ":" + lineData[0][6:] + ":" + lineData[1].strip()[:2] + ":" + lineData[1].strip()[:2] # time string to work with python datetime module
                current_longlat = (lineData[4].strip(), lineData[5].strip()) # tracking each latitude and longtitude
                
                # if the storm didn't move its position or the tracked times were duplicated, the value will not change
                if current_longlat == previous_longlat or previous_timeString == current_timeString:
                    data[cycloneNumber]["Max_Speed(meters/seconds)"] = data[cycloneNumber].get("Max_Speed(meters/seconds)", 0)
                else:
                    # do calculations
                    pre = ev.LatLon(previous_longlat[0], previous_longlat[1]) # previous data of long latitude value
                    cur = ev.LatLon(current_longlat[0], current_longlat[1]) # current data of long lat value
                    distance = pre.distanceTo3(cur)[0] # distance between the current storm and the previous storm
                    direction = pre.bearingTo(cur) # the angle bearing of the storm between its previous tracked data and the current one
                    
                    data[cycloneNumber]["distance"] += distance # Total distance

                    #lineData[1].strip() is the time string
                    # using datetime.datetime objects to count the time difference
                    curtime = datetime.datetime.strptime(current_timeString, "%Y:%m:%d:%H:%M")
                    pretime = datetime.datetime.strptime(previous_timeString, "%Y:%m:%d:%H:%M")
                    timeDiff = (curtime - pretime).total_seconds() # time difference in seconds of previous tracked data and current tracked data of the storm

                    data[cycloneNumber]["Total_time(in Seconds)"] += timeDiff# the Total of the time

                    speed = distance / timeDiff # the Speed.
                    
                        
                    direction_change_pertime = direction / timeDiff # the compass bearing change per unit time
                    
                    # track greates directional change per unit time
                    if max_dirchange_pertime < direction_change_pertime: max_dirchange_pertime = direction_change_pertime 
                    data[cycloneNumber]["Max_dirchange_pertime"] = max_dirchange_pertime
                    
                    if First_landfall_happened == True: # this will be changed from the previous line of tracked data if first landfall happened
                        First_landfall_happened = None # set it to None so it would no longer be changed when there are further landfalls
                        data[cycloneNumber]["Directional_change(afterFirstLandFall)"] = direction_change_pertime # save in the changed direction per unit time after first landfall
                        
                    
                    if landfall_happened == True and First_landfall_happened == False: # tracked "first" landfall
                        First_landfall_happened = True # for next data reference
                        
                    # keeping track of each storms maximum speed throughout its data
                    data[cycloneNumber]["Max_Speed(meters/seconds)"] = data[cycloneNumber].get("Max_Speed(meters/seconds)", 0) if data[cycloneNumber].get("Max_Speed(meters/seconds)", 0) > speed else speed

                    previous_longlat = current_longlat # hold onto the current longlat value for the calculations of next line of data
                    previous_timeString = current_timeString # time strings update for next use
                
            # Saving the values of the previous storm number in the file object and its tracked date
            previous_cycloneNumber, tracked_date =\
            start_End_TrackingTime(data, lineData, cycloneNumber, previous_cycloneNumber, tracked_date)
            

                
            # Function to save the "year" or "years" the storm was tracked
            year_storm_tracked(cycloneNumber, lineData)
            
            # Function to save the maximun sustained wind (in Knots) for the strom
            get_maximun_sustained_wind(cycloneNumber, lineData)
    
    del data["dummyNode"]  # delete the dummyKey after all data have been looped through in order to keep the robustness of the data ditionary and prevent anyfuture errors that it may cause
    data[previous_cycloneNumber]["Tracked_End_Date"] = tracked_date # gives the very last storm its max wind tracked date and time so it wouldn't cause an error later in the printAllNeededData() function.
    
    meanSpeed(data) # calculate the mean speed and put save those information to the data dictionary
    
    return number_of_storms


def start_End_TrackingTime(data , lineData, cycloneNumber, previous_cycloneNumber, tracked_date):
    """
    A function that saves the starting date and ending date of each tracked storm at the very moment they were tracked in the data
    Updates the 'data' global dictionary, creating two new keys "Tracked_End_Date" and "Tracked_Start_Date" to save the information.
    
    :param data: The data dictionary saving all the necessary data from the source file
    :param lineData: Passed in from the "dataProcess" function. A List of each line of data split by the comma when reading in the source file
    :param cycloneNumber: Passed in from the "dataProcess" function during each loop of data. Storm number in Strings of each CURRENT storm from the source file.
    :param previous_cycloneNumber: Passed in from the "dataProcess" function during each loop of data. Storm number in Strings of each PREVIOUS storm from the source file.
    :param tracked_data: Passed in from the "dataProcess" function during each loop of data. The date of the PREVIOUS line of data of the storm when it was tracked for each storm.
    Used as a buffer container for the end date of the previous strom of the current storm loop.
    
    :returns previous_cycloneNumber, tracked_date. Making these changed data global by returning them in the "dataProcess" function to keep track of these two data
    """
    if not previous_cycloneNumber == cycloneNumber:
        data[previous_cycloneNumber]["Tracked_End_Date"] = tracked_date
        previous_cycloneNumber = cycloneNumber
        data[cycloneNumber]["Tracked_Start_Date"] = lineData[0] # save the starting date
    else:
        tracked_date = lineData[0]
    return previous_cycloneNumber, tracked_date # variables that would constantly be updated to track the starting and ending time of each storm


def year_storm_tracked(cycloneNumber, lineData):
    """
    Tracks the "year" when each storm was tracked. Yet some stroms may be tracked across two years. Thus saving the data into a List.
    Updates the 'data' global dictionary, creating a new key "Years" to save the information.
    
    :param cycloneNumber: Passed in from the "dataProcess" function during each loop of data. Storm number in Strings of each CURRENT storm from the source file.
    :param lineData: Passed in from the "dataProcess" function. A List of each line of data split by the comma when reading in the source file
    """
    # setting the "Years" key to a list containing 'only' the years the storm was tracked, yet a very few storms may be tracked across 2 years, ex. 1995/12/31~1996/01/03, so set it to list and append the other year value
    data[cycloneNumber]["Years"] = data[cycloneNumber].get("Years", []) + [lineData[0][:4]] if lineData[0][:4] not in data[cycloneNumber].get("Years", []) else data[cycloneNumber].get("Years", [])


def get_maximun_sustained_wind(cycloneNumber, lineData):
    """
    Tracks the maximum sustained wind in knots for each storm and the time when it happened. 
    Updates the 'data' global dictionary, creating two new keys "Maximun_Sustained_Wind(in_knots)" and "When_Max_Wind_Occurred" to save the information.
    
    :param cycloneNumber: Passed in from the "dataProcess" function during each loop of data. Storm number in Strings of each CURRENT storm from the source file.
    :param lineData: Passed in from the "dataProcess" function. A List of each line of data split by the comma when reading in the source file
    """
    if data[cycloneNumber].get("Maximun_Sustained_Wind(in_knots)", 0) < int(lineData[6].strip()):
        data[cycloneNumber]["Maximun_Sustained_Wind(in_knots)"] = int(lineData[6].strip())
        # This makes will make some storm data unable to have the key "Tracked_Start_Date" since some storms have no data about the maxWind in knots at all, remember to check whether key exists or not first when dealing with the "When_Max_Wind_Occurred" key later on.
        data[cycloneNumber]["When_Max_Wind_Occurred"] = [lineData[0], lineData[1]] # saving the time of when the maximum wind occurred
    else:
        data[cycloneNumber]["Maximun_Sustained_Wind(in_knots)"] = data[cycloneNumber].get("Maximun_Sustained_Wind(in_knots)", 0)

        
def get_landfall(cycloneNumber, lineData):
    """
    Tracks the number of landfall that happened for each storm. 
    Updates the 'data' global dictionary, creating the new key "Landfall_Numbers" to save the information.
    
    :param cycloneNumber: Passed in from the "dataProcess" function during each loop of data. Storm number in Strings of each CURRENT storm from the source file.
    :param lineData: Passed in from the "dataProcess" function. A List of each line of data split by the comma when reading in the source file
    """
    if lineData[2].strip() == "L":
        data[cycloneNumber]["Landfall_Numbers"] = data[cycloneNumber].get("Landfall_Numbers", 0) + 1
        return True # meaning landfall happened, passing this data would help us combine it with the direction changes per unit time in the next line of data
    else:
        # some do not cause a landfall, thus need to initialize the landfall key to 0 for futher use and to keep the data dictionary robust
        data[cycloneNumber]["Landfall_Numbers"] = data[cycloneNumber].get("Landfall_Numbers", 0)
        return False

        
def meanSpeed(data):
    """
    Calculate and tracks the Mean speed of each storm based on the two keys "distance" and "Total_time(in Seconds)" in the "data" dictionary. 
    Updates the 'data' global dictionary, creating a new key "Mean_Speed(meters/seconds)" to save the information.
    """
    for cycloneNumber in data:
        if data[cycloneNumber]["distance"]==0 or data[cycloneNumber]["Total_time(in Seconds)"]==0:
            data[cycloneNumber]["Mean_Speed(meters/seconds)"] = 0
        else:
            data[cycloneNumber]["Mean_Speed(meters/seconds)"] = data[cycloneNumber]["distance"] / data[cycloneNumber]["Total_time(in Seconds)"]
            

def printAllNeededData(data):
    """print out the info data we need based on the information calculated and stored in the "data" dictionary in the "dataProcess" function:
    
        1. Storm Name
        2. Date Range Recorded for the Storm
        3. Maximun Sustained Wind (in Knots)
        4. How many Times the Strom had a Landfall
    
        after the needed information is written into the "data" dictionary
        
    :param data: The data dictionary that holds necessary values
    :returns: None
    """
    for cycloneNumber in data:
        print("Storm System Name: " + data[cycloneNumber]["Name"])
        print("Date Range Recorded for the Storm: " + data[cycloneNumber]["Tracked_Start_Date"][0:4] + '/' + data[cycloneNumber]["Tracked_Start_Date"][4:6] + '/' + data[cycloneNumber]["Tracked_Start_Date"][6:] +" ~ " + data[cycloneNumber]["Tracked_End_Date"][0:4] + '/' + data[cycloneNumber]["Tracked_End_Date"][4:6] + '/' + data[cycloneNumber]["Tracked_End_Date"][6:])
        print("Maximun_Sustained_Wind(in_knots): " + str(data[cycloneNumber]["Maximun_Sustained_Wind(in_knots)"]))
        if "When_Max_Wind_Occurred" not in data[cycloneNumber]:
            print("Storm Missing the Maximum_Sustained_Wind data. No Time and Date of such data!")
            #print("    Date & Time of Occurence ---> Date: %s , Time: %s" % (data[cycloneNumber]["When_Max_Wind_Occurred"][0], data[cycloneNumber]["When_Max_Wind_Occurred"][1] ))
        else:
            print("    Date & Time of Occurence ---> Date: %s , Time: %s" % (data[cycloneNumber]["When_Max_Wind_Occurred"][0], data[cycloneNumber]["When_Max_Wind_Occurred"][1] ))
        print("How many times it had a 'Landfall': " + str(data[cycloneNumber]["Landfall_Numbers"]))
        print("Mean(Average) Speed of storm': " + str(data[cycloneNumber]["Mean_Speed(meters/seconds)"]))
        print("Total Distance Traveled : " + str(data[cycloneNumber]["distance"]) )
        print("Total Time(in seconds) storm traveled : " + str(data[cycloneNumber]["Total_time(in Seconds)"]) )
        print("Maximum Speed(meters/seconds) : " + str(data[cycloneNumber]["Max_Speed(meters/seconds)"]))
        print("Maximum Directional Change Per Unit Time (in Seconds) : " + str(data[cycloneNumber]["Max_dirchange_pertime"]))
        print("==============================================")

        
def printTotalStromsTracked(number_of_storms):
    """Prints Number of Total Storms Tracked
    
    :param number_of_storms: An integer number of the total storms tracked, an output from the dataProcess function
    :returns: None
    """
    print(" ===== Number of Total Storm Tracked: %d =====" % number_of_storms) 

    
def countStorms_HurricanesPerYear(hurricanes_per_year, storms_per_year):
    """Loops through the data dictionary created previously and determine the type of strom, 
    based on whether the "Maximun_Sustained_Wind value is larger than 64 or not. Then update
    the number of the storm type happenings within the two dictionary passed in as arguments.
    
    :param hurricanes_per_year: The dictionary saving number of hurricanes documented in different years
    :param storms_per_year: The dictionary saving number of storms documented in different years
    :returns: None
    """
    for hurnum in data:
        if int(data[hurnum]["Maximun_Sustained_Wind(in_knots)"]) >= 64:
            for years in set(data[hurnum]["Years"]): 
                # just in case some storms span across a year, using set makes each year unique with just one value of itself
                hurricanes_per_year[years] = hurricanes_per_year.get(years, 0) + 1
        else:
            for years in set(data[hurnum]["Years"]):
                storms_per_year[years] = storms_per_year.get(years, 0) + 1

                
def printNumbersInYears(storm_or_hurricane):
    """
    Prints the years in order and its corresponding tracked number of storms or hurricanes depending on the passed in dictionary argument.
    
    :param storm_or_hurricane: A dictionary containing the information number of a storm or hurricanes tracked per year depending on the dictionary data. 
    """
    yearList = sorted(list(storm_or_hurricane.keys()))
    for years in yearList:
        print(years + " : " + str(storm_or_hurricane[years]))
    

    
def percentage_storm_dirChange_first_landfall(data, number_of_storms):
    counter = 0
    for hurnum in data:
        if data[hurnum]['Directional_change(afterFirstLandFall)'] != 0:
            counter += 1
    print("Percentage of Storm that has a directional change after the First landfall : %d / %d " % (counter, number_of_storms))
    print(" = %f" % (counter / number_of_storms))


# Program Main Body
# reading in the file data and perform dataProcess on the file object to extract the data we need.
with open("hurdat2-1851-2016-041117.txt", "r", encoding = "UTF-8") as hur1data:
    # The Main IMPORTANT collector of all organized data
    data = {}

    #call the data processing funtion to sort out the information we need into the dictionary data structure
    number_of_storms = dataProcess(data, hur1data, 0)
    
    #file1 closed

# reading in the second file data
with open("hurdat2-nepac-1949-2016-041317.txt", "r") as hur2data:
    
    dataProcess(data, hur2data, number_of_storms)

    #file2 closed

percentage_storm_dirChange_first_landfall(data, number_of_storms) # calculating the percentage of storms that had a directional change after first landfall    
    
printTotalStromsTracked(number_of_storms) # print total number of storms tracked in both data files
 
hurricanes_per_year = {}
storms_per_year = {}

countStorms_HurricanesPerYear(hurricanes_per_year, storms_per_year) # calculate the number of storms and hurricanes happening throughout the years they were tracked

print("Hurricnaes per year:\n=====================")
printNumbersInYears(hurricanes_per_year) # print the number of hurricanes tracked for their tracked years
print("\n\n\n")
print("Storms per year:\n=====================")
printNumbersInYears(storms_per_year) # print the number of storms tracked for their tracked years
print("\n\nAll Needed Data:")
printAllNeededData(data) # printing out all needed data of Assignment 


print(" Time spent running the program : " , time.time() - start , " Seconds") # printing out the time it takes to run the whole program, normally around 15 seconds