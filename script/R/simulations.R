set.seed(1)
library(ggplot2)
library(dplyr)
library(ManifoldDestiny)
library(htmltools)
source(paste0(rprojroot::find_rstudio_root_file(),"/R/wasmconverting.R"))
source(paste0(rprojroot::find_rstudio_root_file(),"/R/wasmnonverting.R"))
##########################################################################################################################################################
###### Normal 
######## R2 sim
set.seed(1)
dfm <- (function(x){data.frame(P=seq(1,x),RV=as.integer(rnorm(x,100,30)))})(100)
probw <- c(m=0.51,s=0.10)
probva <- c(vdm=0.7,mdm=0.4,vds=0.10,mds=0.10)
probvb <- c(vdm=0.5,mdm=0.6,vds=0.10,mds=0.10)
ztech <- c(0,1)	
mdn <- list(frn=1,eq="alpha=k0+k1*x+k2*y")
app_bal <- list(df=ballcastsim(dfm,probw,probva,probvb,ztech),app0=mdn)
########### Normal form
app_n_rep <- selreport(app_bal)
app_n_out <- seloutput(app_n_rep)
app_n_sim <- SimVoterdatabase(app_bal[[1]])
########## Rigged 
frms <- 1
plnrvec <- c(1,2,3)[1]
rotv <- list(list(fr=c(1,10),sr=c(4,0),tr=c(2,0)),list(fr=c(1,14.378100),sr=c(4,49.762610),tr=c(2,11.5781)))[[1]]
exs <- c("ex1", "ex2", "ex3")
rigres <- lapply(exs, function(x) { 
  appn <- Countinggraphs(app_bal[[1]])
  intn <- appn$polyc[[1]][[1]]
  appn$mansys(sygen=list(frm=frms, 
  		pre=c("alpha","x","y"),
  		end=c("zeta","Omega","lamda"),
  		stuv=c("S","T","U","V"),
  		plnr=plnrvec,
  		rot=rotv,
  		lf="(alpha-alpha_s)^2"))
  appn$setres(0.19,1)
  appn$manimp(init_par=c(k0=0,k1=0.60,k2=0.40),wn=c(0,0),man=T)
  dfme <- list(appn$loss_df,NULL)
  #abc <- seloutput(selreport(dfme))
  def <- SimVoterdatabase(dfme[[1]])
  return(list(def,def))
})
rigres[[1]]
###################################################################################################################################################################
######## Concluding Tabl
ctone <-'Applications'
formved <- c('Opposition', 
	     'Opposition', 
	     'Normal', 
	     'Opposition')
casevec <- c('Miller vs. Stavros, 2020',
'Gilbert vs. Sisiolak vs. Lombardo 2020',
'Lake vs. Hobbs, 2022',
'Trump vs. Biden, 2020')
propv_vec <- c("1rd & 2th","1rd & 2th","1rd & 2th","1rd & 2th")
prope_vec <- c("5th & 6th","5th & 6th","3rd & 4th","5th & 6th")
cou_abc <- c("Case","Form of rigg","Properties","Violations")
concl_appps <- data.frame(case=casevec,
			  rig=formved,
			  propn=prope_vec, 
			  propv=propv_vec)
################################################################################################################################################################
