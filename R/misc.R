#sympyupd <- function(){
#	abs_path <- function(){rprojroot::find_rstudio_root_file()}
#	fdm <- paste0(abs_path(),'/inst/script/symbolic/pysympy.py')
#	reticulate::source_python(fdm)
#	eqpar <- list(meql=reticulate::py$modeql,meqs=reticulate::py$modeqs)
#	usethis::use_data(eqpar, overwrite = TRUE)
#}
#
## Saving data
##' @export
#abs_path <- function(){rprojroot::find_rstudio_root_file()}
#
##' @export
#bm <- function(){
#   early <- getwd()
#   middle <- rprojroot::find_rstudio_root_file()
#   setwd(middle)
#   middle <- setwd(rprojroot::find_rstudio_root_file())
#   setwd(middle)
#   getwd()
#   system('R CMD build .; R CMD INSTALL ManifoldDestiny_0.0.0.9000.tar.gz; rm -r ManifoldDestiny_0.0.0.9000.tar.gz')
#   setwd(early)
#}
#
##' @export
#rp <- function(){
#	reticulate::repl_python()
#}
##' @export
#k <- function(){
#    df <-  clipr::write_last_clip()
#}
##' @export
#l <- function(){
#    open_command <- switch(Sys.info()[['sysname']],
#                           Windows= 'open',
#                           Linux  = 'xdg-open',
#                           Darwin = 'open')
#
#    #temp_file <- paste0('tmp/abc', '.xlsx')
#    temp_file <- paste0(tempfile(), '.xlsx')
#    df <-  clipr::write_last_clip()
#    openxlsx::write.xlsx(df, file = temp_file)
#    invisible(system(paste(open_command, temp_file),
#                     ignore.stdout = TRUE, ignore.stderr = TRUE))
#}
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
##' @export
#allvectors <- function(dfc=NULL){
#
#  #𝓧	𝓨 	𝓐,1	 𝓛,1	𝓩,1
#  vec_df_1 <- dfc %>% dplyr::mutate(x=ratio(n=a,d=a+b),y=ratio(n=c,d=c+d),alpha=ratio(n=a+c,d=(a+b+c+d)),Lambda=ratio(n=a+d,d=a+b+c+d),zeta=ratio(n=c+d,d=a+b))
#
#  #𝓖,1	𝓗,1 dfc %>%   𝓐,1	Ω,1	Γ,1
#  vec_df_2 <- dfc %>%  dplyr::mutate(g=ratio(n=a,d=a+d),h=ratio(n=c,d=c+b),alpha=ratio(n=a+c,d=(a+b+c+d)),Omega=ratio(n=a+b,d=a+b+c+d),Gamma=ratio(n=b+c,d=a+d))
#
#  #𝓜,1	𝓝,1   dfc %>%   Ω,1	 𝓛,1	ξ,1	1/Arb
#  vec_df_3 <- dfc %>% dplyr::mutate(m=ratio(n=a,d=a+c),n=ratio(n=b,d=b+d),Omega=ratio(n=a+b,d=a+b+c+d),Lambda=ratio(n=a+d,d=a+b+c+d),epsilon=ratio(n=b+d,d=a+c)) %>% dplyr::mutate(inv_arb=1/epsilon)
#
#  vec_list <- list(vec_df_1,vec_df_2,vec_df_3)
#}
#
##' @export
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
#
## Two modes
### Standard form
##' @export
#y_stdform <- function(parsurf='(alpha-k*x-h)/(1-k*x)',alpha=0.50,x=0.60,k=0.01,h=-0.0282354516396){
#	eval(parse(text=parsurf),c(list(alpha=alpha,x=x),list(k=k,h=h)))
#}
### Hybrid form
#
#
### Opposition form
#
##' @export
#df_stdform <- function(vecone_df=vecone){
#
#	test <- vecone_df %>% dplyr::mutate(y_est=y_stdform(alpha=alpha,x=x)) %>% dplyr::mutate(resM=y-y_est)
#}
#
#
