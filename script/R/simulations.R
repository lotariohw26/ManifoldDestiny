library(ggplot2)
library(dplyr)
library(ManifoldDestiny)
library(htmltools)
##########################################################################################################################################################
set.seed(1)
source(paste0(rprojroot::find_rstudio_root_file(),"/R/wasmconverting.R"))
source(paste0(rprojroot::find_rstudio_root_file(),"/R/wasmnonverting.R"))
##########################################################################################################################################################
###### Normal 
# Simulation
perv <- (function(x){data.frame(P=seq(1,x),RV=as.integer(rnorm(x,100,30)))})(100)
prow <- c(m=0.51,s=0.10)
proa <- c(vdm=0.7,mdm=0.4,vds=0.10,mds=0.10)
prob <- c(vdm=0.5,mdm=0.6,vds=0.10,mds=0.10)
ztec <- c(0,1)	
basc <- list(df=ballcastsim(perv,prow,proa,prob,ztec),list(fr=1,eq="alpha=k0+k1*x+k2*y"))
# Rigged election
cogr <- Countinggraphs(basc[[1]])
copl <- cogr$polyc[[1]][[1]]
frms <- c(1,1,1)
plnr <- c(1,2,3)
exs <- c("ex1", "ex2", "ex3")
pnvec <- c(1,2,3)[1]
#rigv <- lapply(exs, function(x) { 
cogr$mansys(sygen=list(frm=1, 
		pre=c("alpha","x","y"),
		end=c("zeta","Omega","lamda"),
		stuv=c("S","T","U","V"),
		plnr=c(plnr=1),
		lf="(alpha-alpha_s)^2"))
cogr$setres(0.19,1)
cogr$manimp(init_par=c(k0=0,k1=0.60,k2=0.40),wn=c(0,0),man=T)
#rasc <- basc
#return(rasc)
#})
#cogr$manimp(init_par=c(k0=0,k1=0.60,k2=0.40),wn=c(0,0),man=T)
#ismv <- SimVoterdatabase(basc[[1]])
#crpl <- SimVoterdatabase(rigc[[1]])
####################################################################################################################################################################
######### Concluding Tabl
#ctone <-'Applications'
#formved <- c('Opposition', 
#	     'Opposition', 
#	     'Normal', 
#	     'Opposition')
#casevec <- c('Miller vs. Stavros, 2020',
#'Gilbert vs. Sisiolak vs. Lombardo 2020',
#'Lake vs. Hobbs, 2022',
#'Trump vs. Biden, 2020')
#propv_vec <- c("1rd & 2th","1rd & 2th","1rd & 2th","1rd & 2th")
#prope_vec <- c("5th & 6th","5th & 6th","3rd & 4th","5th & 6th")
#cou_abc <- c("Case","Form of rigg","Properties","Violations")
#concl_appps <- data.frame(case=casevec,
#			  rig=formved,
#			  propn=prope_vec, 
#			  propv=propv_vec)
#################################################################################################################################################################
# "id"   "nid"  "nmn"  "rcn"  "cnd"  "sta"  "cou"  "mod"  "yea"  "url"  "pgn"  "rng"  "cln"  "stuv" "eq"  "va"   "fr"   "ro"   "bib" 
# "fr" "eq"
#rotv <- list(list(fr=c(1,10),sr=c(4,0),tr=c(2,0)),list(fr=c(1,14.378100),sr=c(4,49.762610),tr=c(2,11.5781)))[[1]]
