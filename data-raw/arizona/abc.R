stodfl <- dyntabulation()
output_path <- file.path(rprojroot::find_rstudio_root_file(), 'data-raw/arizona/2024/xlsx/maricopa2024.xlsx')
openxlsx::write.xlsx(stodfl, output_path)
usethis::use_data(stodfl, overwrite = TRUE)

