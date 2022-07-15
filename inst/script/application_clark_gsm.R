#################################################################################################
#library(ManifoldDestiny)
sapply(list.files(paste0(rprojroot::find_rstudio_root_file(),'/R'),full.names=T), source)
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
#################################################################################################
### Sheriff
### Governor
### Senate
load(paste0(abs_path(),'/data/clark_sgs_sel.rda'))
fitdf <- totwomodes(A=c('B2'),B=c('A1','C3','A2'),C=c('B1+B3'),D=c('C1+A3+C2'),dfi=clark_sgs_sel[[3]])
fitdf$C <- fitdf$R*0.20
gclark <- Countinggraphs(fitdf)
gclark$sortpre()
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
