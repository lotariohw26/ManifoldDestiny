# libraries
ManifoldDestiny::wasmconload()
library(usethis)
source(paste0(rprojroot::find_rstudio_root_file(),"/R/wasmconverting.R"))
source(paste0(rprojroot::find_rstudio_root_file(),"/R/wasmnonverting.R"))
qenvar <- yaml::yaml.load_file(paste0(rprojroot::find_rstudio_root_file(),"/_variables.yml"))
googlesheets4::gs4_auth(email="lotariohw26@gmail.com")
qenvar$app1
recoudatr(qenvar$app1)
bm()


