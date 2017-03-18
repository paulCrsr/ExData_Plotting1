source("ingestData.R")

png("plot4.png",
        width = 480,
        height = 480)

par(mfrow = c(2, 2))  # Setup 2 x 2, row-major, multi-frame

# Top-Left: Plot 2 again
with(household, 
     plot(DateTime, 
          Global_active_power,
          type = "l",
          col = "black",
          ylab = "Global Active Power",
          xlab = ""
     )
)

# Top-Right:
with(household, 
     plot(DateTime, 
          Voltage,
          type = "l",
          col = "black",
          ylab = "Voltage",
          xlab = "datetime"
     )
)

# Bottom-Left: Plot 3 again
with(household, {
        plot(DateTime, 
             Sub_metering_1,
             type = "l",
             col = "black",
             main = "",
             ylab = "Energy sub metering",
             xlab = ""             
             )
        points(householdDateTime(Date, Time), Sub_metering_2, type = "l", col = "red")
        points(householdDateTime(Date, Time), Sub_metering_3, type = "l", col = "blue")
        legend("topright", 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               lty = c(1,1),
               lwd = 3,
               col = c("black", "red", "blue"),
               bty = "n" # No border
        )
})

# Bottom-Right
with(household, 
     plot(DateTime, 
          Global_reactive_power,
          type = "l",
          col = "black",
          xlab = "datetime"
     )
)

dev.off()