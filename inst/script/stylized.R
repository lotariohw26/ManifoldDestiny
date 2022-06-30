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
setwd(rprojroot::find_rstudio_root_file())
source('R/misc.R')
source('R/class.R')
snr <- 1 
set.seed(snr)
#################################################################################################
### I: Voterdatabase ###
# Inititating
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
### A) Fair ###
gcou <- Countinggraphs(votr)
gcou$sortpre()
#################################################################################################33
### B) Rigged ###
### Tab1
#grig <- Countinggraphs(votr)
#polr <- polynom::polynomial(grig$polyc[[1]])
#polr[1] <- 0.3096 # 0.3469
#round(polynom::integral(polr,c(0,1)),digits=4)
#grig$riggsta()
#grig$sortpre(selvar=c("x_s","x","y","y_s","alpha","alpha_s"))
#### Tab1
#grig$plot2d(selvp=c("x_s","y_s","alpha_s","alpha"),selvl=c("x_s_pred","y_s_pred","alpha_s_pred","alpha_pred"))
#### Tab2
#grig$resplot(resvar=c('zeta_m','alpha_s_res'))
#### Tab3
#grig$resplot(resvar=c('zeta_m','y_s_res'))
#### Tab4
#grig$resplot(resvar=c('zeta_m','y_s_res'))
#### Tab5
#grig$trplot(c('x_s','y_s','alpha_s'))
##################################################################################################33
### Estimation ###
#est <- Estimation()
#################################################################################################33
#library(plotly)
#p1 <- plot_ly(economics, x = ~date, y = ~unemploy) %>% 
#  add_lines(name = "unemploy")
#p2 <- plot_ly(economics, x = ~date, y = ~uempmed) %>% 
#  add_lines(name = "uempmed")
#subplot(p1, p2)
##################################################################################################33
###### Tab0
#gcou$plotxy(c("x","y"))
#ggplotly(gcou$plotxy(c("x","y")))
###### Tab1
#gquil <- gcou$plot2d(selvp=c("x","y","alpha"),selvl=c("x_pred","y_pred","alpha_pred"))
#gzeta <- gcou$plot2d(selvp=c("zeta"),selvl='zeta_m')
#plotly::subplot(gquil,gzeta,nrows=2)
###### Tab2
#gcou$resplot(resvar=c('zeta_r','alpha_res'))
###### Tab3
#gcou$resplot(resvar=c('zeta_r','y_res'))
###### Tab4
#gcou$resplot(resvar=c('zeta_r','y_res'))
###### Tab5
#gcou$trplot(selvar=c('x','y','alpha'))
#combi <- combinat::combn(5, 3)
#v <- seq(1,dim(combi)[2])
#sdfc <- gcou$sdfc %>% dplyr::select(x,y,alpha,lambda,zeta,lambda)
#v%>% purrr::map(function(x,comb=combi,df=sdfc){
#		gdf <- df %>% dplyr::select(combi[,x])
#		mrdfc <- as.matrix(gdf)
#		x <- mrdfc[,1]
#		y <- mrdfc[,2]
#		z <- mrdfc[,3]
#		plotly::plot_ly(x=x,y=y,z=z,type="scatter3d", mode="markers") %>%
#	        plotly::layout(scene = list(xaxis = list(title = names(gdf)[1]),
#                     yaxis = list(title = names(gdf)[2]),
#                     zaxis = list(title = names(gdf)[3])))
#}) -> og
#og[1]
#library(htmltools)
#htmltools::browsable(div(
#  style = "display: flex; flex-wrap: wrap; justify-content: center",
#  div(og[1], style = "width: 40%; border: solid;"),
#  div(og[2], style = "width: 40%; border: solid;"),
#  div(og[3], style = "width: 40%; border: solid;"),
#  div(og[4], style = "width: 40%; border: solid;"),
#  div(og[5], style = "width: 40%; border: solid;"),
#  div(og[6], style = "width: 40%; border: solid;"),
#  div(og[7], style = "width: 40%; border: solid;"),
#  div(og[8], style = "width: 40%; border: solid;"),
#  div(og[9], style = "width: 40%; border: solid;"),
#  div(og[10], style = "width: 40%; border: solid;")
#))
