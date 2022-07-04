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
#gcda$plotly3d(partition=3)
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
xray <- openxlsx::read.xlsx(filename,sheet='X-Ray Machine') 
rots <- dplyr::select(rot,7:9)
View(xray)
xras <- dplyr::select(xray,1:5)
diffu <- 	
length(edal$rdfc$u)
length(xras$u)
xray
rots
l()

