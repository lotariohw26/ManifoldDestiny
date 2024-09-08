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
  mutate(R = ifelse("R" %in% names(.), R, S+T+U+V))                                                            
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

