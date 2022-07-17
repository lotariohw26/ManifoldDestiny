#################################################################################################33
#library(ManifoldDestiny)
sapply(list.files(paste0(rprojroot::find_rstudio_root_file(),'/R'),full.names=T), source)
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
nr <- 1
set.seed(snr)
##################################################################################################
#### I: Voterdatabase ###
### Inititating
agebracketmax <- c(18,100,1000)
regf <- 0.8
numprec <- 200
nb <- 'defvotbase'
vrdf <- Voterdatabase(agebracketmax,numprec,regf,namebase=nb,newdraw=F)
###### Realization of DGP
probwset <- c(0.50,0.00)
probvset <- list(c(0.60,0.30,0.10),c(0.30,0.60,0.10))
Znr <- c(0,1)
vrdf$realizedgp(probv=probvset,
		probw=probwset,
		Ztech=Znr)
votr <- vrdf$listvbase[[2]]
#################################################################################################33
###### A) Fair ###
gsimf <- Countinggraphs(votr,selvar=c('P','a','b','c','d','probwd'))
gsimf$sortpre(selvar=c('x','y','alpha','lambda','zeta','probwd'))
#################################################################################################33
##### B) Rigged ###
### Part A:
grig <- Countinggraphs(votr)
grig$sortpre()
grig$manfolimp(pres1=grig$quintile$x,
	       pres2=grig$quintile$alpha-0.05,
	       pres3=c("x-alpha","(alpha*zeta + alpha - x)/zeta")[1])
grig$riggsta()
grig$parameters$standard
vrdf$uploadvbase(grig$sdfc,grig$rdfc,grig$parameters$standard)



#################################################################################################33
#################################################################################################33
#################################################################################################33
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
######################################################################################################
##### B) Rigged ###
### Part A:
grig <- Countinggraphs(votr)
grig$sortpre()
p1 <- grig$quintile$x
p2 <- grig$quintile$alpha-0.05
p3 <- c("x-alpha","(alpha*zeta + alpha - x)/zeta")[1]
grig$manfolimp(pres1=p1,
	       pres2=p2,
	       pres3=p3)
grig$riggsta()
grig$parameters$standard
vrdf$uploadvbase(grig$sdfc,grig$rdfc,grig$parameters$standard)
View(vrdf$listvbase[[5]])
## Part B: Estimation
gcda <- Countinggraphs(vrdf$listvbase[[5]])
View(gcda$sdfc)
gcda$sortpre()
restim <- Estimation(gcda$sdfc)
form <- 'g~alpha+h+I(alpha^2)+alpha*h+I(h^2)'
restim$regression(form)
restim$regsum[3]
###### Graphical ###
########## Tab1
jrt2a <- grig$plot2d(selvp=c("x","y","alpha"),selvl=c("x_pred","y_pred","alpha_pred"))
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
