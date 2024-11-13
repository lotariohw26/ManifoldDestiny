library(dplyr)
abc <- function(fld="/data-raw/arizona/2024/",
		rac=c("Presidential Electors","US Senate"),
		aff=c("DEM","REP"),
		vom=c('Votes_PROVISIONAL','Votes_ELECTION DAY','Votes_EARLY VOTE'),
		sct=c('PrecinctName','Registered','ContestName','CandidateName','CandidateAffiliation','Votes_EARLY VOTE','Votes_ELECTION DAY','Votes_PROVISIONAL')){
  cmd <- paste0('ls ',rprojroot::find_rstudio_root_file(),fld)
  scd <- system(cmd, intern=T)
  lsf <- scd[grep("txt", scd)]
  sapply(1:length(lsf),function(per){
    #per <- n1
    flsp <-  paste0(rprojroot::find_rstudio_root_file(),fld,lsf[per])
    losd <- data.table::fread(flsp)
    sapply(1:length(rac),function(con){
        snax <- losd %>% 
		dplyr::select(all_of(sct)) %>% 
		dplyr::filter(ContestName%in%rac[con]) %>% 
		dplyr::filter(CandidateAffiliation%in%aff) %>%
                dplyr::mutate(P = as.integer(factor(PrecinctName, levels = unique(PrecinctName))),.before = 1) %>%
                dplyr::select(-CandidateAffiliation) %>%
		dplyr::group_by(P,ContestName) %>%
                tidyr::pivot_wider(names_from=CandidateName,values_from=c('Votes_PROVISIONAL','Votes_ELECTION DAY','Votes_EARLY VOTE')) %>% 
                dplyr::ungroup() %>%
                dplyr::mutate(SNAP=per,.before = 1) 
	setNames(list(snax),per) 
    	#browser()
	#View(snax)
    }) -> lst_rac
  }) -> lst_rac_snp  
}
abc()
fldv="/data-raw/arizona/2024/" 
racv=c("Presidential Electors","US Senate") 
affv=c("DEM","REP") 
vomv=c('Votes_PROVISIONAL','Votes_ELECTION DAY','Votes_EARLY VOTE') 
sctv=c('PrecinctName','Registered','ContestName','CandidateName','CandidateAffiliation','Votes_EARLY VOTE','Votes_ELECTION DAY','Votes_PROVISIONAL') 
lst_race_snap_all_az_ma_2024 <- abc(fldv,racv,affv,vomv,sctv)
usethis::use_data(lst_race_snap_all_az_ma_2024, overwrite = TRUE)
openxlsx::write.xlsx(lst_race_snap_all_az_ma_2024,paste0(rprojroot::find_rstudio_root_file(),'/data-raw/arizona/2024/xlsx/maricopa_beneral_2024.xlsx'))
bms()
abc[[1,1]]
abc[[2,1]]
abc[[1,2]]
abc[[2,2]]
abc[[1,3]]
abc[[2,3]]






