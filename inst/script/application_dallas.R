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
# Dallas
load("~/research/ManifoldDestiny/data/dallas_sel.rda")
gcda <- Countinggraphs(dallas_sel)
gcda$sortpre()
#### Step 1: Inspect visually
a <- gcda$plot2d(selvp=c("x","y","alpha"),selvl=c("x_pred","y_pred","alpha_pred"))
b <- gcda$plot2d(selvp=c("zeta"),selvl='zeta_m')
gcda$plotly3d(partition=1)[3]
#### Step 2: Rotation matrix
sdfc <- gcda$sdfc
edal <- Estimation(dfa)
View(dfa)

edal$rotation()
edal$rdfc
#### Step 3: Regression
#### Step 4: Prediction
#################################################################################################33
getwd()
filename <- '../../data-raw/xlsx/Dallas Texas, Completed.xlsx'
openxlsx::getSheetNames(filename) 
rot <- openxlsx::read.xlsx(filename,sheet='Complex Rotator') 
rots <- dplyr::select(rot,14:16)
View(rots)
#a <- load(paste0(ManifoldDestiny::abs_path(),'/data/dallas_sel.rda'))
dallas_sel; l()
ot <- openxlsx::read.xlsx(filename,sheet='Complex Rotator') 
library(dplyr)

sdfc <<- dallas_sel %>% dplyr::select(pre,a,b,c,d) %>% dplyr::group_by(pre) %>%
  dplyr::arrange(pre) %>% dplyr::mutate(a=sum(a),b=sum(b),c=sum(c),d=sum(d)) %>%
  dplyr::ungroup() 

sdfc; l()

