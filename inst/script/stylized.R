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
vrdf <- Voterdatabase(agebracketmax,numprec,regf,namebase='default',newdraw=T)
###### Realization of DGP
probwset <- c(0.50,0.05)
probvset <- list(c(0.70,0.30,0.00),c(0.30,0.70,0.00))
Znr <- c(0,1)
vrdf$realizedgp(probv=probvset,Ztech=Znr)
votr <- vrdf$voterrollrealized
#################################################################################################33
##### A) Fair ###
gsimf <- Countinggraphs(votr, 
		        selvar=c('pre','a','b','c','d','probwd'), 
			)
gsimf$sortpre(selvar=c('x','y','alpha','lambda','zeta','probwd'))
#gsimf$quintile; l()
########## Tab1
gnt2a <- gsimf$plot2d(selvp=c("x","y","alpha","probwd"),selvl=c("x_pred","y_pred","alpha_pred"))
gnt2b <- gsimf$plot2d(selvp=c("zeta"),selvl='zeta_m')
gnt2ab <- plotly::subplot(gnt2a,gnt2b,nrows=2)
#plot(x=gsimf$quintile$zeta_r,y=gsimf$quintile$alpha_res)
#cor(x=gsimf$quintile$zeta_r,y=gsimf$quintile$y)
########## Tab3
gnt3a <- gsimf$resplot(resvar=c('zeta_r','alpha'))
gnt3b <- gsimf$resplot(resvar=c('zeta_r','y'))
gnt3c <- gsimf$resplot(resvar=c('zeta_r','x'))
gnt3abc <- plotly::subplot(gnt3a,gnt3b,gnt3c,nrows=3)
######### Tab5
#gsimf$rdfc$zeta <- 1
gn3da <- gsimf$plotly3d(partition=1)[[1]]
gn3db <- gsimf$plotly3d(partition=1,selid=1)[[3]]
####################################################################################################33
##### B) Rigged ###
grig <- Countinggraphs(votr)
grig$sortpre()
polyc <- grig$polyc[1] <- 0.50096 # 0.3469
polr <- polynom::polynomial(polyc)
round(polynom::integral(polr,c(0,1)),digits=4)
grig$riggsta()
###### Graphical ###
########## Tab1
grt2a <- grig$plot2d(selvp=c("x","y","alpha"),selvl=c("x_pred","y_pred","alpha_pred"))
grt2b <- grig$plot2d(selvp=c("zeta"),selvl='zeta_m')
grt2ab <- plotly::subplot(grt2a,grt2b,nrows=2)
########### Tab3
grt3a <- grig$resplot(resvar=c('zeta_r','alpha_res'))
grt3b <- grig$resplot(resvar=c('zeta_r','y_res'))
grt3ab <- plotly::subplot(grt3a,grt3b,nrows=2)
########## Tab5
gr3da <- grig$plotly3d(partition=1)[[1]]
gr3db <- grig$plotly3d(partition=1,selid=1)[[1]]
#####################################################################################################33
