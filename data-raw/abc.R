library(tibble)
ManifoldDestiny::wasmconload()
library(usethis)
source(paste0(rprojroot::find_rstudio_root_file(),"/R/wasmconverting.R"))
source(paste0(rprojroot::find_rstudio_root_file(),"/R/wasmnonverting.R"))
stodfl <- dyntabulation()
output_path <- file.path(rprojroot::find_rstudio_root_file(), 'data-raw/arizona/2024/xlsx/maricopa2024.xlsx')
openxlsx::write.xlsx(stodfl, output_path)
usethis::use_data(stodfl, overwrite = TRUE)
googlesheets4::gs4_auth(email="lotariohw26@gmail.com")

cn1 <- unique(stodfl[[1]]$ContestName)
cn2 <- unique(stodfl[[2]]$ContestName)
urlc <- "https://docs.google.com/spreadsheets/d/1WynVXWKWXAZspN-6J8-oREMVUBkOHukQawZF9tW0Ii0/edit?gid=2002645650#gid=2002645650"
stodfl[[1]] %>% googlesheets4::sheet_write(urlc, sheet = cn1)
stodfl[[2]] %>% googlesheets4::sheet_write(urlc, sheet = cn2)


