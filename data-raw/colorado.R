wget -P /colorado "https://files.shinethelight.info/index.php/s/38WonSeF7fnCKHL/download?path=%2FOriginal%20CVR%20provided%20by%20Arapahoe%20County&files=Redacted_CVR_Export.zip"
wget "https://files.shinethelight.info/index.php/s/38WonSeF7fnCKHL/download?path=%2FNew%20CVR%20provided%20by%20Arapahoe%20County&files=REDACTED_CVR_Export_20201130085221.zip"
libreoffice --headless --convert-to csv --outdir . colorado.xlsx

library(data.table)
init <- "colorado/REDACTED_CVR_Export_20201130085221_354247.csv"
late <- "colorado/REDACTED_CVR_Export_20201130085221.csv"
colo <- fread(init,nrows=4)
coln <- fread(late,nrows=4)
View(coln)
usethis::use_data(colo, nrows=4,overwrite = TRUE)
usethis::use_data(coln, nrows=100,overwrite = TRUE)

2+2

,|,|

coln[1:2,1:100]
