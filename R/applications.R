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
