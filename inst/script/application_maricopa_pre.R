#################################################################################################
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
#################################################################################################
load(paste0(abs_path(),'/data/maricopa_sel.rda'))
gmaric <- Countinggraphs(maricopa_sel)
gmaric$sortpre()
#### Step 1: Inspect visually
gcq <- gmaric$plot2d(selvp=c("x","y","alpha"),selvl=c("x_pred","y_pred","alpha_pred"))
gcz <- gmaric$plot2d(selvp=c("zeta"),selvl='zeta_m')
plotly::subplot(gcq,gcz,nrows=2)
gcrza <- gmaric$resplot(resvar=c('zeta_r','alpha_res'))
gcrzy <- gmaric$resplot(resvar=c('zeta_r','y_res'))
gmaric$plotly3d(partition=1)[1]
gmaric$plotly3d(partition=1,selid=2)[3]
#### Step 2: Rotation matrix
eclark <- Estimation(gmaric$sdfc)
#edal$rotation()
#### Step 3: Regression

#### Step 4: Prediction

#### Step 5: Prediction
