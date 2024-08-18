library(readxl)                                                                                          
ls(package:readxl)


pp <- paste0(rprojroot::find_rstudio_root_file(),"/data-raw/pdf/BaltimorePrecincts.xlsx")
sh <- excel_sheets(pp)                                                             

lbal <- lapply(1:length(sh), function(x) read_excel(pp, sheet=x))
usethis::use_data(lbal, overwrite=T)




