library(ggplot2)
library(complexlm)
library(dplyr)
library(ManifoldDestiny)
ManifoldDestiny::wasmconload()
source(paste0(rprojroot::find_rstudio_root_file(),"/R/wasmconverting.R"))
source(paste0(rprojroot::find_rstudio_root_file(),"/R/wasmnonverting.R"))
source(paste0(rprojroot::find_rstudio_root_file(),"/R/abc.R"))
ls(package:ManifoldDestiny)
aps <-pma24
#aps <-sma24
adatd <- aps[[1]]
ametd <- aps[[2]]
adat <- dplyr::filter(adatd,SNAP==1)
unique(dplyr::select(adatd,1,2))
############################################################################################################
#slr <- selreport(aps)
#slo <- seloutput(slr)
# 0.3854475+0.5169042 
# 0.3854475*0.1355111+0.5169042*(1-0.1355111)
###########################################################################################################
frm <- "S"
co <-  cob <- Countinggraphs(adat,omit=T)
sum(dplyr::select(co$rdfci,R))
co$purging()
co$descriptive(frm)
co$desms
# Step 1: Open a PNG device
plot(co$rdfci$x,co$rdfci$y,ylim=c(0, 1))


co$sortpre(frm)
co$plot2d(selv=c(1:3,6))
co$pl_corrxy 
co$r2siminput(frm)
co$plotxy(frm)
co$resplot(frm)
co$plotly3d(partition=frm)
co$plext(frm)
co$gridarrange()
co$all_pl_3d_mani[[1]]

ges <- Estimation(co$rofc,frm)
ges$regression(md$sol$eq[1])
ges$diagnostics()
ges$hat_predict(svf=md$sol$va)






