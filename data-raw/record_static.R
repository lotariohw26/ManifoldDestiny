# libraries
ManifoldDestiny::wasmconload()
library(usethis)
source(paste0(rprojroot::find_rstudio_root_file(),"/R/wasmconverting.R"))
source(paste0(rprojroot::find_rstudio_root_file(),"/R/wasmnonverting.R"))
qenvae <- yaml::yaml.load_file(paste0(rprojroot::find_rstudio_root_file(),"/_apps_rel.yml"))
qenvas <- yaml::yaml.load_file(paste0(rprojroot::find_rstudio_root_file(),"/_apps_sim.yml"))
googlesheets4::gs4_auth(email="lotariohw26@gmail.com")
#######################################################################################################################################################
# Applications
recoudatr(qenvae$apn5an)
recoudatr(qenvae$apn5bn)
recoudatr(qenvae$apn1n)
recoudatr(qenvae$apn2n)
recoudatr(qenvae$apn3r)
recoudatr(qenvae$apn4n)
ManifoldDestiny::bm()
######################################################################################################################################################
# Simulation
## Normal 
perv <- (function(x){data.frame(P=seq(1,x),RV=as.integer(rnorm(x,100,30)))})(100)
prow <- c(m=0.51,s=0.10)
proa <- c(vdm=0.7,mdm=0.4,vds=0.10,mds=0.10)
prob <- c(vdm=0.5,mdm=0.6,vds=0.10,mds=0.10)
ztec <- c(0,1)	
gsh <- ballcastsim(perv,prow,proa,prob,ztec)
mda <- qenvas$apsnn
assign(mda$nid,list(gsh,mda))
do.call("use_data", list(as.name(mda$nid), overwrite = TRUE))
## Rigged election
set.seed(1)
cogr <- Countinggraphs(gsh)
copl <- cogr$polyc[[1]][[1]]
plfc <- c(0.21,0.21,0.21,0.21)
exn <- c("aprnn","aprhn","apron","aprnr")[1:3]
rigv <- lapply(1:4, function(x) { 
  mda <- qenvas[[exn[x]]]
  exs <- list(
	    frm=as.numeric(mda$sol$fr),
  	    pre=mda$sol$pr,
  	    end=mda$sol$de,
  	    eq=mda$sol$eq[1],
  	    va=mda$sol$va,
            rot=mda$sol$ro
  	  )
  cogr$mansys(sygen=exs)
  cogr$polyc[[1]]
  cogr$setres(NULL,1)
  cogr$setres(plfc[x],1)
  cogr$manimp(init_par=c(k0=0,k1=0.60,k2=0.40),wn=c(0,0),man=T)
  assign(mda$nid,list(cogr$rdfc,mda))
  do.call("use_data", list(as.name(mda$nid), overwrite = T))
})
####################################################################################################################################################
sum(unique(tdf[c('a1','a2','a3', 'b1','b2','b3', 'c1','c2','c3')]))
sum(unique(select(tdf,starts_with("d_"))))
