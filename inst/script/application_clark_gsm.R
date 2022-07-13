#################################################################################################
library(ManifoldDestiny)
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
abs_path <- function(){rprojroot::find_rstudio_root_file()}
source(paste0(abs_path(),'/R/misc.R'))
source(paste0(abs_path(),'/R/class.R'))
#################################################################################################
load(paste0(abs_path(),'/data/clark_sgs_sel.rda'))
fitdf <- clark_sgs_sel[[3]] %>% dplyr::mutate(a=B2,
					    b=A1+C3+A2, 
					    c=B1+B3,
					    d=C1+A3+C2) 
gclark <- Countinggraphs(fitdf)
#### Step 1: Visual inspection
#gcq <- gclark$plot2d(selvp=c("x","y","alpha"),selvl=c("x_pred","y_pred","alpha_pred"))
#gcz <- gclark$plot2d(selvp=c("zeta"),selvl='zeta_m')
##plotly::subplot(gcq,gcz,nrows=2)
#grrza <- gclark$resplot(resvar=c('zeta_mr','alpha_res'))
#gcrzy <- gclark$resplot(resvar=c('zeta_mr','y_res'))
#gclark$plotly3d(partition=2)[1]
#gclark$plotly3d(partition=2,selid=2)[3]
### Step 2: Visual inspection
gclark$sdfc
eclark <- Estimation(gclark$sdfc)
form <- 'g~alpha+h+I(alpha^2)+alpha*h+I(h^2)'
eclark$regression(form)
eclark$regsum[[1]][1]
eclark$regsum[[2]]
eclark$regsum[[3]]
eclark$regsum[[4]]
str(eclark$regsum)
#### Step 3: Regression

#### Step 4: Prediction

#### Step 5: Prediction


