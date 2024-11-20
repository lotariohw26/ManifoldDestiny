##########################################################################################################
library(ManifoldDestiny)
library(ggplot2)
library(dplyr)
source(paste0(rprojroot::find_rstudio_root_file(),"/R/wasmconverting.R"))
source(paste0(rprojroot::find_rstudio_root_file(),"/R/wasmnonverting.R"))
source(paste0(rprojroot::find_rstudio_root_file(),"/R/abc.R"))
##########################################################################################################
aps <- pma24
#aps <- sma24
co <- Countinggraphs(aps[[1]],selvar=c('PN','P','R','S','T','U','V'))
co$purging()
t2framerel <- co$rdfc %>% dplyr::mutate(Psi_s=S/R,Psi_t=T/R) |> dplyr::select(PN,P,R,S,T,U,V,alpha,Psi_s,Psi_t,lamda)
# A
# I
#nI <- dim(t1framecom)[1]
#complexlm::lm(z ~ x + y, data = t1framecom, weights = rep(1,nI))
## II
#nII <- dim(t2framecom)[1]
#names(t2framecom)
#complexlm::lm(zi ~ x0y1 + x1y0 , data = t2framecom, weights = rep(1,nII))
#olsce(comdat(dr=t2framerel,pl=1,zv=c('alpha','NULL'),xv=c('lamda','Psi_s'),yv=c('lamda','Psi_t')))
#

##########################################################################################################
##########################################################################################################
##########################################################################################################
# I
set.seed(4242)
n <- 8
slop <- complex(real = 4.23, imaginary = 2.323)
interc <- complex(real = 1.4, imaginary = 1.804)
e <- complex(real=rnorm(n)/6, imaginary=rnorm(n)/6)
xx <- complex(real= rnorm(n), imaginary= rnorm(n))
yy <- complex(real= rnorm(n), imaginary= rnorm(n))
t1framecom <- data.frame(x= xx,y=yy, z= slop*xx + slop*yy + interc + e)
#t1framerel <- tframecom %>% dplyr::mutate(P=row_number(),z=as.complex(z),x=as.complex(x),y =as.complex(y),z1=Re(z),z2= Im(z),x1=Re(x),x2=Im(x),y1=Re(y),y2=Im(y)) %>% select(P,z1,z2,y1,y2,x1,x2)
# II
baldata <- apn3n
WS <- Sys.info()[['sysname']]=="Emscripten"
da <- baldata[[1]]
md <- baldata[[2]]
co <- Countinggraphs(da,selvar=c('PN','P','R','S','T','U','V'))
co$purging(z=md$prg$z,stuv=md$prg$stuv,blup=md$prg$blup,eqp=md$prg$eqp,prma=md$prg$prma)
t2framerel <- co$rdfc %>% dplyr::mutate(Psi_s=S/R,Psi_t=T/R) |> dplyr::select(PN,P,R,S,T,U,V,alpha,Psi_s,Psi_t,lamda)
t2framecom <- t2framerel %>% dplyr::mutate(P=row_number()) %>% comdat(pl=3,zv=c('alpha','NULL'),xv=c('lamda','Psi_s'),yv=c('lamda','Psi_t'))
##########################################################################################################
# A
# I
nI <- dim(t1framecom)[1]
complexlm::lm(z ~ x + y, data = t1framecom, weights = rep(1,nI))
# II
nII <- dim(t2framecom)[1]
names(t2framecom)
complexlm::lm(zi ~ x0y1 + x1y0 , data = t2framecom, weights = rep(1,nII))
olsce(comdat(dr=t2framerel,pl=1,zv=c('alpha','NULL'),xv=c('lamda','Psi_s'),yv=c('lamda','Psi_t')))
##########################################################################################################
complexlm::lm(zi ~ x0y1 + x1y0 , data = t2framecom, weights = rep(1,nII))
olsce(comdat(dr=t2framerel,pl=1,zv=c('alpha','NULL'),xv=c('lamda','Psi_s'),yv=c('lamda','Psi_t')))
complexlm::lm(zi ~ x0y1 + x1y0 + x0y2 + x1y1 +x2y0, data = t2framecom, weights = rep(1,nII))
olsce(comdat(dr=t2framerel,pl=2,zv=c('alpha','NULL'),xv=c('lamda','Psi_s'),yv=c('lamda','Psi_t')))
complexlm::lm(zi ~ x0y1 + x1y0 + x0y2 + x1y1 +x2y0 + x0y3 + x1y2 + x2y1 + x3y0, data = t2framecom, weights = rep(1,nII))
olsce(comdat(dr=t2framerel,pl=3,zv=c('alpha','NULL'),xv=c('lamda','Psi_s'),yv=c('lamda','Psi_t')))
##########################################################################################################

