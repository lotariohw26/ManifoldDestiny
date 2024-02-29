# R/wasmconverting.R
source("R/wasmconverting.R")
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
#app0 <- ballcastsim(dfm,probw,probva,probvb,ztech)
#usethis::use_data(app0, overwrite=TRUE)
#app0_rp <- selreport(app0,md$app0)
#app_0_out <- seloutput(app0_rp)


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
########## Rigged example 1: standard form
app_ex1_cou <- Countinggraphs(app_bal)
pri_int_ex1 <- app_ex1_cou$polyc[[1]][[1]]
app_ex1_cou$mansys(sygen=list(frm=1,
			      pre=c("alpha","x","y"),
			      end=c("zeta","Omega","lamda"),
			      stuv=c("S","T","U","V"),
			      me=c(plnr=1,rot=c(1,4,2)),
			      lf="(alpha-alpha_s)^2"))
s1o <- app_ex1_cou$setres(0.19,1)
app_ex1_cou$enf[[3]]
app_ex1_cou$manimp(init_par=c(k0=0,k1=0.60,k2=0.40),wn=c(0,0),man=F)
pos_int_ex1 <- app_ex1_cou$polyc[[1]][[1]]
assign("app0nr",app_ex1_cou$loss_df)
usethis::use_data(app0nr,overwrite = TRUE)
app_ex1_out <- seloutput(selreport(app_ex1_cou$rdfc,md$app0))
app_ex1_sim <- SimVoterdatabase(app_ex1_cou$rdfc)


# Shiny
## shinyapps/manimp/app.R
## shinyapps/empapp/app.R
# Create a vector of file names
file_names <- paste0("data/", c("app0.rda", "app1.rda", "app2.rda", "app3.rda", "app4.rda"))
loaded_data <- lapply(file_names, function(file_name) { load(file_name) })

