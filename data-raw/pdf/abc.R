library(googlesheets4)                                                                                        
library(tidyverse)                                                                                            
library(readxl)                                                                                          
ls(package:readxl)


pp <- paste0(rprojroot::find_rstudio_root_file(),"/data-raw/pdf/BaltimorePrecincts.xlsx")
sh <- excel_sheets(pp)                                                             
#length(sh)
lbal <- lapply(1:length(), function(x) dim(read_excel(pp, sheet=x)))

dplyr::bind_rows(lbal[[1]],lbal[[2]])

View(lbal[[1]])

abc <- cbind(lbal[[1]],lbal[[2]])


usethis::use_data(lbal, overwrite=T)




