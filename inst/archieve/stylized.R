###############################################################################################
#rm(list=ls())
# Voter database
#################################################################################################
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
library(ManifoldDestiny)
#################################################################################################
# State 1
pol_order_s1 <- 6
c1 <- 0.05
 State 2
phantom_s2 <- 6
c2 <- 0.05
##################################################################################################
### Inititating voterdatabase for two states
#### State 1
vb1 <- dgprealized(state=1,maxpeople=100,credit=c1)
vb2 <- dgprealized(state=2,maxpeople=100,credit=c2)
voterdatabase <- dplyr::bind_rows(vb1,vb2)
#writexl::write_xlsx(voterdatabase, paste0('voterdatabase.xlsx'))
###################################################################################################
#voterdatabase <- readxl::read_excel("voterdatabase.xlsx")
#system('libreoffice voterdatabase.xlsx')
##################################################################################################
### Properties
state1_election_data <- filter(voterdatabase,state==1)
state2_election_data <- filter(voterdatabase,state==2)
#natural <- polinj(voterdatabase,polynr=7)
#natural1 <- polinj(state1_election_data,polynr=7)
#natural2 <- polinj(state2_election_data,polynr=7)
#gridExtra::grid.arrange(natural[[3]],natural1[[3]],natural2[[3]])
###################################################################################################
## State 1: Fair election ###
## Counting and sorting
election_box_df_state1 <- countingp(state1_election_data)
quintile_df_s1 <- sortprecinct(election_box_df_state1,pol_order=2,M=F)
####################################################################################################
quintileplot(quintile_df=quintile_df_s1,filcou='A')[[1]]

#quintileplot(quintile_df=quintile_df_s1,filcou='B')[[1]]

# Correlation
a <- quintile_df_s1 %>% tidyr::pivot_wider() %>%
	dplyr::group_by(county,votetype) %>%
	dplyr::mutate(cxy=cor(x,y)) %>%
	dplyr::mutate(cxalpha=cor(x,alpha)) %>%
	dplyr::distinct()
####################################################################################################
## State 2: Rigged election ###
### Countingprocess
### Sorting and predicting
election_box_df_s2 <- countingp(state2_election_data)
###################################################################################################
# Set by regulator enginered
## Part I
#sortprecinct <- function(election_box_df=NULL,pol_order=7){
### Countingprocess
kn <- 0.10
hn <- -0.0282354516396
natural <- polinj(relperel=state2_election_data,polynr=2)
insertalpha <- natural[[1]] %>% dplyr::select(county,pre_n_o,alpha) %>% dplyr::rename(alphao=alpha)
# Shuffled
#dplyr::mutate(alpha=sample(alpha))
#####
ac <- natural$polc
#ac[1] <- 0.30
sp <- polynom::integral(polynom::polynomial(ac),c(0,1))
###################################################################################################
regul <- T
quintile_df_s2 <- sortprecinct(election_box_df_s2,pol_order=2,M=regul,kn=kn,hn=hn,polypred=insertalpha)
###############################################################################
#quintileplot(quintile_df=quintile_df_s2,filcou='A')[[1]]
#quintileplot(quintile_df=quintile_df_s2,filcou='B')[[1]]
###############################################################################
# Correlation
b <- quintile_df_s2 %>% tidyr::pivot_wider() %>%
	dplyr::group_by(county,votetype) %>%
	dplyr::mutate(cxy=cor(x,y)) %>%
	dplyr::mutate(cxalpha=cor(x,alpha)) %>%
	#dplyr::select(cxy,cxalpha) %>%
	dplyr::distinct()
###############################################################################
###############################################################################
# State 1 #
countys <- c("A","B")
polinclude <- c(1,2,6)
#
#### Demand  of creditvoters
cv_s1 <- quintile_df_s1 %>% dplyr::group_by(county) %>% dplyr::select(county,pi,pi_ind,creditv) %>% dplyr::distinct()
#
#### Plots
coulistpoly_s1 <- polinclude %>% purrr::map(function(x) coupolybase(dfage=state1_election_data,polyorder=x,M=0))
countyplot3(dfl=coulistpoly_s1,type="natural", cou='A',state=1)
countyplot3(dfl=coulistpoly_s1,type="natural", cou='B',state=1)
##################################################################################################
# State 2 #
countys <- c("A","B")
polinclude <- c(1,2,6)

### Demand  of creditvoters
cv_s2 <- quintile_df_s2 %>% dplyr::group_by(county) %>% dplyr::select(county,pi,pi_ind,creditv) %>% dplyr::distinct()

### Allfunction
coulistpoly_s2_1 <- polinclude %>% purrr::map(function(x) coupolybase(dfage=state2_election_data,polyorder=x,M=0,scale=1))
countyplot3(dfl=coulistpoly_s2_1,type='natural',cou='A',state=2)
countyplot3(dfl=coulistpoly_s2_1,type='rigged',cou='B',state=2)

coulistpoly_s2 <- polinclude %>% purrr::map(function(x) coupolybase(dfage=state2_election_data,polyorder=x,M=1,scale=c(1,0.5)))

countyplot3(dfl=coulistpoly_s2,type='rigged',cou='A',state=2)
countyplot3(dfl=coulistpoly_s2,type='rigged',cou='B',state=2)
#################################################################################################
#T1: testing scaling
#T2: keymanipulator(scale=scale,voterbase=dfs,needed=500)[[2]] for each scale
#T3: abc
f <- function (x, a) x - a
x <- -100:100
plot(x,f(x,a=10))
uniroot(f, c(0, 1), tol = 0.0001, a = 1/3)
#################################################################################################
