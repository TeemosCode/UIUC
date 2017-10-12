"""
Roger Ho Assignment4
The program may take a little while to finish processing and display its answers (Don't really know why, might be the for loops, 
but sometimes its really fast, within 5 seconds)
"""
import pandas as pd

from pandas_datareader import data as pdr
import pandas_datareader.data as web
import pandas_datareader
import numpy as np

import matplotlib.pyplot as plt
import seaborn as sns

import datetime
from dateutil.relativedelta import relativedelta

import fix_yahoo_finance as yf

# loading data into dataframe with the fix_yahoo_finance library as the pandas_datareader can not correctly connect to yahoo finance
# we used the pandas_datareader library along with fix_yahoo_finance library to fix this problem.
# We first apply pandas_datareader's pdr_override() method to the fix_yahoo_finance library then we are good to go.
yf.pdr_override()


# index tickers
NASDAQ = '^IXIC'
NYSE = '^NYA'
Dow_Jones = '^DJI'
S_P = '^GSPC'
Shanghai = '000001.SS'
Euro = '^STOXX50E'

# create a dictionary that contains index and its corresponding tickers 
indexnames_and_tickers = {"NASDAQ" : '^IXIC', "NYSE" : '^NYA', "Dow_Jones" : '^DJI', "S_P" : '^GSPC',
                  "Shanghai" : '000001.SS', "Euro" : '^STOXX50E'}


# a function to set the time for how many months into the past up to today to download the stock data
def set_time(months = 24):
    """
    This function is used to set the time for how many months into the past up to today to download the stock data.
    The use can customize how many months they want, but the default is 24 months.
    
    :param months: The number of past months stock data to download from today
    :return start_date: The start date of the stock data for downloading
    """
    months = 24
    start_date = (datetime.datetime.now() - relativedelta(months=months)).strftime("%Y-%m-%d")
    return start_date

def user_stock_input():
    """
    The function takes in user's stock ticker's input then saves the ticker's name as the stock name and its
    corresponding ticker into the stocknames_and_tickers dictionary in the global namespace.
    
    :return: None
    """
    
    #months = int(input("How many months from the past? (default is 24 months) [Please type in integers or else program will break]"))
    user_input = input("What other stock ticker would you like to query? [Please type different tickers seperated with a comma or else the program WILL BREAK]:\n-->")
    # splits users input into a list of stock names
    tickerList = user_input.split(",")
    
    # save the ticker name (Which we also make it the stocks representing name ) into the stocknames_and_tickers
    # with the stock name as keys and its corresponding ticker name as the value
    for stock_names in tickerList:
        stocknames_and_tickers[stock_names] = stock_names
    #return months


def get_stock_data(start_date: int):
    """
    This function loops throug the index stocks dictionary (indexnames_and_tickers) 
    and user input stocks dictionary (stocknames_and_tickers) for the ticker's name and string value
    to automatically connect to yahoo finance and download the corresponding ticker as pandas' dataframe object data
    and save it into the two predefined dictionaries (index_df_Dict & stock_df_Dict) in the global namespace.
    
    :param start_date: The start date for when to download the stock ticker data
    :return: None
    """
    for stockname, tickername in stocknames_and_tickers.items():
        stock_df_Dict[stockname] = pdr.get_data_yahoo(tickername, start=start_date)
    for indexname, tickername in indexnames_and_tickers.items():
        index_df_Dict[indexname] = pdr.get_data_yahoo(tickername, start = start_date)

# Automatically	download	the	stock	data	(including	the	indexes)	for	the	past	24 months
def connect_stock_data(start_date):
    """
    Automatically download the stock data by calling the get_stock_data function.
    When all data are correctly downloaded prints to terminal the all data are finished and loaded for use.
    If there are any connection errors, the fucntion would keep calling get_stock_data function until all data
    are fully loaded.
    
    :param start_date: The start date for when to download the stock ticker data, used to pass as an argument for the get_stock_data function
    :return: None
    """
    print("Loading Data Sets From the web ...\n....\n...\n")
    while True:
        try:
            get_stock_data(start_date)
            break
        except Error as e:
            print(e)
            pass
    print("\nFinished loading data sets!\n")



# function to create dataframe that contains only the index stock's "Adjusted Close" price values.
def create_indexAdjClose_df():
    """
    Since we are only interested in each stock's "Adjusted Close" price. Thus we initialize another pandas dataframe 
    --> index_adjclose_df, to save only the "Adjusted Close" column data of each index stocks tickers' dataframe from 
    the index_df_Dict dictionary in the global namespace.
    
    :return index_adjclose_df: A pandas dataframe object containing each index stock ticker's "Adj Close" price values
    """
    # initialize pandas dataframe object
    index_adjclose_df = pd.DataFrame()
    
    # loop through each index stock's tickers' name in the index_df_Dict dictionary in the global namespace and save
    # their "Adj Close" column price values into the index_adjclose_df dataframe
    for index_name in index_df_Dict:
        index_adjclose_df[index_name] = index_df_Dict[index_name]["Adj Close"]
        
    return index_adjclose_df


# function to create dataframe that contains only the user's input stocks' "Adjusted Close" price values.
def create_stockAdjClose_df():
    """
    Since we are only interested in each stock's "Adjusted Close" price. Thus we initialize another pandas dataframe 
    --> stock_adjclose_df, to save only the "Adjusted Close" column data of each user's input stocks tickers' dataframe from 
    the stock_df_Dict dictionary in the global namespace.
    
    :return index_adjclose_df: A pandas dataframe object containing each user's input stocks' ticker's "Adj Close" price values
    """
    # initialize pandas dataframe object
    stock_adjclose_df = pd.DataFrame()
    
    # loop through each user's stock's tickers' name in the stock_df_Dict dictionary in the global namespace and save
    # their "Adj Close" column price values into the stock_adjclose_df dataframe
    for stock_name in stock_df_Dict:
        stock_adjclose_df[stock_name] = stock_df_Dict[stock_name]["Adj Close"]
    
    return stock_adjclose_df




# Merge both of index (index_adjclose_df) and stock's (stock_adjclose_df) dataframe for correlation calculation and analysis
def merge_for_corr(index_adjclose_df, stock_adjclose_df):
    """
    Merges both of index (index_adjclose_df) and stock's (stock_adjclose_df) dataframe 
    for correlation calculation and analysis
    
    :param index_adjclose_df: The index_adjclose_df dictionary in the global namespace containing index ticker's "Adjust Close" price values
    :param stock_adjclose_df: The stock_adjclose_df dictionary in the global namespace containing index ticker's "Adjust Close" price values
    
    :return correlation_df: The dataframe that contains both index and user's input stocks' tickers' "Adjusted Close" price values.
    """
    # Merge both index dataframes and users' input stock dataframes by column (axis = 1)
    correlation_df = pd.concat([index_adjclose_df, stock_adjclose_df], axis = 1)
    return correlation_df



# Calculating the correlation of user's input stocks and index stocks adjusted close price
def calculate_correlation(correlation_df):
    """
    Calculate percentage change on the stock prices and indexes to first normalize eveything to a common range.
    Then calculate the correlations in the correlation_df dataframe, subset it to only containing the index tickers'
    as columns and user's input stocks' tickers as row (index) and save the subset to a new datafram object-->
    index_stock_corr_df and return the dataframe
    
    :param correlation_df: The dataframe that contains the merged users' input stock and index stock dataframe.
    :return index_stock_corr_df: Dataframe object that contains the correlation of user's input stocks' (as the ROW index)
    & index stocks' (as the Columns)
    """
    # Calculate percentage changes on the stock prices & indexes
    correlation_df = correlation_df.pct_change() 

    # Calculate the correlations in the correlation_df dataframe, subset it to only containing the index tickers'
    # save the subset to a new datafram object--> index_stock_corr_df and return the dataframe
    index_stock_corr_df = correlation_df.corr().loc[list(stock_df_Dict.keys()),list(index_df_Dict.keys())]
    
    return index_stock_corr_df


# create the mean of correlation for both rows (user input stocks) and columns (index stocks) of the index_stock_corr_df dataframe
def create_corr_mean(correlation_df, index_stock_corr_df):
    """
    In order to know which index correlates the most strongly with each individual stock and vice versa, we calculate the
    mean of the correlation for each index and each individual stock. Then we add these tow new values as a new row and column
    for the index_stock_corr_df for further calculations.
    
    :param correlation_df: The dataframe that contains the merged users' input stock and index stock dataframe.
    :param index_stock_corr_df: Dataframe object that contains the correlation of user's input stocks' (as the ROW index)
    & index stocks' (as the Columns)
    
    :return index_stock_corr_df: The index_stock_corr_df dataframe with newly added correlation mean row and column.
    """
    # axis = 1, mean for rows
    # index_stock_corr_df["Adj_Close_MEAN"]
    row_corr_mean = correlation_df.corr().loc[list(stock_df_Dict.keys()),list(index_df_Dict.keys())].mean(axis = 1)

    # axis = 0, mean for columns
    # index_stock_corr_df.loc["Adj_Close_MEAN"]
    col_corr_mean = correlation_df.corr().loc[list(stock_df_Dict.keys()),list(index_df_Dict.keys())].mean(axis = 0)

    # add the rows correlation mean under a new column name : "Adj_Close_MEAN" in the index_stock_corr_df dataframe
    index_stock_corr_df["Adj_Close_MEAN"] = row_corr_mean
    # add the columns correlation mean in a new row name : "Adj_Close_MEAN" in the index_stock_corr_df dataframe
    index_stock_corr_df.loc["Adj_Close_MEAN"] = col_corr_mean
    
    return index_stock_corr_df



def most_strongly_corr(index_stock_corr_df):
    """
    Because the index ticker with the largest correlation mean with user input stocks means that it correlates the strongest
    with all other user input stocks on average than other index ticker, and vice versa.
    Thus, to know which index correlates the most strongly with each individual stock and vice versa, the funtion finds the ticker
    with the largest correlation mean for both column(index) and row(input stocks).
    
    It then displays the largest correlation mean value and the name of the ticker for both index and user input stock.
    
    :param index_stock_corr_df: The index_stock_corr_df dataframe with newly added correlation mean row and column.
    :return: None
    """
    # for rows --> stock -> index
    # The stock name that has the largest correlation mean with all index
    stock_name = ''.join(list(index_stock_corr_df[index_stock_corr_df.Adj_Close_MEAN == index_stock_corr_df.Adj_Close_MEAN.max()].index))
    
    print("The 'stock' that correlates most strongly with each individual index :  " + stock_name)
    print("Mean Value of its correlation: " + str(index_stock_corr_df.Adj_Close_MEAN.max()))

    print("===========================================================================")
    # for col --> index -> stock
    # The index name that has the largest correlation mean with all stocks
    index_name = ''.join(index_stock_corr_df.loc[:,index_stock_corr_df.loc["Adj_Close_MEAN"] == index_stock_corr_df.loc["Adj_Close_MEAN"].max()].columns)
    
    print("The 'index' that correlates most strongly with each individual stock :  " + index_name)
    print("Mean Value of its correlation: " + str(index_stock_corr_df.loc["Adj_Close_MEAN"].max()))






def correlation_shift():
    """
    Shift the dataframes for different numbers, calculate the correlation between different shifts of days, generating 
    different dataframes then assign those dataframes to the shift_corr_df_dict dictionary in the global namespace as values 
    with their number of shifts as keys.

    :return: None
    """
    # The 5 numbers of shifts (negative numbers to mean shifting the rows upwards, camparing each data with its previous number of shifts data)
    num_of_shift = range(-1,-6,-1)

    # calculate the correlation between different shifts of days, generating dataframes to save it in the shift_corr_df_dict dictionary
    for num in num_of_shift:
        shift_corr_df_dict[-num] = (correlation_df - correlation_df.shift(num)).corr().loc[list(stock_df_Dict.keys()),list(index_df_Dict.keys())]



# Function that finds and outputs information on stocks that correlate more strongly with an index when shifted
def find_stronger_corelation(shiftnum: int):
    """
    The function calculates whether there is a stronger correlation of stocks and index when shifted.
    If there is ,the subtraction of previous original dataframe (unshifted index_stock_corr_df) would have values
    smaller than 0.
    After making sure there is a stronger correlation, the function then saves those values it
    finds and outputs information on stocks that correlate more strongly with and index when shifted
    
    :param shiftnum: The shifted numbers of each dataframe. Used for finding its correlated shifted dataframe in the
    shift_corr_df_dict dictionary in the global namespace.
    
    :return: None
    """
    # are there any negative values? --> meaning that there is a stronger correlation
    if (index_stock_corr_df[(index_stock_corr_df - shift_corr_df_dict[shiftnum]) < 0].count() > 0).any():
        ls = []
        sub_df = index_stock_corr_df - shift_corr_df_dict[shiftnum]
        for array in (index_stock_corr_df - shift_corr_df_dict[shiftnum]).values:
            for value in array:
                if value < 0:
                    ls.append(value)
        # If there are NO stronger correaltions for the numbers (shiftnum) of shifts
        if ls == []:
            print("There are NO Stronger correlations for '",shiftnum,"' of shifts!")
            return
    
        # loop through each value of the data frame to find the column and index names of the smallest(most negative) value
        # which means that the shifted dataframe had the largest correlation.
        # Once found, output the row( user input stocks) and column(index stock ticker) that has the "strongest" findings
        for row in sub_df.index:
            for col in sub_df.columns:
                if sub_df.loc[row, col] == min(ls):
                    print("=======\nThe 'shift number' : ", shiftnum,"\nThat has the STONGEST correlation after the shift: \n",
                          "     Stock Name: '", row,"'\n", "     Index Name: '", col,"'\n")
                
# function that loops through the find_stronger_corelation dictionary and calling the 'find_stronger_corelation' function each loop
def names_shifts_of_stronger_correlation():
    """
    Loops through all the shifted numbers in shift_corr_df_dict dictionary in the global namespace and pass those
    numbers into the find_stronger_corelation to find and output the strongest correlation index and stock names.

    :return: None
    """
    for shiftnum in shift_corr_df_dict:
        find_stronger_corelation(shiftnum)







# set the time for the start of the stocks we are going to download
start_date = set_time()

# Create Stock dictionary to save user's input stock's ticker's names and its corresponding tickers
stocknames_and_tickers = {}
index_df_Dict = {} # a dictionary used to contain different stock ticker names with their corresponding dataframe
stock_df_Dict = {} # a dictionary used to contain user input tickers names and its dataframe
# initialize a dictionary to save the different dataframes containing the correlations of 5 numbers of shifts
shift_corr_df_dict = {} 

                
user_stock_input()
# Automatically	download	the	stock	data	(including	the	indexes)	for	the	past	24 months
connect_stock_data(start_date)
# function to create dataframe that contains only the index stock's "Adjusted Close" price values.
index_adjclose_df = create_indexAdjClose_df()
# function to create dataframe that contains only the user's input stocks' "Adjusted Close" price values.
stock_adjclose_df = create_stockAdjClose_df()
# Merge both of index (index_adjclose_df) and stock's (stock_adjclose_df) dataframe for correlation calculation and analysis
correlation_df = merge_for_corr(index_adjclose_df, stock_adjclose_df)
# Calculating the correlation of user's input stocks and index stocks adjusted close price
index_stock_corr_df = calculate_correlation(correlation_df)

# create the mean of correlation for both rows (user input stocks) and columns (index stocks) of the index_stock_corr_df dataframe
index_stock_corr_df = create_corr_mean(correlation_df, index_stock_corr_df)

most_strongly_corr(index_stock_corr_df)

correlation_shift()

# function that loops through the find_stronger_corelation dictionary and calling the 'find_stronger_corelation' function each loop
names_shifts_of_stronger_correlation()



