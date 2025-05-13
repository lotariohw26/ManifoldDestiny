library(data.table)
init <- "colorado/REDACTED_CVR_Export_20201130085221_354247.csv"
late <- "colorado/REDACTED_CVR_Export_20201130085221.csv"
colo <- fread(init)
coln <- fread(late)
usethis::use_data(colo, overwrite = TRUE)
usethis::use_data(coln, overwrite = TRUE)


2+2
