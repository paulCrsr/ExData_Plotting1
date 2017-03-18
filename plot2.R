source("ingestData.R")

png("plot2.png",
        width = 480,
        height = 480)

with(household, 
        plot(DateTime, 
             Global_active_power,
             type = "l",
             col = "black",
             main = "",
             ylab = "Global Active Power (kilowatts)",
             xlab = ""             
             )
)

dev.off()