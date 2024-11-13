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
	setNames(list(snax),rac[con]) 
    }) -> lst_rac
       #setNames(lst_rac,per) 
  }) -> lst_rac_snp  
}
abc <- abc()
bs1 <- rbind(abc[["US Senate",1]],abc[["US Senate",2]],abc[["US Senate",3]])
bp1 <- rbind(abc[["Presidential Electors",1]],abc[["Presidential Electors",2]],abc[["Presidential Electors",3]])
abcl <- list(bs1,bp1)
openxlsx::write.xlsx(abcl,paste0(rprojroot::find_rstudio_root_file(),'/data-raw/arizona/2024/xlsx/maricopa_beneral_2024.xlsx'))
usethis::use_data(abcl, overwrite = TRUE)




lst_race_snap_all_az_ma <- sapply(seq(1,nr),function(x){setNames(list(data.table::rbindlist(lst_race_snap[seq(x,np*nr,nr)],F)),lr[x,1])})


fldv="/data-raw/arizona/2024/" 
racv=c("Presidential Electors","US Senate") 
affv=c("DEM","REP") 
vomv=c('Votes_PROVISIONAL','Votes_ELECTION DAY','Votes_EARLY VOTE') 
sctv=c('PrecinctName','Registered','ContestName','CandidateName','CandidateAffiliation','Votes_EARLY VOTE','Votes_ELECTION DAY','Votes_PROVISIONAL') 
abc0 <- abc(fldv,racv,affv,vomv,sctv)

lpabc <- list(abc0[[1,1]],abc0[[1,2]],abc0[[1,3]])
lsabc <- list(abc0[[1,1]],abc0[[1,2]],abc0[[1,3]])
dpfbl <- do.call(rbind, lpabc) 
dsfbl <- do.call(rbind, lsabc) 
lall <- list(dpfbl,dsfbl)
openxlsx::write.xlsx(lall,paste0(rprojroot::find_rstudio_root_file(),'/data-raw/arizona/2024/xlsx/maricopa_beneral_2024.xlsx'))
usethis::use_data(lall, overwrite = TRUE)
#abc[[1,1]]
#abc[[1,2]]
#abc[[1,3]]
#abc[[2,1]]
#abc[[2,2]]
#abc[[2,3]]
#bms()




################################################################################################################
# General script for Maricopa
###############################################################################################################
# setNames
abs_p <- rprojroot::find_rstudio_root_file()
system(paste0('ls ',rprojroot::find_rstudio_root_file(),"/data-raw/arizona/2022/maricopa/txt_proto"))
lp <- system(paste0('ls ',dirtxt),intern=T)[c(2:12,1)]
fn <- paste0(abs_p,'/data-raw/arizona/2022/maricopa/txt/',lp)[c(2:14,1)]
r <- data.table::fread(paste0(abs_p,'/data-raw/arizona/2022/maricopa/maricopadfload.csv'))[1:5,] %>% mutate(across(everything(), gsub, pattern = "'", replacement = '"'))
nr <- dim(lr)[1]
np <- length(lp)
sct <- c('PrecinctName','Registered','CandidateName','CandidateAffiliation','Votes_EARLY VOTE','Votes_ELECTION DAY'

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
    dplyrugroup() %>%
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
az_co_gen_2022 <- data.table::fread(paste0(rprojroot::find_rstudio_root_file(),'/data-raw/arizona/2022/cohise/csv/abc.csv'),header=FALSE) %>% dplyr::slice(-n())
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
###############################################################################################################

