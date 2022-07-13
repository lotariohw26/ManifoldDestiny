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
fitdf <- transtwomodes(A=c('B2'),
	      B=c('A1','C3','A2'),
	      C=c('B1','B3'),
	      D=c('C1','A3','C2'),
	      dfi=clark_sgs_sel[[3]])

gclark <- Countinggraphs(fitdf)
gclark$sortpre()
#### Step 1: Visual inspection
gnt2a <- gclark$plot2d(selvp=c("x","y","alpha"),selvl=c("x_pred","y_pred","alpha_pred"),
  labs=list(x="precinct (normalized)",y="precentage",caption=gclark$sumreg['alpha']))
gnt2b <- gclark$plot2d(selvp=c("zeta"),selvl="zeta_m",)
gnt2bab <- ggpubr::ggarrange(gnt2a,gnt2b, ncol=1)
#gnt2pab <- plotly::subplot(gnt2a,gnt2b,nrows=2)



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
#### Step 3: Regression

#### Step 4: Prediction

#### Step 5: Prediction


