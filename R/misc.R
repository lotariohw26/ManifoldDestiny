#' @export
<<<<<<< HEAD
=======
sympupd <- function(){
	abs_path <- function(){rprojroot::find_rstudio_root_file()}
	fdm <- paste0(abs_path(),'/inst/script/symbolic/pysympy.py')
	reticulate::source_python(fdm)
	eqpar <- list(meql=reticulate::py$modeql,meqs=reticulate::py$modeqs)
	usethis::use_data(eqpar, overwrite = TRUE)
}
# Saving data

#' @export
>>>>>>> fc2a7d2f4659f2225a02c874c4f41a3e0b1ff15a
abs_path <- function(){rprojroot::find_rstudio_root_file()}

#' @export
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
rp <- function(){
	reticulate::repl_python()
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
v <- function(){
    open_command <- switch(Sys.info()[['sysname']],
                           Windows= 'open',
                           Linux  = 'xdg-open',
                           Darwin = 'open')

    #temp_file <- paste0('tmp/abc', '.xlsx')
    temp_file <- paste0(tempfile(), '.xlsx')
    df <-  clipr::write_last_clip()
    View(df)
}

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
