################################################################################################################
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
proot <- rprojroot::find_rstudio_root_file()
setwd(proot)
fdm <- paste0(proot,'/inst/script/symbolic/pysympy.py')
reticulate::source_python(fdm)
eqpar <- list(meql=reticulate::py$modeql,meqs=reticulate::py$modeqs)
# Saving data
usethis::use_data(eqpar, overwrite = TRUE)
# Lagre data
###############################################################################################################
setwd(rprojroot::find_rstudio_root_file())
getwd()
system('R CMD build . ; R CMD INSTALL ManifoldDestiny_0.0.0.9000.tar.gz; rm -r ManifoldDestiny_0.0.0.9000.tar.gz')
library(ManifoldDestiny)
