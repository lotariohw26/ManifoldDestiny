################################################################
#rm(list=ls())
################################################################
library(dplyr)
library(ggplot2)
library(purrr)
source('../../../R/empirical.R')
################################################################
countys <- seq(1,88)
polinclude <- c(1,2,6)
polreport <- 3
################################################################
### Scorecard ###
###############################################################
nr <- paste0(polinclude[1],'_',rev(polinclude)[1])
filename <- paste0('scorecards/','scorecard',nr,'.Rda')
#scorecard <- polinclude %>% map(function(x,y) keypolorder(x,county=countys) %>% dplyr::mutate(polinc=x))
#save(scorecard,file=filename)
load(file=filename)
################################################################
### Plot ###
###############################################################
countyplot(1,scorecard)
#marrangegrob
plotreport <- countys %>% purrr::map(function(x) countyplot(x,scorecard))
################################################################
### Report ###
###############################################################
######HTML#####
report <- countys %>%
  purrr::map_df(function(x) dfinputreport(x,scorecard)[[6]][,c('corr','county','polinc')]) %>%
  dplyr::distinct() %>%
  dplyr::mutate(avgcorr=round(mean(corr),digits=4)) %>%
  dplyr::select(county,polinc,corr,avgcorr)
print(xtable::xtable(report), type="html", file="example.html")
htmlTable::htmlTable(report)
save(report,file='polreport.ohio')
reportfile <- paste0("reports/",plotname)
save(report,file=reportfile)
################################################################
################################################################
