source("ingestData.R")

png("plot3.png",
        width = 480,
        height = 480)

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
})

legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1,1),
       col = c("black", "red", "blue")
       )

dev.off()