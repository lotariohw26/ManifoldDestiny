# R/wasmconverting.R
ManifoldDestiny::wasmconload()
source("R/wasmconverting.R")
library(ggplot2)
library(dplyr)
# Abc
dfm <- (function(x){data.frame(P=seq(1,x),RV=as.integer(rnorm(x,100,30)))})(100)
probw <- c(m=0.51,s=0.10)
probva <- c(vdm=0.7,mdm=0.4,vds=0.10,mds=0.10)
probvb <- c(vdm=0.5,mdm=0.6,vds=0.10,mds=0.10)
ztech <- c(0,1)	
app_bal <- ballcastsim(dfm,probw,probva,probvb,ztech)
########### Normal form
app_n_rep <- selreport(app_bal,md$app0)
app_n_out <- seloutput(app_n_rep)
app_n_sim <- SimVoterdatabase(app_bal)
########## Rigged example 1: standard form without rotation
frms <- 1
plnrvec <- c(1,2,3)[1]
rotv <- list(NULL,list(fr=c(1,14.378100),sr=c(4,49.762610),tr=c(2,11.5781)))[[2]]
app_ex1_cou <- Countinggraphs(app_bal)
pri_int_ex1 <- app_ex1_cou$polyc[[1]][[1]]
app_ex1_cou$mansys(sygen=list(frm=frms,
			      pre=c("alpha","x","y"),
			      end=c("zeta","Omega","lamda"),
			      stuv=c("S","T","U","V"),
			      plnr=plnrvec,
			      rot=rotv,
			      lf="(alpha-alpha_s)^2"))
s1o <- app_ex1_cou$setres(0.19,1)
app_ex1_cou$manimp(init_par=c(k0=0,k1=0.60,k2=0.40),wn=c(0,0),man=F)
pos_int_ex1 <- app_ex1_cou$polyc[[1]][[1]]
assign("app0nr",app_ex1_cou$loss_df)
usethis::use_data(app0nr,overwrite = TRUE)


