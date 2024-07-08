set.seed(1)
library(ggplot2)
library(dplyr)
library(ManifoldDestiny)
library(htmltools)
source(paste0(rprojroot::find_rstudio_root_file(),"/R/wasmconverting.R"))
source(paste0(rprojroot::find_rstudio_root_file(),"/R/wasmnonverting.R"))
#######################################################################################################################################################
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
########## Rigged example 1: standard form
frms <- 1
plnrvec <- c(1,2,3)[1]
rotv <- list(list(fr=c(1,10),sr=c(4,0),tr=c(2,0)),list(fr=c(1,14.378100),sr=c(4,49.762610),tr=c(2,11.5781)))[[1]]
app_ex1_cou <- Countinggraphs(app_bal[[1]])
pri_int_ex1 <- app_ex1_cou$polyc[[1]][[1]]
app_ex1_cou$mansys(sygen=list(frm=frms,
			      pre=c("alpha","x","y"),
			      end=c("zeta","Omega","lamda"),
			      stuv=c("S","T","U","V"),
			      plnr=plnrvec,
			      rot=rotv,
			      lf="(alpha-alpha_s)^2"))
#s1o <- app_ex1_cou$setres(0.19,1)
#app_ex1_cou$enf[[3]]
#app_ex1_cou$manimp(init_par=c(k0=0,k1=0.60,k2=0.40),wn=c(0,0),man=F)
#pos_int_ex1 <- app_ex1_cou$polyc[[1]][[1]]
#assign("app0nr",app_ex1_cou$loss_df)
#usethis::use_data(app0nr,overwrite = TRUE)
#app_ex1_out <- seloutput(selreport(app_ex1_cou$rdfc,md$app0))
#app_ex1_sim <- SimVoterdatabase(app_ex1_cou$rdfc)
######### Rigged example 2: hybrid form
app_ex2_cou <- Countinggraphs(app_bal[[1]])
pri_int_ex2 <- app_ex2_cou$polyc[[2]][[1]]
#app_ex2_cou$mansys(sygen=list(frm=2,
#			      pre=c("alpha","h","g"),
#			      end=c("Gamma","Omega","lamda"),
#			      stuv=c("T","U","S","V"),
#			      me=c(plnr=1,rot=0),
#			      lf="(alpha-alpha_h)^2"))
#s2o <- app_ex2_cou$setres(0.19,1)
#pos_int_ex2 <- app_ex2_cou$polyc[[2]][[1]]
#app_ex2_o <- Countinggraphs(app_ex2_cou$rdfc)
#app_ex2_cou$manimp(init_par=c(k0=0,k1=0.50,k2=0.50),wn=c(0,0),man=TRUE)
#assign("app0hr",app_ex2_cou$loss_df)
#usethis::use_data(app0hr,overwrite = TRUE)
#app_ex2_sim <- SimVoterdatabase(app_ex2_cou$rdfc)
####### Rigged example 3: Hybrid form
app_ex3_cou <- Countinggraphs(app_bal[[1]])
pri_int_ex3 <- app_ex3_cou$polyc[[1]][[1]]
#app_ex3_cou$mansys(sygen=list(frm=1,
#			      pre=c("alpha","x","y"),
#			      end=c("zeta","lamda","Omega"),
#			      stuv=c("S","T","U","V"),
#			      me=c(plnr=1,rot=0),
#			      lf="(alpha-alpha_s)^2"))
#s3o <- app_ex2_cou$setres(0.19,1)
#app_ex3_cou$setres(0.19,1)
#pos_int_ex3 <- app_ex3_cou$polyc[[1]][[1]]
#app_ex3_cou$manimp(init_par=c(k0=0.0,k1=0.50,k2=0.50),wn=c(0,0),man=TRUE)
#assign("app0or",app_ex3_cou$loss_df)
#usethis::use_data(app0or,overwrite = TRUE)
#app_ex3_out <- seloutput(selreport(app_ex3_cou$rdfc,md$app0))
## app_ex3_out[[5]]
#app_ex3_sim <- SimVoterdatabase(app_ex3_cou$rdfc)
#####################################################################################################################################################################
##### Standard
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
