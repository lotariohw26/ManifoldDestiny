#library(ManifoldDestiny)
abs_path <- paste0(rprojroot::find_rstudio_root_file())
lf <- list.files(paste0(abs_path,'/R/'))
for (t in 1:length(lf))source(paste0(abs_path,'/R/',lf[t]))
library(testthat)
library(stringr)
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
vtest <- Voterdatabase()
vtest$realizedgp()
ctest <- Countingprocess(vtest$listvbase[[2]])
cmat <- ctest$sdfc
parlform <- ctest$parameters
seqpy <- ctest$se

testthat::test_that("counting",{
  vf <- rowSums(cmat[,c("a","b","c","d")])
  ve <- cmat$V
  expect_equal(vf,ve) 
})

testthat::test_that("tautologies",{
  pm <- as.vector(unlist(parlform))
  parlv <- paste0(pm,each=rep(c('_s','_h','_o'), each=5))
  eqv <- seqpy  
  pe <- cmat[, pm]
  po <- cmat[, c('a','b','c','d')]
  pv <- parlv %>% purrr::map_dfc(function(x,cmat){pareq(eqv[[x]][1],po)}) %>% 
	  `colnames<-` (pm)
  expect_equal(pv,pe) 
})

