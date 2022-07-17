library(ggplot2)
library(dplyr)
#' @export Voterrollanalysis
Voterrollanalysis <- setRefClass("Voterrollanalysis", fields=list(voterroll='data.frame', 
								  listscard='list', 
								  polyscard='list',
								  polypredi='list', 
								  polyov='vector' 
								  ))
Voterrollanalysis$methods(initialize=function(coudatafile='vtr_ohio.rda'){
  rotp <- rprojroot::find_rstudio_root_file()
  vfile <- paste0(rotp,'/data/',coudatafile)
  load("~/research/ManifoldDestiny/data/vtr_ohio.rda")
  #¡
  voterroll <<- as.data.frame(vtr_ohio) 
})
Voterrollanalysis$methods(scorecard=function(polyo=c(1,2,6,8)){

  polyov <<- polyo
  vr <- voterroll
  nrco <- unique(voterroll$cou_nr)
    lapply(nrco,function(x){
      lapply(1:length(polyo),function(y){
        dft <- dplyr::filter(voterroll,cou_nr==x)
        ft <- paste0("dft$key_ratio~poly(dft$age,",polyo[y],",raw=T)")
        lm(as.formula(ft))
      })
    }) ->> listscard
    polyscard <<- lapply(1:4, function(x) sapply(1:length(nrco), function(y) unname(listscard[[y]][[x]]$coeff)))	
})
Voterrollanalysis$methods(predictinput=function(arg1=NULL){

  polypredi <<- lapply(1:length(polyov), function(x){
    avg_key_poly <- t(polyscard[[x]]) %>% base::colMeans() %>% polynom::polynomial()
    vr <- voterroll %>%
    dplyr::group_by(cou_nr) %>%
    dplyr::mutate(avg_key_ratio=stats::predict(avg_key_poly,age)) %>%
    dplyr::mutate(ag_vpred=ag_regis*tur_ratio*avg_key_ratio) %>%
    dplyr::mutate(prederror=ag_voted-ag_vpred) %>%
    dplyr::mutate(corr=cor(ag_voted,ag_vpred)) %>%
    dplyr::ungroup() 
  }) 
})
Voterrollanalysis$methods(predictplots=function(arg1=NULL){})
Voterrollanalysis$methods(gridarrange=function(arg1=NULL){})
ohio_vr <- Voterrollanalysis()
ohio_vr$scorecard()
ohio_vr$predictinput()
ohio_vr$polypredi[[4]]
ohio_vr$predictplots()
ohio_vr$gridarrange()




#  plotvage <- c('ag_geovo','ag_voted','ag_regis','ag_vpred')
#  keys <- c('key_ratio','avg_key_ratio')

#round(unique(polypredi[[1]]$corr),4)
    
    #    #tidyr::pivot_longer(keys) 
#    tidyr::pivot_longer(plotvage) 
#dfg <- polypredi[[1]] %>% dplyr::filter(cou_nr==3)
#ggplot2::ggplot(data=dfg , aes(x=age,y=value,color=name)) + geom_line() 



  
#    dplyr::mutate(ballpred=registered*turnratio*avgpredkeyratio) %>%

#  cou_data_trans <- foudatatidy(county) %>% tidyr::drop_na() %>% dplyr::select(county,age,keyratio,geovoter,voting,registered,turnratio)
#  
# dfinputreport <- scorecard %>%
#    purrr::map_df(function(x) as.data.frame(left_join(x,cou_data_trans,by='age'))) %>%
#    dplyr::group_by(polinc) %>%
#    tidyr::drop_na() %>%
#    dplyr::mutate(ballpred=registered*turnratio*avgpredkeyratio) %>%
#    dplyr::mutate(prederror=voting-ballpred) %>%
#    dplyr::mutate(corr=cor(ballpred,voting)) %>%
#    tidyr::nest() %>%
#    tidyr::unnest(data) %>%
#    dplyr::ungroup() %>%
#    tidyr::pivot_longer(c(avgpredkeyratio,keyratio,prederror,ballpred,geovoter,voting,registered)) %>%
#    split(.$polinc)
countyplot <- function(county=1,scorecard=NULL,dfinput=NULL){
#
#  df <- dfinputreport(county,scorecard)
#  cou_name <-unique(df[[1]]$county)
#  ck <- df %>% purrr::map(function(x) dplyr::filter(x,name%in%c('avgpredkeyratio')) %>% keyplot())
#  cp <- df %>% purrr::map(function(x) dplyr::filter(x,name%in%c('geovoter','registered','voting','ballpred')) %>% votplot())
#  ce <- df %>% purrr::map(function(x) dplyr::filter(x,name%in%c('prederror')) %>% histerrpred())
#  g <- gridExtra::marrangeGrob(append(append(ck,cp),ce),nrow=length(scorecard),ncol=3,top=cou_name)
#  plotname <- paste0(substr(cou_name,1,nchar(cou_name)-4),".png")
#  plotfile <- paste0("pngs/",plotname)
#  ggsave(file=plotfile,g)
#  list(plot=g)
#}
#

Voterrollanalysis$methods(teste=function(arg1=NULL){
})
names(ohio_vr$voterroll)
head(ohio_vr$voterroll)
dft <- dplyr::filter(ohio_vr$voterroll,cou_nr==3)
names(dft)
palette <- c("Registered voters","Ballot votes","Predicted votes")
ggplot2::ggplot(data=dft) +
  geom_line(aes(x=age,y=ag_regis,color=palette[1])) +
  geom_line(aes(x=age,y=ag_voted,color=palette[2])) +
  #geom_line(aes(x=age,y=ag_regra,color=palette[3])) +
  labs(caption='test') +
  ggplot2::xlab('xlab') +
  ggplot2::ylab('ylab')+
  theme_classic()
ggplot2::ggplot(data=df,aes(x=df$age,y=df$key_ratio))+geom_point()
