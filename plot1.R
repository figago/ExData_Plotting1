#' Date: Date in format dd/mm/yyyy
#' Time: time in format hh:mm:ss
#' Global_active_power: household global minute-averaged active power (in kilowatt)
#' Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
#' Voltage: minute-averaged voltage (in volt)
#' Global_intensity: household global minute-averaged current intensity (in ampere)
#' Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
#' Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
#' Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.


# read the dataframe
pcons <- read.csv(file="household_power_consumption.txt",
                  header=TRUE, sep=";", dec=".")

# subset for the two first days of february
dsample <- pcons[pcons$Date %in% c("2/2/2007", "1/2/2007"), ]

# change the data types of numeric columns
dsample$Global_active_power <- as.numeric(levels(dsample$Global_active_power))[dsample$Global_active_power]

hist(dsample$Global_active_power,
     col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")

dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()