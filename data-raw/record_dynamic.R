################################################################################################################
# General script for Maricopa
###############################################################################################################
# setNames
system(paste0('ls ',rprojroot::find_rstudio_root_file(),"/data-raw/csv/ariz2022/maricopa/txt_proto"))
#lp <- system(paste0('ls ',dirtxt),intern=T)[c(2:12,1)]
#fn <- paste0(abs_p,'/data-raw/Arizona_2022/MaricopaAZ/txt/',lp)[c(2:14,1)]
lr <- data.table::fread(paste0(abs_p,'/data-raw/Arizona_2022/maricopa/maricopadfload.csv'))[1:5,] %>% mutate(across(everything(), gsub, pattern = "'", replacement = '"'))
nr <- dim(lr)[1]
np <- length(lp)
sct <- c('PrecinctName','Registered','CandidateName','CandidateAffiliation','Votes_EARLY VOTE','Votes_ELECTION DAY')
sapply(seq(1,np),function(period){
  vot <- data.table::fread(paste0(abs_p,'/data-raw/',dirtxt,lp[period])) 
  prn <- data.frame(PrecinctName=unique(vot$PrecinctName)) %>% dplyr::mutate(P=row_number()) 
  sapply(seq(1,nr),function(rn){
    rsr <- lr[rn]
    race <- rsr$R
    cand <- unlist(rsr[,-1])
    use <- vot %>% dplyr::filter(grepl(race,ContestName)) %>%
    dplyr::select(all_of(sct)) %>% 
    dplyr::mutate(TXT=lp[period]) %>%
    dplyr::left_join(prn,by='PrecinctName') %>% 
    dplyr::filter(Registered>0) %>%
    dplyr::filter(P<935) %>%
    dplyr::group_by(P) %>%
    dplyr::filter(CandidateName%in%cand) %>%
    dplyr::arrange(P,PrecinctName,CandidateName) %>%
    dplyr::arrange(P,PrecinctName,rev(CandidateAffiliation)) %>%
    dplyr::relocate(TXT,P,PrecinctName) %>%
    dplyr::mutate(CandParty=paste0(CandidateName," ",CandidateAffiliation)) %>%
    dplyr::select(-CandidateAffiliation,-CandidateName) %>%
    tidyr::pivot_wider(names_from=CandParty,values_from=c('Votes_ELECTION DAY','Votes_EARLY VOTE')) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(SNAP=period,RACE=race,RACENR=rn) %>%
    dplyr::relocate(SNAP,RACE,RACENR) 
    setNames(list(use),race)
    }) -> lst_race
}) -> lst_race_snap 
length(lst_race_snap)
lst_race_snap_all_az_ma <- sapply(seq(1,nr),function(x){setNames(list(data.table::rbindlist(lst_race_snap[seq(x,np*nr,nr)],F)),lr[x,1])})
usethis::use_data(lst_race_snap_all_az_ma, overwrite = TRUE)
openxlsx::write.xlsx(lst_race_snap_all_az_ma,paste0(abs_p,'/data-raw/Arizona_2022/maricopa/xlsx/maricopa_midterm_2022.xlsx'))
#################################################################################################################
# General script for Cohise
###############################################################################################################
library(dplyr)
az_co_gen_2022 <- data.table::fread(paste0(rprojroot::find_rstudio_root_file(),'/data-raw/csv/ariz2022/cohise/csv/abc.csv'),header=FALSE) %>% dplyr::slice(-n())
races <- unique(as.character(az_co_gen_2022[1,-c(1:6)]))[c(1,4,9,11)]
lapply(races,function(r){
  vnr <- c(2:6,which(az_co_gen_2022[1,]==r))
  labrow <- az_co_gen_2022[1:3,] 
  ncdf <- c(as.character(labrow[1])[2:5],as.character(labrow[3])[vnr[vnr>5]])
  dfl <- dplyr::select(az_co_gen_2022,all_of(vnr))[-c(1:3),] %>% data.table::setnames(new=ncdf) 
  dplyr::select(1:8) %>%
  dplyr::group_by_at('PRECINCT CODE')  %>%
  dplyr::mutate(MODE=dplyr::row_number()) %>% 
  # Widen columns to contain different modes of votingu
  dplyr::mutate_at(names(.[])[c(1,3:8)],as.numeric) %>%
  tidyr::pivot_wider(names_from=MODE,values_from=names(.[])[4:8]) %>%
  dplyr::ungroup() %>%
  dplyr::mutate(RACE=r, .before ='PRECINCT CODE') %>%
  dplyr::mutate(SNAP=1, .before ='RACE') %>%
  dplyr::mutate_at('PRECINCT CODE', as.integer)
}) -> lst_race_snap_all_az_co
lst_race_snap_all_az_co <- setNames(lst_race_snap_all_az_co,races)
usethis::use_data(lst_race_snap_all_az_co, overwrite = TRUE)
openxlsx::write.xlsx(lst_race_snap_all_az_co,file=paste0(abs_p,'/data-raw/Arizona_2022/cohise/xlsx/election_gen_2022.xlsx'))

