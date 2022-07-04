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
gcda <- Countinggraphs(dallas_sel)
gcda$sortpre()
#### Step 1: Inspect visually
a <- gcda$plot2d(selvp=c("x","y","alpha"),selvl=c("x_pred","y_pred","alpha_pred"))
b <- gcda$plot2d(selvp=c("zeta"),selvl='zeta_m')
#plotly::subplot(a,b,nrows=2)
#gcda$plotly3d(partition=3)
#### Step 2: Rotation matrix

#### Step 3: Regression
#### Step 4: Prediction
#################################################################################################33


###
library(dplyr)
filename <- 'xlsx/Dallas Texas, Completed.xlsx'
openxlsx::getSheetNames(filename) 
dallasxray <- openxlsx::read.xlsx(filename,sheet='X-Ray Machine') 


s_depth	<- 0.01
s_division	<- 0.02
s_shift	<- 50
s_slide	<- -49

build <- dallasxray[1:741,] %>% dplyr::select(7,8,9) %>% 
	 dplyr::mutate(rank_v=dense_rank(v)) %>% 
	 dplyr::mutate(slide=floor((v+s_depth*s_division*s_shift)/s_depth)) %>%
	 dplyr::mutate(slide_norm=slide-(s_slide)+1) %>%
	 dplyr::mutate(carry_slide_norm=1000*rank_v+slide_norm, 
	 	      carry_v=1000*rank_v+v, 
	 	      carry_u=1000*rank_v+u,
	 	      carry_w=1000*rank_v+w) %>%
	 dplyr::mutate(index=row_number()) %>%
	 dplyr::mutate(sort_slide_norm=sort(carry_slide_norm)) %>%
	 dplyr::mutate(sort_v=sort(carry_v),
		       sort_u=sort(carry_u),
		       sort_w=sort(carry_w)) %>%
	 dplyr::mutate(drop_s=sort_slide_norm-1000*index+s_slide-1,
		      drop_v=sort_v-1000*index,
		      drop_u=sort_u-1000*index,
		      drop_w=sort_w-1000*index) 
	 dplyr::mutate(Fat_Slide=0,
		       Partition_Rank_=0,
		       True Rank=0)
View(build)

