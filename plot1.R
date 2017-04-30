#-----------------------------------------------------------------------#
# Program: plot1.R                                                      #
# Author: Cindy Molitor                                                 #
# Creation Date: 29Apr2017                                              #
# Purpose: Create a histogram of household global active power over the #
#          specified two days.                                          #
# Project: Coursera Data Science program                                #
#          Exploratory Data Analysis Week 1 programming assignment      #
#                                                                       #
# Inputs: household_power_consumption.txt                               #
#                                                                       #
# Outputs: plot1.png                                                    #
#-----------------------------------------------------------------------#

#-------------------------------------------------------------------------#
# The file has over 2 million rows, so use sqldf to only read in the data #
# for the specified dates.                                                #
#-------------------------------------------------------------------------#
library(sqldf)
hpc <- file('household_power_consumption.txt')
attr(hpc, "file.format") <- list(sep=';', header=TRUE)
hpc_df <- sqldf("select * from hpc where Date='1/2/2007' or Date='2/2/2007'")

png('plot1.png', width=480, height=480)

hist(hpc_df$Global_active_power,
     col='red',
     main='Global Active Power',
     xlab='Global Active Power (kilowatts)')

dev.off()

#----- End of Program -----#

