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
setwd(rprojroot::find_rstudio_root_file())
source('R/misc.R')
source('R/class.R')
snr <- 1
set.seed(snr)
#################################################################################################
# Dallas
load("~/research/ManifoldDestiny/data/dallas_sel.rda")
gcda <- Countinggraphs(dallas_sel)
gcda$sortpre()
#### Step 1: Inspect visually
a <- gcda$plot2d(selvp=c("x","y","alpha"),selvl=c("x_pred","y_pred","alpha_pred"))
b <- gcda$plot2d(selvp=c("zeta"),selvl='zeta_m')
#plotly::subplot(a,b,nrows=2)
gcda$plotly3d(partition=1)[1]
#### Step 2: Rotation matrix
dfa <- gcda$rdfc
edal <- Estimation(dfa)
edal$rotation()
edal$rdfc
#### Step 3: Regression
#### Step 4: Prediction
#################################################################################################33
###
filename <- 'data-raw/xlsx/Dallas Texas, Completed.xlsx'
openxlsx::getSheetNames(filename) 
rot <- openxlsx::read.xlsx(filename,sheet='Complex Rotator') 
a <- load(paste0(ManifoldDestiny::abs_path(),'/data/dallas_sel.rda'))
dallas_sel; l()
ot <- openxlsx::read.xlsx(filename,sheet='Complex Rotator') 
library(dplyr)

sdfc <<- dallas_sel %>% dplyr::select(pre,a,b,c,d) %>% dplyr::group_by(pre) %>%
  dplyr::arrange(pre) %>% dplyr::mutate(a=sum(a),b=sum(b),c=sum(c),d=sum(d)) %>%
  dplyr::ungroup() 

sdfc; l()
