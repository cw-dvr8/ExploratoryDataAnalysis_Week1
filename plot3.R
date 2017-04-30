#-------------------------------------------------------------------#
# Program: plot3.R                                                  #
# Author: Cindy Molitor                                             #
# Creation Date: 29Apr2017                                          #
# Purpose: Create a graph of household sub-metering over day of the #
#          week for the specified two days.                         #
# Project: Coursera Data Science program                            #
#          Exploratory Data Analysis Week 1 programming assignment  #
#                                                                   #
# Inputs: household_power_consumption.txt                           #
#                                                                   #
# Outputs: plot3.png                                                #
#-------------------------------------------------------------------#

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

png('plot3.png', width=480, height=480)

plot(hpc_df$date_time, hpc_df$Sub_metering_1,
     type="l",
     xlab="",
     ylab="Energy sub metering")
lines(hpc_df$date_time, hpc_df$Sub_metering_2, col="red")
lines(hpc_df$date_time, hpc_df$Sub_metering_3, col="blue")

legend("topright",
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),
       lty=1)

dev.off()

#----- End of Program -----#