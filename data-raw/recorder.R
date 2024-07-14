# libraries
library(ManifoldDestiny)
library(ggplot2)
library(dplyr)
library(googlesheets4)
library(htmltools)
library(gridExtra)
library(usethis)
library(yaml)
source(paste0(rprojroot::find_rstudio_root_file(),"/R/wasmconverting.R"))
source(paste0(rprojroot::find_rstudio_root_file(),"/R/wasmnonverting.R"))
qenvar <- yaml::yaml.load_file(paste0(rprojroot::find_rstudio_root_file(),"/_variables.yml"))
googlesheets4::gs4_auth(email="lotariohw26@gmail.com")
pma <- c("app0","app1","app2","app3","app4","app7")[5]
lapply(qenvar[pma], recoudatr)
bm()

