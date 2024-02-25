#' @export py_polysolver
py_polysolver <- function(degree=1,abcde=NULL){
  path_fqs <- paste0(rprojroot::find_rstudio_root_file(),"/script/python")
  #path_fqs <- system.file("script/python",package = "ManifoldDestiny")
  fqs <- reticulate::import_from_path("fqs", path =path_fqs)
  np <- reticulate::import("numpy")
  vec <- abcde[!is.na(abcde)] 
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
#' @export py_genpolycoeff 
py_genpolycoeff <- function(expr=NULL,solvd=NULL,solvf=NULL,eur=c(0, 0, 0)){
  #reticulate::source_python(system.file("script/sympy/polysolver.py",package = "ManifoldDestiny"))
  reticulate::source_python(paste0(rprojroot::find_rstudio_root_file(),"/script/python/polysolver.py"))
  reticulate::py$genpolycoeff(expr=expr,solvd=solvd,solvf=solvf,eur=as.integer(eur))
}
#py_genpolycoeff(expr='k0+k1*x+k2*y', solvd='alpha', solvf='y', eur=c(0, 0, 0))[1]
#py_genpolycoeff(expr='k0+k1*x+k2*y', solvd='z', solvf='u0', eur=[1, 4, 2], plr=3)[1]
#####################################################################################################
#py_genpolycoeff(expr=NULL,solvd='z',solvf='u0',eur=c(1, 1, 1))
#py_polysolver() 
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

#' @export recoudatr
recoudatr <- function(mda=NULL){
  gsh <- googlesheets4::read_sheet(mda$sht$url,sheet=mda$sht$pgn,range=mda$sht$rng) %>%
    data.table::setnames(new=mda$sht$cln) %>%
    dplyr::select(-starts_with('D')) %>%
    dplyr::mutate(P=row_number(PN)) %>%
    dplyr::mutate(R=row_number(RN)) %>%
    dplyr::mutate(S=!!rlang::parse_expr(mda$sht$stuv[1])) %>%
    dplyr::mutate(T=!!rlang::parse_expr(mda$sht$stuv[2])) %>%
    dplyr::mutate(U=!!rlang::parse_expr(mda$sht$stuv[3])) %>%
    dplyr::mutate(V=!!rlang::parse_expr(mda$sht$stuv[4]))
  assign(mda$nid,gsh)
  do.call("use_data", list(as.name(mda$nid), overwrite = TRUE))
  return(gsh)
}
#####################################################################################################
#py_genpolycoeff(expr='k0+k1*x+k2*y', solvd='alpha', solvf='y', eur=c(0, 0, 0))
#py_genpolycoeff(expr='k0+k1*x+k2*y', solvd='z', solvf='u0', eur=c(1, 4, 2))





