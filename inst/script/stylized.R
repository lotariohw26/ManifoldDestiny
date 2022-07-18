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
snr <- 1
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
vrdf$realizedgp(probv=probvset,probw=probwset,Ztech=Znr)
vrdf$regvbase()

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
