fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
## make sure directory /data already exist
if(!file.exists("data")){
        dir.create("data")
}
## add method="curl" if use linux/mac
download.file(fileUrl, destfile="./data/cameras.xlsx")
downloadedDate <- date()

## need to use library to read xlsx file
## don't forget to install package first for the first time use install.packages("xlsx")
library(xlsx)
