#################################################################################################33
library(ManifoldDestiny)
library(dplyr)
library(ggplot2)
library(tidyr)
library(purrr)
library(randNames)
library(openxlsx)
library(patchwork)
library(writexl)
library(plotly)
library(ViewPipeSteps)
library(ggpubr)
library(htmltools)
abs_path <- function(){rprojroot::find_rstudio_root_file()}
source(paste0(abs_path(),'/R/misc.R'))
source(paste0(abs_path(),'/R/class.R'))
snr <- 1
set.seed(snr)
##################################################################################################
#### I: Voterdatabase ###
### Inititating
agebracketmax <- c(18,100,1000)
regf <- 0.8
numprec <- 200
vrdf <- Voterdatabase(agebracketmax,numprec,regf,namebase='defvotbase',newdraw=F)
###### Realization of DGP
probwset <- c(0.50,0.00)
probvset <- list(c(0.70,0.30,0.00),c(0.30,0.70,0.00))
Znr <- c(0,0)
vrdf$realizedgp(probv=probvset,
		probw=probwset,
		Ztech=Znr)
votr <- vrdf$voterrollrealized
#################################################################################################33
##### A) Fair ###
gsimf <- Countinggraphs(votr,selvar=c('P','a','b','c','d','probwd'))
gsimf$sortpre(selvar=c('x','y','alpha','lambda','zeta','probwd'))
########### Tab1
gnt2a <- gsimf$plot2d(selvp=c("x","y","alpha","probwd"),selvl=c("x_pred","y_pred","alpha_pred"), 
  labs=list(x="precinct (normalized)",y="precentage",caption=gsimf$sumreg['alpha']))
gnt2b <- gsimf$plot2d(selvp=c("zeta"),selvl=c("zeta_m","zeta_pred"))
gnt2bab <- ggpubr::ggarrange(gnt2a,gnt2b, ncol=1)
#gnt2pab <- plotly::subplot(gnt2a,gnt2b,nrows=2)
########### Tab3
gsimf$quintile
gnt3a <- gsimf$resplot(resvar=c('zeta_mr','alpha_res'))
gnt3b <- gsimf$resplot(resvar=c('zeta_mr','y_res'))
gnt3c <- gsimf$resplot(resvar=c('zeta_mr','x_res'))
gnt3abcb <- ggpubr::ggarrange(gnt3a,gnt3b,gnt3c,nrow=3)
#gnt3abcp <- plotly::subplot(gnt3a,gnt3b,gnt3c,nrows=3)
########### Tab4
gnt4a <- gsimf$resplot(resvar=c('zeta_mr','alpha_res'),crossp=T)
gnt4b <- gsimf$resplot(resvar=c('zeta_mr','y_res'),crossp=T)
gnt4c <- gsimf$resplot(resvar=c('zeta_mr','x_res'),crossp=T)
gnt4babc <- ggpubr::ggarrange(gnt4a,gnt4b,gnt4c, nrow=4)
#gnt4pabc <- plotly::subplot(gnt4a,gnt4b,gnt4c,nrows=3)
########## Tab5
##gsimf$rdfc$zeta <- 1
gn3da <- gsimf$plotly3d(partition=1)[[1]]
gn3db <- gsimf$plotly3d(partition=1,selid=2)
#####################################################################################################
##### B) Rigged ###
grig <- Countinggraphs(votr)
grig$sortpre()
grig$manfolimp(pres1=grig$quintile$x, 
pres2=grig$quintile$alpha+0.02,  
pres3="(alpha*zeta + alpha - x)/zeta")
grig$riggsta()
d <- vrdf$uploadvbase(truevotdf=grig$sdfc,manipvotdf=grig$parampre)
View(d)
###### Graphical ###
########## Tab1
grt2a <- grig$plot2d(selvp=c("x","y","alpha"),selvl=c("x_pred","y_pred","alpha_pred"))
grt2b <- grig$plot2d(selvp=c("zeta"),selvl='zeta_m')
grt2ab <- plotly::subplot(grt2a,grt2b,nrows=2)
########### Tab3
grt3a <- grig$resplot(resvar=c('zeta_mr','alpha'),crossp=T)
grt3b <- grig$resplot(resvar=c('zeta_mr','x'),crossp=T)
grt3c <- grig$resplot(resvar=c('zeta_mr','y'),crossp=T)
grt3abc <- plotly::subplot(grt3a,grt3b,grt3c,nrows=3)
########## Tab5
gr3da <- grig$plotly3d(partition=1)[[1]]
gr3db <- grig$plotly3d(partition=1,selid=1)[[1]]
#####################################################################################################
