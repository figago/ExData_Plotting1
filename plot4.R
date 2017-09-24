library(dplyr)

# storing par parameters as we're going to modify them
# useful to restore at the end
.pardefault <- par()


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
         lty=1, cex=0.3)
  
}

# read the dataframe
pcons <- read.csv(file="household_power_consumption.txt",
                  header=TRUE, sep=";", dec=".")

# subset for the two first days of february
dsample <- pcons[pcons$Date %in% c("2/2/2007", "1/2/2007"), ]

# change the data types of numeric columns
dsample$Global_active_power <- as.numeric(levels(dsample$Global_active_power))[dsample$Global_active_power]
dsample$Global_reactive_power <- as.numeric(levels(dsample$Global_reactive_power))[dsample$Global_reactive_power]
dsample$Voltage <- as.numeric(levels(dsample$Voltage))[dsample$Voltage]

# add Datetime as POSIXct column to the dataframe
dsample <- mutate(dsample, Date = as.character(Date), Time=as.character(Time))
dsample <- mutate(dsample, Datetime=paste0(Date, sep="T", Time))
dsample <- mutate(dsample, DatetimeDT=as.POSIXct(Datetime, format="%d/%m/%YT%H:%M:%S"))


# configure the plot with two lines and two columns
par(mfrow=c(2,2))

# Plot the four plots
plot(dsample$DatetimeDT, 
     dsample$Global_active_power,
     type="l",
     ylab="Global Active Power (kilowatts)",
     xlab="")
plot(dsample$DatetimeDT, 
     dsample$Voltage,
     type="l",
     ylab="Voltage",
     xlab="datetime")
plotSubmetering(dsample)
plot(dsample$DatetimeDT, 
     dsample$Global_reactive_power,
     type="l",
     ylab="Global Reactive Power",
     xlab="datetime")

# output to png
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()

# restore initial graphics parameters
par(.pardefault)
