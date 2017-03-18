# This file:
# 1. Downloads https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip to `./download/dataset.zip` and unzips it.
# 2. Ingests the unzipped, raw data, including only data from 2007-02-01 and 2007-02-02 to keep the filesize down. 
#    Data size: 20MBcompressed, 127MB uncompressed, ~2million rows x 9 cols. Would require ~254MB in memory.
# 3. Tidys the data.

library("downloader")   ## For downloading and extracting the zip file.

# Define the paths used by the application.
dirs <- list(download = file.path(".", "download"))
downloadZipFile <- file.path(dirs$download, "datasets.zip")
rawDataFile <- file.path(dirs$download, "household_power_consumption.txt")

# Download and unzip...
if (!file.exists(rawDataFile)) {
        dir.create(dirs$download, recursive = TRUE)
        download("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                 dest=downloadZipFile,
                 mode="wb"
        )
        unzip(downloadZipFile, exdir=dirs$download)
}
