#################################################################################################
library(ManifoldDestiny)
sapply(list.files(paste0(rprojroot::find_rstudio_root_file(),'/R'),full.names=T), source)
abs_path <- rprojroot::find_rstudio_root_file()
library(dplyr)
library(ggplot2)
library(tidyr)
library(purrr)
library(randNames)
library(openxlsx)
library(writexl)
library(plotly)
library(ViewPipeSteps)
library(ggpubr)
library(htmltools)
library(broom)
#################################################################################################
mi_st <- get(load(paste0(abs_path,'/data/clark_miller_stavros_sel.rda')))
c_mi_st <- Countinggraphs(mi_st)
c_mi_st$sortpre()
c_mi_st$plot2d()
c_mi_st$plotly3d(partition=2)
#c_mi_st$pl_3dmani
c_mi_st$pl_2dsort
c_mi_st$gridarrange()
c_mi_st$all_pl_3dmani[[1]]
###################
ndft <- c_mi_st$rdfc %>% dplyr::mutate(gh=g*h,g2h=g^2*h) 

plot(ndft$Gamma)

View(ndft)
ests <- Estimation(ndft)
form1 <- 'alpha~h+g'
ests$regression(form1)
ests$diagnostics()
ests$resplots[1]
ests$resplots[2]

esta <- Estimation(ndft)
esta$regsum[[1]]
form2 <- 'alpha~
g+
I(g^2)+
gh+
I(h^2)+
I(g^3)+
g2h+
I(h^3)'
esta$regression(form2)
esta$diagnostics()
esta$resplots[1]
esta$resplots[2]
esta$regsum[[3]]


klist <- est$regsum[[3]][[2]]
names(klist) <-est$regsum[[3]][[1]]
#################################################################################################
est$regsum$estimate
### Sheriff
### Governor
### Senate
load(paste0(abs_path,'/data/clark_sgs_sel.rda'))
fitdf <- totwomodes(A=c('B2'),B=c('A1','C3','A2'),C=c('B1+B3'),D=c('C1+A3+C2'),dfi=clark_sgs_sel[[3]])
fitdf$C <- NA
gclark <- Countinggraphs(fitdf)
#### Step 1: Visual inspection
gnt2a <- gclark$plot2d(selvp=c("x","y","alpha"),selvl=c("x_pred","y_pred","alpha_pred"),labs=list(x="precinct (normalized)",y="precentage",caption=gclark$sumreg['alpha']))
gnt2b <- gclark$plot2d(selvp=c("zeta"),selvl="zeta_m")
#gnt2bab <- ggpubr::ggarrange(gnt2a,gnt2b, ncol=1)
gclark$plotly3d(partition=2)[1]
#gclark$plotly3d(partition=2,selid=2)[3]
### Step 2: Visual inspection
#gclark$sdfc
eclark <- Estimation(gclark$sdfc)
form <- 'g~alpha+h+I(alpha^2)+alpha*h+I(h^2)'
eclark$regression(form)
eclark$regsum[[1]][1]
eclark$regsum[[2]]
eclark$regsum[[3]]
#### Step 3: Regression
eclark$diagnostics()
eclark$resplots[[1]]
