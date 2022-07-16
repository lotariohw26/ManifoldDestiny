library(ManifoldDestiny)
library(dplyr)

# Standardized values
vrsnames <- c('counr','birthdate','voterstatus','age')
el_date='2020-01-04'

# Ohio
lf_ohio <- list.files(path=paste0(rprojroot::find_rstudio_root_file(),'/data-raw/voterroll/ohio'),full.names=T)
vtr_ohio <- lf_ohio %>% purrr::map(function(x){
  # Standardize voterroll
  ## read raw file
  sta_vot <- readxl::read_excel(x) %>% 
  ## select relevant data variables
  select(COUNTY_NUMBER,DATE_OF_BIRTH,VOTER_STATUS) %>%
  ## rransform relevant data variables
  dplyr::mutate(age=lubridate::interval(DATE_OF_BIRTH, Sys.Date())%/%lubridate::years(1)) %>%
  #dplyr::mutate(age=as.numeric(difftime(el_date,DATE_OF_BIRTH,units="weeks")/52.5)) %>%
  dplyr::mutate(age=floor(age)) %>%
  ## standardizing the names
  `colnames<-` (vrsnames)
})
usethis::use_data(vtr_ohio, overwrite = TRUE)
#  [1] "/home/joernih/research/ManifoldDestiny/data-raw/voterroll/ohio/ASHLAND.xlsx"   
#  [2] "/home/joernih/research/ManifoldDestiny/data-raw/voterroll/ohio/ATHENS.xlsx"    
