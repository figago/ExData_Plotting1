library(dplyr)

# function plotting the three submeterings
plotSubmetering <- function (dsample) {
  plot(dsample$DatetimeDT, dsample$Sub_metering_1,
       type="l", col="black",
       ylab="Energy submetering",
       xlab="")
  lines(dsample$DatetimeDT, dsample$Sub_metering_2, col="red")
  lines(dsample$DatetimeDT, dsample$Sub_metering_3, col="blue")
  
  legend("topright",
         col = c("black", "red", "blue"), 
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         lty=1)
}

# read the dataframe
pcons <- read.csv(file="household_power_consumption.txt",
                  header=TRUE, sep=";", dec=".")

# subset for the two first days of february
dsample <- pcons[pcons$Date %in% c("2/2/2007", "1/2/2007"), ]

# add Datetime as POSIXct column to the dataframe
dsample <- mutate(dsample, Date = as.character(Date), Time=as.character(Time))
dsample <- mutate(dsample, Datetime=paste0(Date, sep="T", Time))
dsample <- mutate(dsample, DatetimeDT=as.POSIXct(Datetime, format="%d/%m/%YT%H:%M:%S"))

plotSubmetering(dsample)

dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()