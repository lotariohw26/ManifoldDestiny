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
library(htmltools)
setwd(rprojroot::find_rstudio_root_file())
source('R/misc.R')
source('R/class.R')
snr <- 1
set.seed(snr)
#################################################################################################
# Dallas
load("~/research/ManifoldDestiny/data/dallas_sel.rda")
invdallas <- Countinggraphs(dallas_sel)
invdallas$sortpre()
invdallas$plotly3d(partition=3)
#### Step 1: Inspect visually
#### Step 2: Rotation matrix
#### Step 3: Regression
#### Step 4: Prediction
#################################################################################################33
# Clark
### Tab1
#ge <- parse(text='k1*alpha+k2*h+k3')
#load("~/research/ManifoldDestiny/data/clark_sel.rda")
#str(clark_sel)
#est_clark  <- Estimation(clark_sel)j
#est_clark$rotation()
#est_clark$estimation()
#est_clark$plotxy()
#load("~/Research/ManifoldDestiny/data/nevada_sel.rda")
##################################################################################################
# Maricopa
#load("~/research/ManifoldDestiny/data/maricopa_sel.rda")
#str(maricopa_sel)
#est_maricopa  <- Estimation(maricopa_sel)
#est_maricopa$plotly3d(selvar=c('x','y','alpha'))
#est_maricopa$plotly3d(selvar=c('g','h','alpha'))
#sdfinp; l()
#gcou$sortpre(6,'alpha')
#################################################################################################33
