library(ggplot2)
library(complexlm)
library(dplyr)
ManifoldDestiny::wasmconload()
library(ManifoldDestiny)
source(paste0(rprojroot::find_rstudio_root_file(),"/R/wasmconverting.R"))
source(paste0(rprojroot::find_rstudio_root_file(),"/R/wasmnonverting.R"))
source(paste0(rprojroot::find_rstudio_root_file(),"/R/abc.R"))
ls(package:ManifoldDestiny)
#aps <- apn0r
#aps <- apn1n
##aps <- apn2n
aps <- apn3n
#aps <- apn4n
adat <- aps[[1]]
amet <- aps[[2]]
##########################################################################################################
#slr <- selreport(aps)
#slo <- seloutput(slr)
##########################################################################################################
