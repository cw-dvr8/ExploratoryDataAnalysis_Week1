#--------------------------------------------------------------------------#
# Program: plot2.R                                                         #
# Author: Cindy Molitor                                                    #
# Creation Date: 29Apr2017                                                 #
# Purpose: Create a graph of household global active power over day of the #
#          week for the specified two days.                                #
# Project: Coursera Data Science program                                   #
#          Exploratory Data Analysis Week 1 programming assignment         #
#                                                                          #
# Inputs: household_power_consumption.txt                                  #
#                                                                          #
# Outputs: plot2.png                                                       #
#--------------------------------------------------------------------------#

#-------------------------------------------------------------------------#
# The file has over 2 million rows, so use sqldf to only read in the data #
# for the specified dates.                                                #
#-------------------------------------------------------------------------#
library(sqldf)
hpc <- file('household_power_consumption.txt')
attr(hpc, "file.format") <- list(sep=';', header=TRUE)
hpc_df <- sqldf("select * from hpc where Date='1/2/2007' or Date='2/2/2007'")

#----------------------------------------------------------------#
# Add a column to the data frame for the combined date and time. #
#----------------------------------------------------------------#
hpc_df$date_time <- as.POSIXct(paste(hpc_df$Date, hpc_df$Time),
                               format="%d/%m/%Y %H:%M:%S")

png('plot2.png', width=480, height=480)

plot(hpc_df$date_time, hpc_df$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)")

dev.off()

#----- End of Program -----#