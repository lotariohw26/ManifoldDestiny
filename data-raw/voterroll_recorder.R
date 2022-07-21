library(ManifoldDestiny)
library(dplyr)
library(readxl)
# Standardized values
vrsnames <- c('id','cou_nr','cou_na','birthdate','general','primary','prec_code','voted','registered','age','prec_nr')
el_date='2020-01-04'
age_limit <- c(19,100)
gen_el <- 'GENERAL-11/03/2020'
pri_el <- 'PRIMARY-03/17/2020'

# Ohio
lf_ohio <- list.files(path=paste0(rprojroot::find_rstudio_root_file(),'/data-raw/voterroll/ohio'),full.names=T)
lc_ohio <- list.files(path=paste0(rprojroot::find_rstudio_root_file(),'/data-raw/voterroll/ohio'),full.names=F)

vtr_ohio <-seq(1,length(lc_ohio)) %>% purrr::map(function(x){
  # Standardized voterroll
  ## county names
  cou_nal <- substring(lc_ohio[x],1,nchar(lc_ohio[x])-5)
  xlsx_file <- lf_ohio[x]
  ## read raw files
  sta_vot <- readxl::read_excel(xlsx_file) %>% 
    dplyr::rename(c(general=all_of(gen_el),primary=all_of(pri_el))) %>%
    dplyr::mutate(cou_na=cou_nal) %>% 
    select(SOS_VOTERID,COUNTY_NUMBER,cou_na,DATE_OF_BIRTH,VOTER_STATUS,general,primary,PRECINCT_CODE) %>% 
    ## Transform relevant data variables
    dplyr::mutate(voted=ifelse(general=='X',1,0)) %>%
    dplyr::mutate(registered=ifelse(VOTER_STATUS=='ACTIVE',1,0)) %>%
    #!
    dplyr::mutate(age=lubridate::interval(DATE_OF_BIRTH, Sys.Date())%/%lubridate::years(1)) %>%
    #dplyr::mutate(age=as.numeric(difftime(el_date,DATE_OF_BIRTH,units="weeks")/52.5)) %>%
    dplyr::mutate(age=floor(age)) %>%
    dplyr::arrange(age) %>%
    dplyr::select(-VOTER_STATUS) %>%
    dplyr::filter(age>=age_limit[1]) %>%
    dplyr::filter(age<=age_limit[2]) %>%
    dplyr::mutate(prec_nr=as.numeric(factor(PRECINCT_CODE))) %>%
    ## standardizing the names
    `colnames<-` (vrsnames)
    dplyr:: mutate(cou_na=cou_nal) %>% dplyr::relocate(cou_na,.after=cou_nr) 
}) %>% dplyr::bind_rows(.) 
usethis::use_data(vtr_ohio, overwrite = TRUE)


