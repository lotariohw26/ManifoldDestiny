rm(list=ls())
###############################################################################
# Version 1.0
# Replication of Ed Solomon's results from Maricopa County, Arizona
# jhttps://docs.google.com/spreadsheets/d/1hL9K-k5ItlQqvM47oFWCzxlPhApy0oVNmAUH8qlp9Ww/edit#gid=1626590129
###############################################################################
###############################################################################
library(tidyr)
library(ggpmisc)
library(dplyr)
library(plotly)
library(readxl)
source('../../../R/algofunctions.R')
###############################################################################
### Readling all data
Dallas_Texas_Revised_I <- read_excel("Dallas Texas Revised.xlsx", sheet = 1)
Dallas_Texas_Revised_II <- read_excel("Dallas Texas Revised.xlsx", sheet = 2)
#names(Dallas_Texas_Revised_I) <- 
names(Dallas_Texas_Revised_II) <- 
c( "Precinct"/
"Registered Voters"/
"a"/
"b"/
"c"/
"d"/
"e"/
"f"/
"x"/
"y"/
"t"/
"alpha_x_y"/
"alpha_x_t"/
"alpha_y_t"/
"alpha_xyt"/
"lambda_x_y"/
"lambda_x_t"/
"lambda_y_t"/
"lambda_x_y_t"/
"lambda_x_t_y"/
"lambda_y_t_x"/
"zeta_x_y"/
"1/zeta_x_t"/
"1/zeta_y_t"/
"1/zeta_x_y_tot"/
"zeta_x_t_toy"/
"1/zeta_y_tto_x"/)
###############################################################################
Dallas_Texas_Revised_II

