library(ManifoldDestiny)
library(dplyr)
library(readxl)
# Standardized values
vrsnames <- c('id','cou_nr','birthdate','general','primary','voted','registered','age')
el_date='2020-01-04'
age_limit <- c(19,100)
gen_el <- 'GENERAL-11/03/2020'
pri_el <- 'PRIMARY-03/17/2020'

# Ohio
lf_ohio <- list.files(path=paste0(rprojroot::find_rstudio_root_file(),'/data-raw/voterroll/ohio'),full.names=T)
lc_ohio <- list.files(path=paste0(rprojroot::find_rstudio_root_file(),'/data-raw/voterroll/ohio'),full.names=F)
vtr_ohio <- lf_ohio %>% purrr::map(function(x){
  # Standardized voterroll
  ## county names
  cou_nal <- substring(lc_ohio[1],1,nchar(lc_ohio[1])-5)
  ## read raw files
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
    dplyr::mutate(ag_geovo=n_distinct(id)) %>%
    dplyr::mutate(ag_voted=sum(voted, na.rm=T)) %>%
    dplyr::mutate(ag_regis=sum(registered, na.rm=T)) %>% 
    dplyr::mutate(ag_gevos=ag_voted/ag_geovo) %>% 
    dplyr::mutate(ag_revos=ag_voted/ag_regis) %>%
    ### for county
    dplyr::ungroup() %>%
    dplyr::select(cou_nr,age,ag_geovo,ag_regis,ag_voted,ag_gevos,ag_revos) %>%
    dplyr::distinct() %>%
    dplyr::mutate(tot_geopo=sum(ag_geovo)) %>%
    dplyr::mutate(tot_voted=sum(ag_voted)) %>%
    dplyr::mutate(tot_regis=sum(ag_regis)) %>%
    dplyr::mutate(geo_ratio=tot_voted/tot_geopo) %>%
    dplyr::mutate(tur_ratio=tot_voted/tot_regis) %>%
    dplyr::mutate(go_key_ratio=ag_gevos/geo_ratio) %>%
    dplyr::mutate(re_key_ratio=ag_revos/tur_ratio) %>%
    ### add county names
    dplyr:: mutate(cou_na=cou_nal) %>% dplyr::relocate(cou_na,.after=cou_nr) 
}) %>% dplyr::bind_rows(.) 
usethis::use_data(vtr_ohio, overwrite = TRUE)
View(sta_vot)
