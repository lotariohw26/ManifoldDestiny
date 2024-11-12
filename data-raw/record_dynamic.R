library(dplyr)
################################################################################################################
# General script for Maricopa: 2024
###############################################################################################################
lsf <- system(paste0('ls ',rprojroot::find_rstudio_root_file(),"/data-raw/arizona/2024"), intern=T)
sct <- c('PrecinctName','Registered','ContestName','CandidateName','CandidateAffiliation','Votes_EARLY VOTE','Votes_ELECTION DAY','Votes_PROVISIONAL')
rcn <- 1:2
snn <- 1:2
#names(snap)
sapply(snn,function(per){
  #per <- 1
  txfd <-  paste0(rprojroot::find_rstudio_root_file(),'/data-raw/arizona/2024/',lsf[per])
  snap <- data.table::fread(txfd)
  cont <- unique(snap$ContestName)[rcn]
  sapply(rcn,function(rac){
    #rac <- 2
    snax <- snap %>% dplyr::select(all_of(sct)) %>% 
	    dplyr::filter(ContestName%in%cont[rac]) %>%
            dplyr::filter(CandidateAffiliation%in%c("DEM","REP")) %>%
            dplyr::mutate(C = as.integer(factor(CandidateName, levels = unique(CandidateName))),.before = 1) %>%
            dplyr::mutate(P = as.integer(factor(PrecinctName, levels = unique(PrecinctName))),.before = 1) %>%
            dplyr::select(-C,-CandidateAffiliation) %>%
            dplyr::group_by(P,ContestName) %>%
            tidyr::pivot_wider(names_from=CandidateName,values_from=c('Votes_PROVISIONAL','Votes_ELECTION DAY','Votes_EARLY VOTE')) %>%
            dplyr::ungroup() %>%
            dplyr::mutate(SNAP=per,.before = 1) 
    setNames(list(snax),cont[rac])
    }) -> lst_race
}) -> lst_race_snap
lst_race_snap_all_az_ma_2024 <- lst_race_snap
usethis::use_data(lst_race_snap_all_az_ma_2024, overwrite = TRUE)
openxlsx::write.xlsx(lst_race_snap_all_az_ma_2024,paste0(rprojroot::find_rstudio_root_file(),'/data-raw/arizona/2024/maricopa_beneral_2024.xlsx'))

bms()
