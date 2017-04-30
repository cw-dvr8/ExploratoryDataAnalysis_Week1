#---------------------------------------------------------------------------#
# Program: plot4.R                                                          #
# Author: Cindy Molitor                                                     #
# Creation Date: 29Apr2017                                                  #
# Purpose: Create four graphs based on the household power consumption data #
#          frame.                                                           #
# Project: Coursera Data Science program                                    #
#          Exploratory Data Analysis Week 1 programming assignment          #
#                                                                           #
# Inputs: household_power_consumption.txt                                   #
#                                                                           #
# Outputs: plot4.png                                                        #
#---------------------------------------------------------------------------#

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

png('plot4.png', width=480, height=480)

par(mfcol=c(2,2))

#-------------#
# First graph #
#-------------#
plot(hpc_df$date_time, hpc_df$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)")

#--------------#
# Second graph #
#--------------#
plot(hpc_df$date_time, hpc_df$Sub_metering_1,
     type="l",
     xlab="",
     ylab="Energy sub metering")
lines(hpc_df$date_time, hpc_df$Sub_metering_2, col="red")
lines(hpc_df$date_time, hpc_df$Sub_metering_3, col="blue")

legend("topright",
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),
       lty=1,
       bty="n")

#-------------#
# Third graph #
#-------------#
plot(hpc_df$date_time, hpc_df$Voltage,
     type="l",
     xlab="datetime",
     ylab="Voltage")

#--------------#
# Fourth graph #
#--------------#
plot(hpc_df$date_time, hpc_df$Global_reactive_power,
     type="l",
     xlab="datetime",
     ylab="Global_reactive_power")

dev.off()

#----- End of Program -----#