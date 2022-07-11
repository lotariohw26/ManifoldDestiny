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
########## Tab1
gsimf <- Countinggraphs(votr)
gsimf$sortpre()
ggt2a <- gsimf$plot2d(selvp=c("x","y","alpha"),selvl=c("x_pred","y_pred","alpha_pred"))
ggt2b <- gsimf$plot2d(selvp=c("zeta"),selvl='zeta_m')
ggt2ab <- plotly::subplot(ggt2a,ggt2b,nrows=2)
########## Tab3
ggt3a <- gsimf$resplot(resvar=c('zeta_r','alpha_res'))
ggt3b <- gsimf$resplot(resvar=c('zeta_r','y_res'))
ggt3ab <- plotly::subplot(ggt3a,ggt3b,nrows=2)
######### Tab5
gsimf$rdfc$zeta <- 1
gg3da <- gsimf$plotly3d(partition=1)[[1]]
gg3db <- gsimf$plotly3d(partition=1,selid=1)[[3]]
####################################################################################################33
##### B) Rigged ###
##### Tab1
grig <- Countinggraphs(votr)
grig$sortpre()
##polr[1] <- 0.3096 # 0.3469
polr <- polynom::polynomial(grig$polyc[[1]])
round(polynom::integral(polr,c(0,1)),digits=4)
grig$riggsta()

View(grig$pardf)


###### Graphical ###
######## Tab1
###ggt1 <- grig$plotxy(c("x","y"))
###ggplotly(ggt1)
######### Tab2
###ggt2a <- grig$plot2d(selvp=c("x","y","alpha"),selvl=c("x_pred","y_pred","alpha_pred"))
###ggt2b <- grig$plot2d(selvp=c("zeta"),selvl='zeta_m')
###plotly::subplot(ggt2a,ggt2b,nrows=2)
######### Tab3
###ggt3a <- gcou$resplot(resvar=c('zeta_r','alpha_res'))
###ggt3b <- gcou$resplot(resvar=c('zeta_r','y_res'))
######### Tab4
####gcou$resplot(resvar=c('zeta_r','y_res'))
######### Tab5
###grig$plotly3d(partition=1)
#####################################################################################################33
