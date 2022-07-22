#' @export totwomodes
totwomodes <- function(A=NULL,B=NULL,C=NULL,D=NULL,dfi=NULL){
  ou <- dfi %>% 
    dplyr::mutate(a=eval(parse(text=A))) %>% 
    dplyr::mutate(b=eval(parse(text=B))) %>%
    dplyr::mutate(c=eval(parse(text=C))) %>%
    dplyr::mutate(d=eval(parse(text=D))) 
}
###########################################################################################################################################################
############################################################################################################################################################
#' A class description
#' @export Estimation
Estimation <- setRefClass("Estimation", fields=list(
						sdfc='data.frame', 
						regsum='list', 
						resplots='list'
						))
Estimation$methods(initialize=function(rdfcinp=NULL){
  sdfc <<- rdfcinp
})
Estimation$methods(regression=function(regform=NULL){

  man_model <- lm(as.formula(regform),data=sdfc)
  regsum <<- list(lm=man_model, 
		  summary(man_model),
		  tidy=broom::tidy(man_model), 
		  glance=broom::glance(man_model), 
		  augment=broom::augment(man_model))
})
Estimation$methods(polyest=function(regform=NULL){
browser()
kvec <- c(0.03669833672, 0.7650526952, -0.8295197129, 0.9938639181, 0.3074660656, 0.9281349898, -1.04633696, -0.1798626564)

#kvecr <- c(0.03011967441,0.8193824172,-0.9499398397,1.064030566,0.2314017714,1.006207413,-1.094817236,-0.1217901096)

pr_path <- rprojroot::find_rstudio_root_file()


fqs <- reticulate::import_from_path("fqs", path =path_fqs)
cubicres <- sdfc %P>% dplyr::select(P,g,h,alpha) %>%
	dplyr::arrange(P) %>%
	dplyr::mutate(A=kvec[6]) %>%
	dplyr::mutate(B=kvec[3]+h*kvec[7]) %>%
	dplyr::mutate(C=kvec[2]+h*kvec[4]) %>%
	dplyr::mutate(D=kvec[1]+kvec[5]*h^2+kvec[8]*h^3-alpha) %>%
	dplyr::group_by(P) %>%
	dplyr::mutate(cubic=fqs$cubic_roots(c(A,B,C,D))) %>%
	dplyr::mutate(g_exp=Re(cubic)[1])

cor(cubicres$g_exp,cubicres$g)
reg <- lm(g_exp ~ g, data =cubicres)
coeff=coefficients(reg)
# equation of the line : 
eq = paste0("y = ", round(coeff[2],1), "*x ", round(coeff[1],1))
plot(cubicres$g_exp,cubicres$g);abline(reg)

})


Estimation$methods(diagnostics=function(){

  model <- regsum[[1]]
  l1 <- ggplot(model, aes(x = model$residuals)) +
    geom_histogram(bins = 20, fill = 'steelblue', color = 'black') +
    labs(title = 'Histogram of Residuals', x = 'Residuals', y = 'Frequency')+ 
    theme_bw()
  l2 <- ggplot(model, aes(x = .fitted, y = .resid)) + geom_point() + theme_bw()
  resplots <<- list(hist=l1,res=l2)
})
Estimation$methods(rotation=function(
				     selvar=c('x','y','alpha'),
				     angles=list(tgrad=c(-41.771547,0,0)),
				     sli=list(depth=0.01,divi=0.02,shift=50,slide=-49)
				     ){
  #ra <- circular::rad(angles$tgrad)
  #rdfc <<- sdfc[1:741,] %>% dplyr::select(selvar) %>%
  #dplyr::mutate(rxy=ra[1]) %>%
  #dplyr::mutate(cosxy=cos(rxy)) %>%
  #dplyr::mutate(sinxy=sin(rxy)) %>%
  #dplyr::mutate(ryz=ra[2]) %>%
  #dplyr::mutate(cosyz=cos(ryz)) %>%
  #dplyr::mutate(sinyz=sin(ryz)) %>%
  #dplyr::mutate(rzx=ra[3]) %>%
  #dplyr::mutate(coszx=cos(rzx)) %>%
  #dplyr::mutate(sinzx=sin(rzx)) %>%
  #dplyr::mutate(u=cosxy*y-sinxy*x) %>%
  #dplyr::mutate(v=sinxy*y+cosxy*x) %>%
  #dplyr::mutate(w=sinyz*v+cosyz*alpha) %>%
  #dplyr::arrange(v)
  #rdfc; l()
  #plot(rdfc$u,rdfc$w)
  #dplyr::mutate(rank_v=dense_rank(v)) %>%
  #dplyr::mutate(slide=floor((v+sli$depth*sli$divi*sli$shift)/sli$depth)) %>%
  #dplyr::mutate(slide_norm=slide-sli$slide+1) %>%
  #dplyr::mutate(carry_slide_norm=1000*rank_v+slide_norm,
  #	      carry_v=1000*rank_v+v,
  #	      carry_u=1000*rank_v+u,
  #	      carry_w=1000*rank_v+w) %>%
  #dplyr::mutate(index=row_number()) %>%
  #dplyr::mutate(sort_slide_norm=sort(carry_slide_norm)) %>%
  #dplyr::mutate(sort_v=sort(carry_v),
  #              sort_u=sort(carry_u),
  #              sort_w=sort(carry_w)) %>%
  #dplyr::mutate(drop_s=sort_slide_norm-1000*index+sli$slide-1,
  #             drop_v=sort_v-1000*index,
  #             drop_u=sort_u-1000*index,
  #             drop_w=sort_w-1000*index) %>%
  #dplyr::mutate(fat_slide=ifelse(drop_s<=9,-1000,ifelse(drop_s>100,1000,drop_s)),
  #              partition_rank=rank(fat_slide),
  #              true_rank=rank(partition_rank))
  #View(rdfc)
})
Estimation$methods(restoration=function(){
			   'test'
})

