library(dplyr)

# read the dataframe
pcons <- read.csv(file="household_power_consumption.txt",
                  header=TRUE, sep=";", dec=".")

# subset for the two first days of february
dsample <- pcons[pcons$Date %in% c("2/2/2007", "1/2/2007"), ]

# add Datetime as POSIXct column to the dataframe
dsample <- mutate(dsample, Date = as.character(Date), Time=as.character(Time))
dsample <- mutate(dsample, Datetime=paste0(Date, sep="T", Time))
dsample <- mutate(dsample, DatetimeDT=as.POSIXct(Datetime, format="%d/%m/%YT%H:%M:%S"))

plot(dsample$DatetimeDT, 
     dsample$Global_active_power,
     type="l",
     ylab="Global Active Power (kilowatts)",
     xlab="")

dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()