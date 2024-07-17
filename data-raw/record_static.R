# libraries
ManifoldDestiny::wasmconload()
library(usethis)
source(paste0(rprojroot::find_rstudio_root_file(),"/R/wasmconverting.R"))
source(paste0(rprojroot::find_rstudio_root_file(),"/R/wasmnonverting.R"))
qenvar <- yaml::yaml.load_file(paste0(rprojroot::find_rstudio_root_file(),"/_apps.yml"))
googlesheets4::gs4_auth(email="lotariohw26@gmail.com")
#######################################################################################################################################################
# Simulation
## Normal 
perv <- (function(x){data.frame(P=seq(1,x),RV=as.integer(rnorm(x,100,30)))})(100)
prow <- c(m=0.51,s=0.10)
proa <- c(vdm=0.7,mdm=0.4,vds=0.10,mds=0.10)
prob <- c(vdm=0.5,mdm=0.6,vds=0.10,mds=0.10)
ztec <- c(0,1)	
gsh <- ballcastsim(perv,prow,proa,prob,ztec)
mda <- qenvar$appsd
assign(mda$nid,list(gsh,mda))
do.call("use_data", list(as.name(mda$nid), overwrite = TRUE))

## Rigged election
cogr <- Countinggraphs(gsh)
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
exn <- c("apprn","apprh","appro")
rigv <- lapply(1:3, function(x) { 
  mda <- qenvar[[exn[x]]]
  cogr$mansys(sygen=exs[[x]])
  cogr$polyc[[x]]
  cogr$setres(NULL,1)
  cogr$setres(plfc[x],1)
  cogr$manimp(init_par=c(k0=0,k1=0.60,k2=0.40),wn=c(0,0),man=T)
  assign(mda$nid,list(gsh,mda))
  do.call("use_data", list(as.name(mda$nid), overwrite = TRUE))
})


gsh <- rigv[[1]][[1]]
mda <- qenvar$apprn
assign(mda$nid,list(gsh,mda))
do.call("use_data", list(as.name(mda$nid), overwrite = TRUE))
gsh <- rigv[[2]][[1]]
mda <- qenvar$apprh
assign(mda$nid,list(gsh,mda))
do.call("use_data", list(as.name(mda$nid), overwrite = TRUE))
gsh <- rigv[[3]][[1]]
mda <- qenvar$appro
assign(mda$nid,list(gsh,mda))
do.call("use_data", list(as.name(mda$nid), overwrite = TRUE))
#######################################################################################################################################################
# rigv 

#recoudatr(qenvar$app0)
recoudatr(qenvar$app1)
recoudatr(qenvar$app2)
recoudatr(qenvar$app3)
recoudatr(qenvar$app4)
bm()


