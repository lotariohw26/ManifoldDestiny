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
library(gridExtra)
##################################################################################################
### Voterrollanalysis (Based on Dr. Frank)
##################################################################################################
# Voterbase
#ohio_vb <- Voterdatabase()
#ohio_vb$regvbase()
#ohio_vb$scorecard()	
#ohio_vb$predictinput()
#ohio_vb$uploadvbase()
## Graphical
#ohio_vg <- Voterdatabase()
#ohio_vg$regvbase()
#ohio_vg$scorecard()	
#ohio_vg$predictinput()
#ohio_vg$uploadvbase()
## Report
ohio_vr <- Voterrollreport()
ohio_vr$regvbase()
ohio_vr$scorecard()	
ohio_vr$predictinput()
ohio_vr$uploadvbase()
ohio_vr$htmlreport()
##################################################################################################
### Election simulation (Based on Dr. Frank)
##################################################################################################

snr <- 1
set.seed(snr)
### Part A: Fair election

### Part B: Rigged election



##################################################################################################
### Regression analysis (Based on Dr. Frank)
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
vrdf$realizedgp(probv=probvset,probw=probwset,Ztech=Znr)
vrdf$regvbase()
#####
abc_vrg <- Voterrollgraphs(coudatafile='vtr_abc.rda')
abc_vrg$scorecard()
abc_vrg$predictinput()
View(abc_vrg$polypredi[[1]])
abc_vrg$plot_predict()
abc_vrg$lg_pred[3]
abc_vrg$plot_keyrat()



abc_vrg$lg_hist()
abc_vrg$lg_pred
abc_vrg$lg_keyr
abc_vrg$gridarrange()
# Report
abc_vrr <- Voterrollreport()
abc_vrr$htmlreport()






votr <- vrdf$listvbase[[2]]
View(votr)
#################################################################################################33
###### A) Fair ###
gsimf <- Countinggraphs(votr,selvar=c('R','C','a','b','c','d','probwd'))
gsimf$sortpre(selvar=c('x','y','alpha','lambda','zeta','probwd'))
gsimf$plot2d()
gsimf$plotxy()
gsimf$resplot()
gsimf$plotly3d()
gsimf$gridarrange()
vrdf$uploadvbase(gsimf$sdfc,gsimf$rdfc,gsimf$parameters$standard)
#################################################################################################33
##### B) Rigged ###
### Part A:
grigg <- Countinggraphs(votr)
grigg$sortpre()
grigg$manfolimp(pres1=grigg$quintile$x,
	       pres2=grigg$quintile$alpha-0.05,
	       pres3=c("x-alpha","(alpha*zeta + alpha - x)/zeta")[1])
grigg$riggsta()
gsimf$gridarrange()
vrdfg$uploadvbase(grig$sdfc,grig$rdfc,grig$parameters$standard)
#################################################################################################33



