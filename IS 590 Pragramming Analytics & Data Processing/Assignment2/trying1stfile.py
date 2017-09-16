with open("hurdat2-1851-2016-041117.txt", "r", encoding = "UTF-8") as hur1data:
    dataline = hur1data.readlines()
    
    #trying out the data
    for i in range(10):
        print(dataline)
