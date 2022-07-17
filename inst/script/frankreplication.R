library(ggplot2)
library(dplyr)
library(gridExtra)
#' @export Voterrollanalysis
Voterrollanalysis <- setRefClass("Voterrollanalysis", fields=list(voterroll='data.frame', 
								  listscard='list', 
								  polyscard='list',
								  polypredi='list', 
								  polcou='list',  
								  lg_pred='list',  
								  lg_hist='list',  
								  lg_keyr='list', 
								  rotp='character'
								  ))
Voterrollanalysis$methods(initialize=function(coudatafile='vtr_ohio.rda', 
					      polyo=c(1,2,6,8)){
  rotp <<- rprojroot::find_rstudio_root_file()
  vfile <- paste0(rotp,'/data/',coudatafile)
  load(vfile)
  voterroll <<- as.data.frame(vtr_ohio) 
  polcou[[1]] <<- polyo
  polcou[[2]] <<- unique(voterroll$cou_nr)
})
Voterrollanalysis$methods(scorecard=function(polyo=c(1,2,6,8)){

  polyo <- polcou[[1]] 
  #polyov <<- polyo
  vr <- voterroll
  nrco <- unique(voterroll$cou_nr)
    lapply(nrco,function(x){
      lapply(1:length(polyo),function(y){
        dft <- dplyr::filter(voterroll,cou_nr==x)
        ft <- paste0("dft$re_key_ratio~poly(dft$age,",polyo[y],",raw=T)")
        lm(as.formula(ft))
      })
    }) ->> listscard
    polyscard <<- lapply(1:4, function(x) sapply(1:length(nrco), function(y) unname(listscard[[y]][[x]]$coeff)))	
})
Voterrollanalysis$methods(predictinput=function(arg1=NULL){

  polypredi <<- lapply(1:length(polcou[[1]]), function(x){
    avg_key_poly <- t(polyscard[[x]]) %>% base::colMeans() %>% polynom::polynomial()
    vr <- voterroll %>%
    dplyr::group_by(cou_nr) %>%
    dplyr::mutate(avg_key_ratio=stats::predict(avg_key_poly,age)) %>%
    dplyr::mutate(ag_vpred=ag_regis*tur_ratio*avg_key_ratio) %>%
    dplyr::mutate(pred_error=ag_voted-ag_vpred) %>%
    dplyr::mutate(corr=cor(ag_voted,ag_vpred)) %>%
    dplyr::ungroup() 
  }) 
})
Voterrollanalysis$methods(plot_predict=function(plotyvar=c('ag_geovo','ag_voted','ag_regis','ag_vpred'), lp=list(x='Age category',y='Number of voters') 
){
  for (po in 1:length(polcou[[1]])){
    lg_pred[[po]] <<- lapply(polcou[[2]], function(x){
      dfg <- polypredi[[po]] %>% dplyr::filter(cou_nr==x) %>% tidyr::pivot_longer(all_of(plotyvar)) 
      ctitle <- paste0('County ',dfg$cou_nr[x])
      captionp <- paste0('correlation (r)= ',round(unique(dfg$corr), digits=5))
      lp <- ggplot2::ggplot(data=dfg , aes(x=age,y=value,color=name)) + geom_line() + 
      ggplot2::labs(title=ctitle,x=lp$x,y=lp$y,caption =captionp) +
      ggplot2::theme_bw()})
  }
})
Voterrollanalysis$methods(plot_keyrat=function(
  plotyvar=list(li='avg_key_ratio',po=c('go_key_ratio','re_key_ratio','avg_key_ratio','tur_ratio')
  )){
  for (po in 1:length(polcou[[1]])){
    lg_keyr[[po]] <<- lapply(polcou[[2]], function(x){
      dfg <- polypredi[[po]] %>% 
	      dplyr::filter(cou_nr==x) %>% 
	      tidyr::pivot_longer(all_of(c(plotyvar$li,plotyvar$po)))
      ggplot2::ggplot(data=dfg, aes(x=age,y=value, color=name)) + geom_point() + 
      scale_y_continuous(limits=c(0, 2)) + theme_bw()
    })
  }				  
})
Voterrollanalysis$methods(plot_histio=function(plotyvar=c('pred_error')){
for (po in 1:length(polcou[[1]])){
  lg_hist[[po]] <<- lapply(polcou[[2]], function(x){
    dfg <- polypredi[[po]] %>% dplyr::filter(cou_nr==x) %>% tidyr::pivot_longer(all_of(plotyvar))
    ctitle <- paste0('County ',dfg$cou_nr[x])
    ggplot2::ggplot(data=dfg) + geom_histogram(aes(x=value)) + 
	    ggplot2::labs(title = ctitle) + theme_bw()
})
}				  
})
Voterrollanalysis$methods(gridarrange=function(arg1=NULL){
browser()
dfg <- voterroll %>% dplyr::filter(cou_nr==3)
nmlc <- unique(voterroll$cou_na)
for (lc in 1:3){
lc <- 3
nmlcl <- nmlc[lc]
gr1 <- lg_keyr[[3]][[lc]] 
gr2 <- lg_pred[[3]][[lc]] 
gr3 <- lg_hist[[3]][[lc]] 
# Test
#grid.arrange(gr1, gr2, gr3, ncol=3)
# True save
ag <- gridExtra::arrangeGrob(grobs=gr1)
plotname <- paste0(substr(nmlcl,1,nchar(nmlcl)),".png")
plotfile <- paste0(rotp,'/inst/script/pngs/',plotname)
ggsave(file=plotfile,ag)
#list(plot=g)
}
})
ohio_vr <- Voterrollanalysis()
ohio_vr$scorecard()
ohio_vr$predictinput()
ohio_vr$plot_predict()
#ohio_vr$lg_pred[[3]][[1]]
ohio_vr$plot_keyrat()
#ohio_vr$lg_keyr[[3]][[1]]
ohio_vr$plot_histio()
#ohio_vr$lg_hist
ohio_vr$gridarrange()

