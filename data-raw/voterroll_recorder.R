library(ManifoldDestiny)
library(dplyr)

# Standardized values
vrsnames <- c('id','cou_nr','birthdate','general','primary','voted','registered','age')
el_date='2020-01-04'
age_limit <- c(19,100)
gen_el <- 'GENERAL-11/03/2020'
pri_el <- 'PRIMARY-03/17/2020'

# Ohio
lf_ohio <- list.files(path=paste0(rprojroot::find_rstudio_root_file(),'/data-raw/voterroll/ohio'),full.names=T)
vtr_ohio <- lf_ohio %>% purrr::map(function(x){
  # Standardized voterroll
  ## read raw file
  sta_vot <- readxl::read_excel(x) %>% 
    dplyr::rename(c(general=all_of(gen_el),primary=all_of(pri_el))) %>%
    select(SOS_VOTERID,COUNTY_NUMBER,DATE_OF_BIRTH,VOTER_STATUS,general,primary) %>%
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
    ## standardizing the names
    `colnames<-` (vrsnames) %>%
    ## standardizing the variables needed
    ### for each age group
    dplyr::group_by(age) %>% 
    dplyr::mutate(ag_voted=sum(voted, na.rm=T)) %>%
    dplyr::mutate(ag_regis=sum(registered, na.rm=T)) %>% 
    dplyr::mutate(ag_regra=ag_voted/ag_regis) %>% 
    ### for county
    dplyr::ungroup() %>%
    dplyr::select(cou_nr,age,ag_voted,ag_regis,ag_regra) %>%
    dplyr::distinct() %>%
    dplyr::mutate(tot_voted=sum(ag_voted)) %>%
    dplyr::mutate(tot_regist=sum(ag_regis)) %>%
    dplyr::mutate(tur_ratio=tot_voted/tot_regist) %>%
    dplyr::mutate(key_ratio=ag_regra/tur_ratio)
}) %>% dplyr::bind_rows(.) 
vtr_ohio
usethis::use_data(vtr_ohio, overwrite = TRUE)


