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
basc <- list(df=ballcastsim(perv,prow,proa,prob,ztec),NULL)

# Rigged election
cogr <- Countinggraphs(basc[[1]])
copl <- cogr$polyc[[1]][[1]]
plfc <- c(0.20,0.20,0.20)
ex1s <- list(frm=1, pre=c("alpha","x","y"), end=c("zeta","Omega","lamda"),
	     stuv=c("S","T","U","V"),
	     plnr=1,rot=list(fr=c(1,10),sr=c(4,0),tr=c(2,0)),
	     ls="(alpha-alpha_s)^2"
)
ex2s <- list(frm=1, pre=c("alpha","x","y"), end=c("zeta","Omega","lamda"),
	     stuv=c("S","T","U","V"),
	     plnr=1,rot=list(fr=c(1,10),sr=c(4,0),tr=c(2,0)),
	     ls="(alpha-alpha_s)^2"
)
ex3s <- list(frm=1, pre=c("alpha","x","y"), end=c("zeta","Omega","lamda"),
	     stuv=c("S","T","U","V"),
	     plnr=1,rot=list(fr=c(1,10),sr=c(4,0),tr=c(2,0)),
	     ls="(alpha-alpha_s)^2"
)
exs <- list(ex1s,ex2s,ex3s)
rigv <- lapply(1:3, function(x) { 
  cogr$mansys(sygen=exs[[x]])
  cogr$polyc[[x]]
  cogr$setres(NULL,1)
  cogr$setres(plfc[x],1)
  cogr$manimp(init_par=c(k0=0,k1=0.60,k2=0.40),wn=c(0,0),man=T)
  exs[[1]]$frm
  rasc <- list(cogr$rdfc,list(fr=1,eq="alpha=k0+k1*x+k2*y",va='y',prg=list(cnd=1)))
})
###################################################################################################################################################################
#usethis::use_data(basc, overwrite = TRUE)
#usethis::use_data(rigv, overwrite = TRUE)
appnf <- seloutput(rppnf <- selreport(basc))
appr1 <- seloutput(rppr1 <- selreport(rigv[[1]]))
appr2 <- seloutput(rppr2 <- selreport(rigv[[2]]))
appr3 <- seloutput(rppr3 <- selreport(rigv[[3]]))
#penf <- polynom::polynomial(unname(rppnf[[1]]$polyc[[1]][[1]],3))
#per1 <- polynom::polynomial(unname(rppr1[[1]]$polyc[[1]][[1]],3))
#per2 <- polynom::polynomial(unname(rppr2[[1]]$polyc[[1]][[1]],3))
#per3 <- polynom::polynomial(unname(rppr3[[1]]$polyc[[1]][[1]],3))
####################################################################################################################################################################

