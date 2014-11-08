fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
## make sure directory /data already exist
if(!file.exists("data")){
        dir.create("data")
}
## add method="curl" if use linux/mac
download.file(fileUrl, destfile="./data/cameras.csv")
downloadedDate <- date()

## read data from local
## header means our first row contains columns name
## set quote ="" should avoid error from strings that contain quote
cameraData <- read.table("./data/cameras.csv", sep = ",", header = TRUE)
