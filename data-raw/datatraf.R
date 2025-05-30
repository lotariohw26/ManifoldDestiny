# Arizona
library(ManifoldDestiny)
library(dplyr)
library(tibble)
ManifoldDestiny::wasmconload()
library(usethis)
source(paste0(rprojroot::find_rstudio_root_file(),"/R/wasmconverting.R"))
source(paste0(rprojroot::find_rstudio_root_file(),"/R/wasmnonverting.R"))

stodfl <- dyntabulation()
googlesheets4::gs4_auth(email="lotariohw26@gmail.com")

output_path <- file.path(rprojroot::find_rstudio_root_file(), 'data-raw/arizona/2024/xlsx/maricopa2024.xlsx')
openxlsx::write.xlsx(stodfl, output_path)
usethis::use_data(stodfl, overwrite = TRUE)




library(googledrive)


abc <- stodfl[[1,]] %>% googlesheets4::sheet_write("https://docs.google.com/spreadsheets/d/1qjUX0AIlLbOKvBH6nFKVl_n22XpHAnHrflsBA4DtJQQ/edit?gid=0#gid=0", sheet = "abc")




