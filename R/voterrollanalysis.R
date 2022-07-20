#' @export electiontechn
electiontechn <- function(probw=c(0.50,0.05), 
			  probv=list(c(0.60,0.30,0.10),
				     c(0.30,0.60,0.10)),
			  Ztech=c(0,1), 
			  nprect=20){	
#	browser()
  ### Election technology and voter sentiment
  ztech <- data.frame(prec_nr=seq(1,nprect)) %>% 
    dplyr::mutate(probwd=rnorm(nprect,probw[1],probw[2])) %>%
    dplyr::mutate(Zt=runif(n(), min=Ztech[1], max=Ztech[2])) %>%
    dplyr::mutate(p1=probv[[1]][1]) %>%
    dplyr::mutate(p2=probv[[1]][2]+probv[[1]][3]*Zt) %>%
    dplyr::mutate(p3=probv[[1]][3]*(1-Zt)) %>%
    dplyr::mutate(p4=probv[[2]][1]) %>%
    dplyr::mutate(p5=probv[[2]][2]+probv[[2]][3]*Zt) %>%
    dplyr::mutate(p6=probv[[2]][3]*(1-Zt))
}

### Election technology and voter sentiment
#' @export Voterdatabase
Voterdatabase <- setRefClass("Voterdatabase", fields=list(
							  listvbase='list')
)
Voterdatabase$methods(initialize=function(agebracketmax=c(18,100,30),
					  nprect=20,
					  tot_regis=0.80,
					  probw=c(0.50,0.05),
					  probv=list(c(0.60,0.30,0.10),
						     c(0.30,0.60,0.10)),
                                          Ztech=c(0,1),
                                          modes=c('EDV','MIV'), 
					  namebase='defvotbase',
					  newdraw=F
					  ){
	browser()

  ## Files
  rotp <- rprojroot::find_rstudio_root_file()
  vfile <- paste0(rotp,'/inst/script/voterbase/',namebase,'.rda')

  if(newdraw == T) {
  # Demograhpic structure
  agelength <- agebracketmax[2]-agebracketmax[1]
  brack <- seq(agebracketmax[1],agebracketmax[2])
  halflength <- agelength/2  #! should be changed
  earlpop <- matrix(1,agebracketmax[3],halflength)
  stlate <- halflength+1
  enlate <- length(brack)
  ## Making decreasing rate of voters belonging to older age groups
  latepop <- seq(stlate,enlate) %>% purrr::map_dfc(function(x,maxp=agebracketmax[3])
        	{
        		cf <-maxp/(enlate-stlate)
        		one <- floor(maxp-cf*(x-stlate))
        		zero <- maxp-one
  		matrix(c(rep(0,zero),rep(1,one)))
      		}) %>% as.matrix()
  colnames(latepop) <- NULL

  # Total Population
  totpop <- cbind(earlpop,latepop)
  agebrack <- agebracketmax
  
  # Desc statistics
  popvotgro <- colSums(totpop)           # Population for each age group
  popsize <- sum(popvotgro) 	           # Total number of citizien
  probage <- popvotgro/popsize 	   # Probability for each age group
  precv <- sample(nprect,size=popsize,T) # Allocated to various precincts (uniform?)

  # Registration
  rvot <- sample(seq(1,popsize),size=popsize*tot_regis,F) # Registered voters

  # Allocation
  precv <-sample(nprect,size=popsize,T) # Allocated to various precincts (uniform)

  # Realvoters
  #sci <- 500; hc <- floor(popsize/sci); resnr <- c(rep(sci,hc),popsize-sci*hc)
  #voterrolldatabase <- resnr %>% purrr::map_df(randNames::rand_names,nationality="US") %>%
  #dplyr::select(gender,name.first,name.last) %>%
  # Id-number for voters
  ztechdf <- electiontechn(probw,probv,Ztech,nprect)
  voterrolldatabase <- data.frame(idn=seq(1:popsize)) %>% 
    #!
    dplyr::mutate(county_nr=1) %>%
    dplyr::mutate(age=as.vector(wakefield::age(n(),x=seq(agebrack[1],agebrack[2]),prob=probage))) %>% 
    dplyr::mutate(prec_nr=sample(nprect,size=n(),replace=T)) %>% 
    dplyr::arrange(prec_nr) %>%
    dplyr::mutate(registered=ifelse(idn%in%rvot,1,0)) %>% 
    dplyr::left_join(ztechdf, by="prec_nr") 
    listvbase[[1]] <<- voterrolldatabase
    base::save(file=vfile,listvbase)
    #[1]"id""cou_nr""age""precinct_nr""registered"
    #"birthdate""general""primary""voted"          
  } 
  else {
    #listvbase <<- get(base::load(file=vfile))
    ztechdf <- electiontechn(probw,probv,Ztech,nprect)
    coudatafile='vtr_ohio.rda'    
    rotp <<- rprojroot::find_rstudio_root_file()
    vfile <- paste0(rotp,'/data/',coudatafile)
    voterrolldatabase <- data.frame(idn=seq(1:popsize)) 
    View(voterrolldatabase)
    load(vfile)
    voterroll <<- as.data.frame(vtr_ohio)
  }
})
Voterdatabase$methods(regvbase=function(arg1=NULL){
		
  listvbase[[2]] <<-
    vtr_abc <- 
    listvbase[[2]] %>% 
    dplyr::select(idn,age,voted,C,R) %>%
    dplyr::mutate(cou_nr=1) %>%
    dplyr::mutate(cou_na="abc") %>%
    dplyr::mutate(V=R-C) %>%
    dplyr::group_by(age) %>%
    dplyr::arrange(age) %>%
    dplyr::mutate(ag_geovo=n_distinct(idn)) %>% 
    dplyr::mutate(ag_voted=sum(V)) %>%
    dplyr::mutate(ag_regis=sum(R)) %>% 
    dplyr::mutate(ag_gevos=ag_voted/ag_geovo) %>% 
    dplyr::mutate(ag_revos=ag_voted/ag_regis) %>% 
    # Total
    dplyr::ungroup() %>%
    dplyr::select(cou_nr,cou_na,age,ag_geovo,ag_regis,ag_voted,ag_gevos,ag_revos) %>%
    dplyr::distinct() %>%
    dplyr::mutate(tot_geopo=sum(ag_geovo)) %>%
    dplyr::mutate(tot_voted=sum(ag_voted)) %>%
    dplyr::mutate(tot_regis=sum(ag_regis)) %>%
    ## relationship between age and county
    dplyr::mutate(geo_ratio=tot_voted/tot_geopo) %>%
    dplyr::mutate(tur_ratio=tot_voted/tot_regis) %>%
    dplyr::mutate(go_key_ratio=ag_gevos/geo_ratio) %>%
    dplyr::mutate(re_key_ratio=ag_revos/tur_ratio) 
    # Connected
    usethis::use_data(vtr_abc, overwrite = TRUE)
})
Voterdatabase$methods(uploadvbase=function(
				    truev=NULL, 
				    maniv=NULL, 
				    param=NULL 
				    ){
### Rreate diff 
mv <- dplyr::select(maniv,P,all_of(param)) 
colnames(mv)[-1]<- paste0(param,'_s')

vdiff <- truev %>% dplyr::left_join(mv,by='P') %>% 
  dplyr::mutate(Cp=C) %>%
  dplyr::mutate(T=V/R) %>%
  dplyr::mutate(diff_x=x_s-x) %>%
  dplyr::mutate(diff_y=y_s-y) %>%
  dplyr::mutate(diff_alpha=alpha_s-zeta) %>%
  dplyr::mutate(diff_a=0) %>%
  dplyr::mutate(diff_b=0) %>%
  dplyr::mutate(diff_c=ceiling(y_s*(c+d+Cp)-c)) %>%
  dplyr::mutate(diff_d=Cp-diff_c) 
  
vdiff_sel <- dplyr::select(vdiff,P,Cp,diff_c,diff_d)
base_sel  <- dplyr::select(listvbase[[2]],P,idn,age,P,R,C,a,b,c,d) %>% dplyr::mutate(Cu=0)

View(vdiff)
'break'

#View(vdiff)
# tvdf  <- dplyr::select(truevotdf,P,all_of(parameters))
# names(trvdf)[-1] <- paste0(names(trvdf)[-1],'_s')
#manipvotdf
#
# vdiff  <- merge(x=trvdf,y=select(manipvotdf,-pri),by="P",all.x=TRUE) %>%
# dplyr::mutate(Cp=C) %>%
# dplyr::mutate(T=V/R) %>%
# dplyr::mutate(diff_x=x_s-x) %>%
# dplyr::mutate(diff_y=y_s-y) %>%
# dplyr::mutate(diff_alpha=alpha_s-zeta) %>%
# dplyr::mutate(diff_a=0) %>%
# dplyr::mutate(diff_b=0) %>%
# dplyr::mutate(diff_c=ceiling(y_s*(c+d+Cp)-c)) %>%
# dplyr::mutate(diff_d=Cp-diff_c) 
# 
# vdiff_sel <- dplyr::select(vdiff,P,Cp,diff_c,diff_d)
# base_sel  <- dplyr::select(listvbase[[2]],P,idn,age,P,R,C,a,b,c,d) %>% dplyr::mutate(Cu=0)
# 
# listvbase[[3]] <<- base_sel %>% 
#         dplyr::arrange(P) %>% 
#         dplyr::left_join(vdiff_sel,by="P") %>%
#         base::split(.$P) %>%
#         purrr::map(function(x){
#           Cstock <- sum(x$C)
#           phantcan <- which(x$C==1)
#           drawphantom <- sample(x=phantcan,size=Cstock,replace=F)
#           x[drawphantom,'c'] <- 2
#           x
#         }) %>%
# dplyr::bind_rows(.) 
# listvbase[[4]] <<- vdiff_sel
# listvbase[[5]] <<- base_sel
#})

#Voterdatabase$methods(realizedgp=function(probv=list(c(0.60,0.30,0.10),
#						     c(0.30,0.60,0.10)),
#					  probw=c(0.50,0.05),
#                                          Ztech=c(0,1),
#                                          tvoting=c('EDV','MIV')){
#
#  nprect <- max(listvbase[[1]]$P)
#  ## Election Technology and voter sentiment
#  ztech <- data.frame(P=seq(1,nprect)) %>%
#	  dplyr::mutate(probwd=rnorm(nprect,probw[1],probw[2])) %>%
#	  dplyr::mutate(Zt=runif(n(), min=Ztech[1], max=Ztech[2])) %>%
#          dplyr::mutate(p1=probv[[1]][1]) %>%
#          dplyr::mutate(p2=probv[[1]][2]+probv[[1]][3]*Zt) %>%
#          dplyr::mutate(p3=probv[[1]][3]*(1-Zt)) %>%
#          dplyr::mutate(p4=probv[[2]][1]) %>%
#          dplyr::mutate(p5=probv[[2]][2]+probv[[2]][3]*Zt) %>%
#          dplyr::mutate(p6=probv[[2]][3]*(1-Zt))
#
#  ## Technology
#  listvbase[[2]] <<- listvbase[[1]] %>% dplyr::left_join(ztech, by="P") %>%
#	  base::split(.$P) %>%
#  purrr::map(function(x){
#  x %>%  dplyr::mutate(candraw=rbinom(n(),1,probwd)) %>%
#	 dplyr::mutate(voted=ifelse(candraw==1,
#      		      sample(1:3,size=n(),prob=c(x$p1[1],x$p2[1],x$p3[1]),T),
#      		      sample(4:6,size=n(),prob=c(x$p4[1],x$p5[1],x$p6[1]),T)))
#  }) %>%
#  dplyr::bind_rows(.) %>%
#  # Prior voting for which candidate and type of voting
#  dplyr::mutate(a=ifelse(voted==1&R==1,1,0)) %>%
#  dplyr::mutate(c=ifelse(voted==2&R==1,1,0)) %>%
#  dplyr::mutate(b=ifelse(voted==4&R==1,1,0)) %>%
#  dplyr::mutate(d=ifelse(voted==5&R==1,1,0)) %>%
#  # Condition for becoming a credit voter: Registered and not voting
#  dplyr::mutate(C=ifelse((voted==3|voted==6)&R==1,1,0)) 
#
#})
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

  callSuper(polypredi=polypredi,rotp=rotp)
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
    avg_key_poly1 <- t(polyscard1[[x]]) %>% base::colMeans() %>% polynom::polynomial()
    avg_key_poly2 <- t(polyscard2[[x]]) %>% base::colMeans() %>% polynom::polynomial()
    vr <- voterroll %>%
    dplyr::group_by(cou_nr) %>%
    ## Predicting average scorecard
    dplyr::mutate(polyo=polcou[[1]][x]) %>%
    dplyr::relocate(polyo) %>%
    dplyr::mutate(avg_key_ratio1=stats::predict(avg_key_poly1,age)) %>%
    dplyr::mutate(avg_key_ratio2=stats::predict(avg_key_poly2,age)) %>%
    dplyr::mutate(ag_vpred1=ag_geovo*geo_ratio*avg_key_ratio1) %>%
    dplyr::mutate(ag_vpred2=ag_regis*tur_ratio*avg_key_ratio2) %>%
    dplyr::mutate(pred_error1=ag_voted-ag_vpred1) %>%
    dplyr::mutate(pred_error2=ag_voted-ag_vpred2) %>%
    dplyr::mutate(corr1=cor(ag_voted,ag_vpred1)) %>%
    dplyr::mutate(corr2=cor(ag_voted,ag_vpred2)) %>%
    dplyr::ungroup()}) 
})


#' @export Voterrollgraphs
Voterrollgraphs <- setRefClass("Voterrollgraphs", contains = c('Voterrollanalysis'))
Voterrollgraphs$methods(plot_predict=function(plotyvar=c('ag_geovo','ag_voted','ag_regis','ag_vpred1','ag_vpred2'), lp=list(x='Age category',y='Number of voters') 
){

  for (po in 1:length(polcou[[1]])){
    lg_pred[[po]] <<- lapply(polcou[[2]], function(x){
      dfg <- polypredi[[po]] %>% dplyr::filter(cou_nr==x) %>% tidyr::pivot_longer(all_of(plotyvar)) 
      ctitle <- paste0('County: ',dfg$cou_na[x])
      cor1 <- round(unique(dfg$corr1), digits=5)
      cor2 <- round(unique(dfg$corr2), digits=5)
      captionp <- paste0('correlation 1 (r)=',cor1,' correlation 2 (r)=',cor2)
      lp <- ggplot2::ggplot() + 
	geom_line(data=dfg , aes(x=age,y=value,color=name)) + 
	ggplot2::labs(x=lp$x,y=lp$y) 
  })
}
})
Voterrollgraphs$methods(plot_keyrat=function(plotyvar=list(li=c('avg_key_ratio1','avg_key_ratio2'),po=c('go_key_ratio','re_key_ratio','avg_key_ratio1','avg_key_ratio2','tur_ratio'))){

  for (po in 1:length(polcou[[1]])){
    lg_keyr[[po]] <<- lapply(polcou[[2]], function(x){
      dfg <- polypredi[[po]] %>% dplyr::filter(cou_nr==x)  %>% 
	      tidyr::pivot_longer(all_of(c(plotyvar$li,plotyvar$po)))
      ctitle <- paste0('County:',dfg$cou_na[x])
      lp <- ggplot2::ggplot() + 
	      geom_line(data=dplyr::filter(dfg,name%in%plotyvar$li), aes(x=age,y=value, color=name)) + 
	      geom_point(data=dplyr::filter(dfg,name%in%plotyvar$po), aes(x=age,y=value, color=name)) + scale_y_continuous(limits=c(0, 2)) 
    })
  }				  
})
Voterrollgraphs$methods(plot_histio=function(plotyvar=c('pred_error1','pred_error2')){

 for (po in 1:length(polcou[[1]])){
   lg_hist[[po]] <<- lapply(polcou[[2]], function(x){
     dfg <- polypredi[[po]] %>% dplyr::filter(cou_nr==x) %>% tidyr::pivot_longer(all_of(plotyvar))
     ctitle <- paste0('County:',dfg$cou_na[x])
     lp <- ggplot2::ggplot(data=dfg) + 
	     geom_histogram(aes(x=value, fill=name),bins=30) 
   })
 }				      
})
Voterrollgraphs$methods(gridarrange=function(arg1=NULL){

  nmlc <- unique(voterroll$cou_na)
  for (lc in 1:length(nmlc)){
    nmlcl <- nmlc[lc]
    gr1 <- lg_pred[[3]][[lc]] 
    gr2 <- lg_keyr[[3]][[lc]] 
    gr3 <- lg_hist[[3]][[lc]] 
    #grid.arrange(gr1, gr2, gr3, ncol=3)
    #!
    pdf("test.pdf", onefile=FALSE)
    ag <- gridExtra::arrangeGrob(grobs=list(gr1,gr2,gr3),ncol=1,top=nmlcl)
    plotname <- paste0(substr(nmlcl,1,nchar(nmlcl)),".png")
    plotfile <- paste0(rotp,'/inst/script/voterroll/ohio/',plotname)
    ggsave(file=plotfile,ag)
    #list(plot=g)
  }
})

#' @export Voterrollreport
Voterrollreport <- setRefClass("Voterrollreport", contains = c('Voterrollanalysis'))
Voterrollreport$methods(htmlreport=function(reportn='ohio'){

  file_rep_cou <- paste0(rotp,'/inst/script/voterroll/',reportn,'report_cou.html')
  file_rep_sta <- paste0(rotp,'/inst/script/voterroll/',reportn,'report_sta.html')
  
  pre_report <- polypredi %>% dplyr::bind_rows(.) %>% 
    dplyr::mutate(state=reportn) %>%
    dplyr::select(state,cou_nr,cou_na,polyo,corr1,corr2) %>% 
    dplyr::distinct()  
  agg_report <- pre_report %>% 
    dplyr::group_by(polyo) %>%
    dplyr::mutate(mcorr1=mean(corr1)) %>%
    dplyr::mutate(mcorr2=mean(corr2)) %>%
    dplyr::select(state,polyo,mcorr1,mcorr2) %>% 
    dplyr::distinct()
    
  pre_report %>% kableExtra::kbl() %>%
    kableExtra::kable_paper(full_width = T) %>%
    kableExtra::save_kable(file=file_rep_cou)
  agg_report  %>% kableExtra::kbl() %>%
    kableExtra::kable_paper(full_width = T) %>%
    kableExtra::save_kable(file=file_rep_sta)
})

