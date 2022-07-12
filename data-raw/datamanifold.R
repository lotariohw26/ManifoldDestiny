################################################################################################################
library(ManifoldDestiny)
library(ggplot2)
library(purrr)
library(fredr)
library(DataEditR)
################################################################################################################
# Namedata
################################################################################################################
nrname <- 100000
rn <- randNames::rand_names(100, nationality="US")[,c("name.first","name.last","gender","id.value")]
###############################################################################################################
# Model
###############################################################################################################
abs_path <- function(){rprojroot::find_rstudio_root_file()}
fdm <- paste0(abs_path(),'/inst/script/symbolic/pysympy.py')
reticulate::source_python(fdm)
eqpar <- list(meql=reticulate::py$modeql,meqs=reticulate::py$modeqs)
# Saving data
usethis::use_data(eqpar, overwrite = TRUE)
###############################################################################################################
stickers <- 
  list(parameters=list(
  standard=c("x","y","zeta","alpha","lambda"),
  hybrid=c("g","h","Gamma","alpha","Omega"),
  opposition=c("m","n","xi","lambda","Omega")), 
  forms=list('_s','o_h','h_o'))
usethis::use_data(stickers, overwrite = TRUE)


