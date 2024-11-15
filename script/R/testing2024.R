library(ggplot2)
library(complexlm)
library(dplyr)
library(ManifoldDestiny)
ManifoldDestiny::wasmconload()
source(paste0(rprojroot::find_rstudio_root_file(),"/R/wasmconverting.R"))
source(paste0(rprojroot::find_rstudio_root_file(),"/R/wasmnonverting.R"))
source(paste0(rprojroot::find_rstudio_root_file(),"/R/abc.R"))
ls(package:ManifoldDestiny)
aps <- apn1n

co <- Countinggraphs(aps,selvar=c('P','R','S','T','U','V'))

View(pma24[[1]])
