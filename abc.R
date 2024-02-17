ManifoldDestiny::wasmconload()
library(ManifoldDestiny)
library(ggplot2)
library(dplyr)

# Draw
md <- jsonlite::fromJSON(paste0(rprojroot::find_rstudio_root_file(),"/data-raw/metadata.json"))
dfm <- (function(x){data.frame(P=seq(1,x),RV=as.integer(rnorm(x,100,30)))})(100)
probw <- c(m=0.51,s=0.10)
probva <- c(vdm=0.7,mdm=0.4,vds=0.10,mds=0.10)
probvb <- c(vdm=0.5,mdm=0.6,vds=0.10,mds=0.10)
ztech <- c(0,1)	
app0 <- ballcastsim(dfm,probw,probva,probvb,ztech)
usethis::use_data(app0, overwrite=TRUE)
app0_rp <- selreport(app0,md$app0)
app_0_out <- seloutput(app0_rp)

# Shiny
## shinyapps/manimp/app.R
## shinyapps/empapp/app.R
# Create a vector of file names
file_names <- paste0("data/", c("app0.rda", "app1.rda", "app2.rda", "app3.rda", "app4.rda"))
loaded_data <- lapply(file_names, function(file_name) { load(file_name) })

# Use lapply to load all the RDA files
