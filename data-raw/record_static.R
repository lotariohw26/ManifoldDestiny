# libraries
ManifoldDestiny::wasmconload()
library(usethis)
source(paste0(rprojroot::find_rstudio_root_file(),"/R/wasmconverting.R"))
source(paste0(rprojroot::find_rstudio_root_file(),"/R/wasmnonverting.R"))
qenvar <- yaml::yaml.load_file(paste0(rprojroot::find_rstudio_root_file(),"/_apps.yml"))
googlesheets4::gs4_auth(email="lotariohw26@gmail.com")
#######################################################################################################################################################
# Applications
recoudatr(qenvar$appn1)
recoudatr(qenvar$appn2)
recoudatr(qenvar$appn3)
recoudatr(qenvar$appn4)
#######################################################################################################################################################
# Simulation
## Normal 
perv <- (function(x){data.frame(P=seq(1,x),RV=as.integer(rnorm(x,100,30)))})(100)
prow <- c(m=0.51,s=0.10)
proa <- c(vdm=0.7,mdm=0.4,vds=0.10,mds=0.10)
prob <- c(vdm=0.5,mdm=0.6,vds=0.10,mds=0.10)
ztec <- c(0,1)	
gsh <- ballcastsim(perv,prow,proa,prob,ztec)
mda <- qenvar$appsn
assign(mda$nid,list(gsh,mda))
do.call("use_data", list(as.name(mda$nid), overwrite = TRUE))
## Rigged election
cogr <- Countinggraphs(gsh)
copl <- cogr$polyc[[1]][[1]]
plfc <- c(0.20,0.20,0.20)
exn <- c("apprn","apprh","appro")
rigv <- lapply(1:3, function(x) { 
  mda <- qenvar[[exn[x]]]
  exs <- list(frm=as.numeric(mda$sol$fr),
  	    pre=mda$sol$pr,
  	    end=mda$sol$de,
  	    eq=mda$sol$eq,
  	    va=mda$sol$va,
            rot=list(fr=c(1,0),sr=c(4,0),tr=c(2,0)))
  cogr$mansys(sygen=exs)
  cogr$polyc[[1]]
  cogr$setres(NULL,1)
  cogr$setres(0.20,1)
  cogr$manimp(init_par=c(k0=0,k1=0.60,k2=0.40),wn=c(0,0),man=T)
  assign(mda$nid,list(gsh,mda))
  do.call("use_data", list(as.name(mda$nid), overwrite = TRUE))
})
#######################################################################################################################################################
#apps <- ManifoldDestiny::appsn
#adat <- apps[[1]]
#amet <- apps[[2]]
#cogr <- Countinggraphs(apps[[1]])
#selo <- seloutput(selreport(apps))

