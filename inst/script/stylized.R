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
vrdf <- Voterdatabase(agebracketmax,numprec,regf,newdraw=F)
###### Realization of DGP
probwset <- c(0.50,0.05)
probvset <- list(c(0.70,0.30,0.00),c(0.30,0.70,0.00))
Znr <- c(0,1)
vrdf$realizedgp(probv=probvset,Ztech=Znr)
votr <- vrdf$voterrollrealized
#################################################################################################33
##### A) Fair ###
#gsimf <- Countinggraphs(votr,selvar=c('P','a','b','c','d','probwd'))
#gsimf$sortpre(selvar=c('x','y','alpha','lambda','zeta','probwd'))
########### Tab1
#gnt2a <- gsimf$plot2d(selvp=c("x","y","alpha","probwd"),selvl=c("x_pred","y_pred","alpha_pred"),
#  labs=list(x="precinct (normalized)",y="precentage",caption=gsimf$sumreg['alpha']))
#gnt2b <- gsimf$plot2d(selvp=c("zeta"),selvl="zeta_m",)
#gnt2bab <- ggpubr::ggarrange(gnt2a,gnt2b, ncol=1)
#gnt2pab <- plotly::subplot(gnt2a,gnt2b,nrows=2)
########### Tab3
#gnt3a <- gsimf$resplot(resvar=c('zeta_mr','alpha'))
#gnt3b <- gsimf$resplot(resvar=c('zeta_mr','y'))
#gnt3c <- gsimf$resplot(resvar=c('zeta_mr','x'))
#gnt3abcb <- ggpubr::ggarrange(gnt3a,gnt3b,gnt3c,nrow=3)
#gnt3abcp <- plotly::subplot(gnt3a,gnt3b,gnt3c,nrows=3)
########### Tab4
#gnt4a <- gsimf$resplot(resvar=c('zeta_mr','alpha'),crossp=T)
#gnt4b <- gsimf$resplot(resvar=c('zeta_mr','y'),crossp=T)
#gnt4c <- gsimf$resplot(resvar=c('zeta_mr','x'),crossp=T)
#gnt4babc <- ggpubr::ggarrange(gnt4a,gnt4b,gnt4c, nrow=4)
#gnt4pabc <- plotly::subplot(gnt4a,gnt4b,gnt4c,nrows=3)
########## Tab5
##gsimf$rdfc$zeta <- 1
#gn3da <- gsimf$plotly3d(partition=1)[[1]]
#gn3db <- gsimf$plotly3d(partition=1,selid=1)[[3]]
#####################################################################################################
##### B) Rigged ###
grig <- Countinggraphs(votr)
grig$sortpre()
grig$manfolimp()
grig$riggsta()
vrdf$uploadvbase(truevotdf=grig$sdfc,manipvotdf=grig$parampre)
grig$se$y_s[3]
# [1] "(alpha*zeta + alpha - x)/zeta"
# [1] "(alpha*zeta + alpha - x)/zeta"
# [1] NA


grig$sortpre()
grt2a <- grig$plot2d(selvp=c("x","y","alpha"),selvl=c("x_pred","y_pred","alpha_pred"))
gr3da <- grig$plotly3d(partition=1)[[1]]
grig$rdfc; l()
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
