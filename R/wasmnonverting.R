#' @export recoudatr
recoudatr <- function(mda=NULL,prn=1){
  gsh <- googlesheets4::read_sheet(mda$spr$url,sheet=mda$spr$pgn,range=mda$spr$rng) %>%
    dplyr::mutate(across(where(is.list), ~ as.character(.x))) %>%
    data.table::setnames(new=mda$spr$cln) %>%
    dplyr::mutate(P=row_number(PN)) %>%
    dplyr::mutate(
        S = !!rlang::parse_expr(mda$spr$stuv[1]),
        T = !!rlang::parse_expr(mda$spr$stuv[2]),
        U = !!rlang::parse_expr(mda$spr$stuv[3]),
        V = !!rlang::parse_expr(mda$spr$stuv[4])
      ) %>%
 { if ("R" %in% .[]) . else mutate(., R = S + T + U + V)}  
  assign(mda$nid,list(as.data.frame(gsh),mda))
  do.call("use_data", list(as.name(mda$nid), overwrite = TRUE))
  return(mda$nid)
}

recousiml <- function(mda=NULL,prn=1){

}

#' @export py_polysolver
py_polysolver <- function(abcde=NULL){
  #degree
  path_fqs <- paste0(rprojroot::find_rstudio_root_file(),"/script/python")
  #path_fqs <- system.file("script/python",package = "ManifoldDestiny")
  reticulate::import("numba")
  fqs <- reticulate::import_from_path("fqs", path =path_fqs)
  np <- reticulate::import("numpy")
  vec <- abcde[!is.na(abcde)] 
  degree <- length(abcde)-1
  #browser()
  if (degree==1) {
    #Re(AlgebraicHaploPackage::cubic(A=vec[1],B=vec[2],C=0,D=0))[1]
    retv <- np$roots(vec)[1]
  }
  if (degree==2) {
    retv <- np$roots(vec)[1]
  }
  if (degree==3) {
    retv <- fqs$cubic_roots(vec)[1]
  }
  if (degree==4) {
    retv <- fqs$quartic_roots(vec)[1]
  }
  retv
}

#' @export py_genpolycoeffn
py_genpolycoeffn <- function(form=NULL,expr=NULL,solv=NULL){
  reticulate::source_python(paste0(rprojroot::find_rstudio_root_file(),"/script/python/polysolver.py"))
  reticulate::py$genpolycoeffn(as.integer(form),expr,solv)
}

#' @export py_genpolycoeffr
py_genpolycoeffr <- function(fm=NULL,ex=NULL,so=NULL,eu=NULL){
  reticulate::source_python(paste0(rprojroot::find_rstudio_root_file(),"/script/python/polysolver.py"))
  reticulate::py$genpolycoeffr(fm,ex,so,eur=as.integer(eu))
}

#
##' @export bm
bm <- function(){
   devtools::document()
   system(paste0('cd ',rprojroot::find_rstudio_root_file(),'; R CMD INSTALL --preclean --no-multiarch --with-keep.source .'))
}


#' @export k
k <- function(){
    df <-  clipr::write_last_clip()
}

#' @export l
l <- function(){
    open_command <- switch(Sys.info()[['sysname']],
                           Windows= 'open',
                           Linux  = 'xdg-open',
                           Darwin = 'open')

    temp_file <- paste0(tempfile(), '.xlsx')
    df <-  clipr::write_last_clip()
    openxlsx::write.xlsx(df, file = temp_file)
    invisible(system(paste(open_command, temp_file),
                     ignore.stdout = TRUE, ignore.stderr = TRUE))
}

#' @export gop
gop <- function(ma="lotariohw26@gmail.com",df=iris){
	googlesheets4::gs4_auth(email=ma)
	abc <- googlesheets4::gs4_create("abc",sheets =df)
	googlesheets4::gs4_browser(abc)
}

#' @export gre
gre <- function(ma="lotariohw26@gmail.com",url=url,sheet=sheet,range=range){
	googlesheets4::gs4_auth(email=ma)
	gsh <- googlesheets4::read_sheet(url,sheet=sheet,range=range) 
}

#' @export dyntabulation
dyntabulation <- function(fld="/data-raw/arizona/2024/",
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
                dplyr::mutate(SNAP=per,.before = 1) %>%
                dplyr::mutate(TIME=lsf[per],.before = 1) 
	setNames(list(snax),rac[con]) 
    }) -> lst_rac
  }) -> lst_rac_snp  
  stodfl <- setNames(lapply(1:length(rac), function(i) do.call(rbind, lst_rac_snp[1, ])), rac)
}

