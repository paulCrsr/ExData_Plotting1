# This file:
# 1. Downloads https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip to `./download/dataset.zip` and unzips it.
# 2. Reads the unzipped, raw data. 
#    Data size: 20MBcompressed, 127MB uncompressed, ~2million rows x 9 cols. Would require ~254MB in memory.
# 3. Tidys the data keeping only data from 2007-02-01 and 2007-02-02 and stores the output in a variable `household`.

library("downloader")   # For downloading and extracting the zip file.
library("lubridate")    # For convenient date handling.

# Define the paths used by the application.
dirs <- list(download = file.path(".", "download"))
downloadZipFile <- file.path(dirs$download, "datasets.zip")
rawDataFile <- file.path(dirs$download, "household_power_consumption.txt")

# Download and unzip...
if (!file.exists(rawDataFile)) {
        message("Downloading zip file...")
        dir.create(dirs$download, recursive = TRUE)
        download("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                 dest=downloadZipFile,
                 mode="wb"
        )
        unzip(downloadZipFile, exdir=dirs$download)
        message("... download complete!")
}

################## Ingest ##################

# $ head household_power_consumption.txt
#
# Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;Sub_metering_1;Sub_metering_2;Sub_metering_3
# 16/12/2006;17:24:00;4.216;0.418;234.840;18.400;0.000;1.000;17.000
# 16/12/2006;17:25:00;5.360;0.436;233.630;23.000;0.000;1.000;16.000
# 16/12/2006;17:26:00;5.374;0.498;233.290;23.000;0.000;2.000;17.000
# 16/12/2006;17:27:00;5.388;0.502;233.740;23.000;0.000;1.000;17.000
# 16/12/2006;17:28:00;3.666;0.528;235.680;15.800;0.000;1.000;17.000
# ...

# Create custom types for reading the dates and times with Lubridate.
setClass('mydate')
setAs("character","mydate", function(from) dmy(from) )
setClass('mytime')
setAs("character","mytime", function(from) hms(from) )

ingest <- function() {
        message("Reading ", rawDataFile, "...")
        alldata <-
                read.table(rawDataFile,
                           header = TRUE,
                           sep = ";",
                           na.strings = c("?"),
                           colClasses = c("mydate", "mytime", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"),
                           blank.lines.skip = TRUE,
                           nrows = 2100000
                )
        message("... ", " filtering by date...")
        filtered <- with(alldata, subset(alldata, Date == ymd("2007/02/01") | Date == ymd("2007/02/02")))
        message("...", " complete!")
        filtered
} 
         
if (exists("household")) {
        message("Variable `household` already exists so ingestion will not be performed.")       
} else {
        household <- ingest()
}

message("Done! Variable `household` exists with: ", ncol(household), " cols, ", nrow(household), " rows")
