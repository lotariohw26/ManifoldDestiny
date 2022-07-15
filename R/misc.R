##' @export sympyupd
sympyupd <- function(){
	abs_path <- rprojroot::find_rstudio_root_file()
	fdm <- paste0(abs_path,'/inst/script/symbolic/pysympy.py')
	reticulate::source_python(fdm)
	eqpar <- list(meql=reticulate::py$modeql,meqs=reticulate::py$modeqs)
	usethis::use_data(eqpar, overwrite = TRUE)
}
##' @export bm
bm <- function(){
   early <- getwd()
   middle <- rprojroot::find_rstudio_root_file()
   setwd(middle)
   middle <- setwd(rprojroot::find_rstudio_root_file())
   setwd(middle)
   getwd()
   system('R CMD build .; R CMD INSTALL ManifoldDestiny_0.0.0.9000.tar.gz; rm -r ManifoldDestiny_0.0.0.9000.tar.gz')
   setwd(early)
}
#' @export
k <- function(){
    df <-  clipr::write_last_clip()
}
#' @export
l <- function(){
    open_command <- switch(Sys.info()[['sysname']],
                           Windows= 'open',
                           Linux  = 'xdg-open',
                           Darwin = 'open')

    #temp_file <- paste0('tmp/abc', '.xlsx')
    temp_file <- paste0(tempfile(), '.xlsx')
    df <-  clipr::write_last_clip()
    openxlsx::write.xlsx(df, file = temp_file)
    invisible(system(paste(open_command, temp_file),
                     ignore.stdout = TRUE, ignore.stderr = TRUE))
}
# Saving data
#' @export
abs_path <- function(){rprojroot::find_rstudio_root_file()}
#v <- function(){
#    open_command <- switch(Sys.info()[['sysname']],
#                           Windows= 'open',
#                           Linux  = 'xdg-open',
#                           Darwin = 'open')
#
#    #temp_file <- paste0('tmp/abc', '.xlsx')
#    temp_file <- paste0(tempfile(), '.xlsx')
#    df <-  clipr::write_last_clip()
#    View(df)
#}
#
##' @export
#magic <- function(zeta=1,lambda=0.4,x=seq(0,1,by=0.01),select=c('t1','b1','rl','t2','b2','a2','ab')){
#
#  # evaluation
#  t1 <- eval(parse(text='x'),list(x=x)) # Predetermined
#  b1 <- eval(parse(text='1-x'),list(x=x))  # Predetermined
#  rl <- eval(parse(text='lambda'),c(list(lambda=lambda),list(x=x))) # Enforced form hybrid
#  t2 <- rl-(b1-rl)/zeta # Combination
#  b2 <- 1-t2
#  at <- (t1+t2*zeta)/(zeta+1)
#  ab <- (b1+b2*zeta)/(zeta+1)
#
#  # Plot
#  df <- data.frame(x,t1,b1,rl,t2,b2,at,ab)
#  dfs <- df %>% tidyr::pivot_longer(c(t1,b1,rl,t2,b2,at,ab)) %>% subset(name%in%select)
#  plot <- ggplot2::ggplot(data=dfs,ggplot2::aes(x=x,y=value,color=name)) + ggplot2::geom_point() + ggplot2::geom_line() + theme_classic()
#  ## output
#  list(df=df,dfv=df[],plot=plot)
#}
#
##' @export
#magic2 <- function(zeta=seq(0.2,2,0.01),lambda=0.3,alpha_b=0.55,selectv=NA){
#
#  # evaluation
#  gpn <- eval(parse(text='(lambda*(1+zeta)+zeta-alpha_b*(1+zeta))/(2*zeta)'),
#	      c(list(lambda=lambda,alpha_b=alpha_b),list(zeta=zeta)))
#  gp <- 1- gpn
#  fp <- lambda*(zeta+1) - zeta*gpn
#  fpn <- 1- fp
#  alpha_a <- 1-alpha_b
#  df <- data.frame(gpn,gp,fp,fpn,alpha_b,zeta,lambda,alpha_a)
#  dfs <- df %>% tidyr::pivot_longer(c(gpn,gp,fp,fpn,alpha_a,lambda,alpha_b))## %>% dplyr::select(ifelse(select==NA,everything(),select))
#  plot <- ggplot(data=dfs,aes(x=zeta,y=value,color=name)) + geom_point() + geom_line() + theme_classic()
#  list(df=df,dfv=df[],plot=plot)
#}
#
##' conditinal ratio function
##' @export
#ratio <- function(n=NULL,d=null){
#	rat <- ifelse(d==0,0.5,n/d)
#}
#
#aggordered <- function(dfc=NULL,polynr=6,arrangevar='x'){
#
#    names(dfc) <- c("pre","a","b","c","d","x","y","alpha","Lambda","zeta")
#    dgpsummed <- dfc %>% dplyr::arrange(arrangevar) %>%
#    dplyr::mutate(pre_ind=dplyr::row_number(alpha)/length(alpha)) %>%
#    dplyr::mutate(pred1=predict(lm(alpha ~ poly(pre_ind,polynr, raw=T), data=.))) %>%
#    dplyr::mutate(pred2=predict(lm(x ~ poly(pre_ind,polynr, raw=T), data=.))) %>%
#    dplyr::mutate(pred3=predict(lm(y ~ poly(pre_ind,polynr, raw=T), data=.))) %>%
#    #  Creating new variables
#    #dplyr::select(-model1,-model2,-model3) %>%
#    # Residuals
#    dplyr::mutate(res_x=x-pred1) %>%
#    dplyr::mutate(res_y=y-pred2) %>%
#    dplyr::mutate(res_alpha=alpha-pred3) %>%
#    dplyr::mutate(res_zeta=zeta-mean(zeta)) %>%
#    # Crossres
#    dplyr::mutate(crossres_x=res_zeta*res_x) %>%
#    dplyr::mutate(crossres_y=res_zeta*res_y) %>%
#    dplyr::mutate(crossres_alpha=res_zeta*res_alpha) %>%
#    tidyr::pivot_longer(c(x,y,alpha,pred1,pred2,pred3))
#}

