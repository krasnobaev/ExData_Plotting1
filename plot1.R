#
# This script reproduces energy usage histogramm to fulfill task 1
# of Programming Assignment 1 of Exploratory Data Analysis course
# (https://class.coursera.org/exdata-004/)
#
# Time interval - 2-day period in February, 2007
# Raw Data      - Electric power consumption dataset
# https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption
# 
# I use grep because it don't require to load entire dataset to RAM
# to filter two days
#
# REQUIREMENTS: grep
# tested on linux
# @author Aleksey Krasnobaev, https://github.com/krasnobaev
#

## input dataset
csvname <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'

## download and unzip to temp location
temp    <- tempfile()
tempdir <- tempdir()
download.file(csvname, temp, 'curl')
unzip(temp, exdir=tempdir)

## extract two-day interval to local directory
f2007_02_0102 <- 'household_power_consumption_2007_0102.txt'
system(paste("head -n 1 '", tempdir,
             "/household_power_consumption.txt' > ",
             f2007_02_0102, sep=""))
system(paste("grep '^[12]/2/2007' '", tempdir,
             "/household_power_consumption.txt' >> ",
             f2007_02_0102, sep=""))

## load
data <- read.csv(f2007_02_0102, sep=";", na.strings="?",
                 colClasses=c(rep("character",2), rep("numeric",7)))

png("plot1.png", height=480, width=480, bg="transparent")
hist(data$Global_active_power, col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")

## cleaning
dev.off()
unlink(temp)
unlink(tempdir)
