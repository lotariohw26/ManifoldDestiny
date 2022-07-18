#' @export Voterrollanalysis
Voterrollanalysis <- setRefClass("Voterrollanalysis", fields=list(voterroll='data.frame', 
								  listscard='list', 
								  polyscard1='list',
								  polyscard2='list',
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
        ft1 <- paste0("dft$go_key_ratio~poly(dft$age,",polyo[y],",raw=T)")
        ft2 <- paste0("dft$re_key_ratio~poly(dft$age,",polyo[y],",raw=T)")
        list(lm(as.formula(ft1)),lm(as.formula(ft2)))
      })
    }) ->> listscard
    polyscard1 <<- lapply(1:length(polyo), function(x) sapply(1:length(nrco), function(y) unname(listscard[[y]][[x]][[1]]$coeff)))	
    polyscard2 <<- lapply(1:length(polyo), function(x) sapply(1:length(nrco), function(y) unname(listscard[[y]][[x]][[1]]$coeff)))	
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

#' @export Voterrollgraphs
Voterrollgraphs <- setRefClass("Voterrollgraphs", contains = c('Voterrollanalysis'))
Voterrollgraphs$methods(plot_predict=function(plotyvar=c('ag_geovo','ag_voted','ag_regis','ag_vpred'), lp=list(x='Age category',y='Number of voters') 
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
Voterrollgraphs$methods(plot_keyrat=function(
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
Voterrollgraphs$methods(plot_histio=function(plotyvar=c('pred_error')){
for (po in 1:length(polcou[[1]])){
  lg_hist[[po]] <<- lapply(polcou[[2]], function(x){
    dfg <- polypredi[[po]] %>% dplyr::filter(cou_nr==x) %>% tidyr::pivot_longer(all_of(plotyvar))
    ctitle <- paste0('County ',dfg$cou_nr[x])
    ggplot2::ggplot(data=dfg) + geom_histogram(aes(x=value)) + 
	    ggplot2::labs(title = ctitle) + theme_bw()
})
}				  
})
Voterrollgraphs$methods(gridarrange=function(arg1=NULL){

  nmlc <- unique(voterroll$cou_na)
  for (lc in 1:length(nmlc)){
    nmlcl <- nmlc[lc]
    gr1 <- lg_keyr[[3]][[lc]] 
    gr2 <- lg_pred[[3]][[lc]] 
    gr3 <- lg_hist[[3]][[lc]] 
    #grid.arrange(gr1, gr2, gr3, ncol=3)
    ag <- gridExtra::arrangeGrob(grobs=list(gr1,gr2,gr3),ncol=1,top=nmlcl)
    plotname <- paste0(substr(nmlcl,1,nchar(nmlcl)),".png")
    plotfile <- paste0(rotp,'/inst/script/pngs/',plotname)
    ggsave(file=plotfile,ag)
    #list(plot=g)
  }
})

#' @export Voterrollreport
Voterrollreport <- setRefClass("Voterrollreport", contains = c('Voterrollanalysis'))
Voterrollreport$methods(htmlreport=function(reportn='Ohio'){
  report <- voterroll
  #rotp <- xtable::xtable(report)
  rotp <<-  rprojroot::find_rstudio_root_file()
  reportfile <- paste0(rotp,"/inst/script/reports/",reportn)
  print('saved')
  save(report,file=reportfile)
})

