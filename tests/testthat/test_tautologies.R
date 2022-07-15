#library(ManifoldDestiny)
abs_path <- paste0(rprojroot::find_rstudio_root_file())
lf <- list.files(paste0(abs_path,'/R/'))
for (f in length(lf)){source(paste0(abs_path,'/R/',lf[f]),echo=T)}
source("../../R/countingprocess.R", echo=T)

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
testthat::test_that("tautologies",{
  vtest <- Voterdatabase()
  vtest$realizedgp()
  vtest$listvbase[[2]]
  ctest <- Countingprocess(vtest$listvbase[[2]])
  vf <- rowSums(ctest$sdfc[,c("a","b","c","d")])
  ve <- ctest$sdfc$V
  # 
  expect_equal(vf,ve) 
})

