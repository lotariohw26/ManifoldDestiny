#' @export electiontechn
electiontechn<-function(probw=NULL,probv=NULL,Ztech=NULL,nprect=NULL){	

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
Voterdatabase <- setRefClass("Voterdatabase",fields=list(
  listvbase='list',
  listcbase='data.frame',
  voterroll='data.frame',
  predictsc='list', 
  listscard='list', 
  polyscard1='list',
  polyscard2='list',
  polypredi='list', 
  polcou='list',  
  lg_pred='list',  
  lg_hist='list',  
  lg_keyr='list', 
  pr_path='character')
)
Voterdatabase$methods(initialize=function(type_nr=1,lsv=1,probw=c(0.51,0.30),
  probv=list(c(0.70,0.30,0.00),c(0.30,0.60,0.10)),Ztech=c(0,1), 
  cou_sim=list(state_sim='state1',cou_nr=1:2,cou_na=c("A","B"),nprect=c(20,20),tot_regis=c(0.80,0.80), agebrack=c(18,100,50)), 
  rec_sim=list(state_rec='ohio',state_datafile_rec='vtr_ohio')){

  # Setting filepaths
  #pr_path <<- rprojroot::find_rstudio_root_file()
  #reciniload <- paste0(pr_path,'/data/vtr_',rec_sim$state_rec,'.rda')
  #simsaveload <- paste0(pr_path,'/inst/script/voterroll/simulated/',cou_sim$state_sim,'/',cou_sim$state_sim,'.df')
  #recsaveload <- paste0(pr_path,'/inst/script/voterroll/recorded/',rec_sim$state_rec,'/',rec_sim$state_rec,'.df')
  #elect_type <- c ('sim','rec')[type_nr]
  # Setting filepaths
  pr_path <<- system.file(package='ManifoldDestiny')
  reciniload <- ManifoldDestiny::vtr_ohio
  # paste0('vtr_',rec_sim$state_rec,'.rda')
  simsaveload <- paste0(pr_path,'/script/voterroll/simulated/',cou_sim$state_sim,'/',cou_sim$state_sim,'.df')
  recsaveload <- paste0(pr_path,'/script/voterroll/recorded/',rec_sim$state_rec,'/',rec_sim$state_rec,'.df')

  elect_type <- c ('sim','rec')[type_nr]
  if (elect_type=='sim') {
  if (lsv==1) {votdf <- get(base::load(file=simsaveload))}
  else {
    # lapply
    cou_sim$cou_nr %>% lapply(function(x){
    # Demograhpic architecture
    agelength <- cou_sim$agebrack[2]-cou_sim$agebrack[1]
    brack <- seq(cou_sim$agebrack[1],cou_sim$agebrack[2])
    halflength <- agelength/2  #! should be changed
    earlpop <- matrix(1,cou_sim$agebrack[3],halflength)
    stlate <- halflength+1
    enlate <- length(brack)
    ## building
    latepop <- seq(stlate,enlate) %>% purrr::map_dfc(function(x,maxp=cou_sim$agebrack[3])
          	{
          		cf <-maxp/(enlate-stlate)
          		one <- floor(maxp-cf*(x-stlate))
          		zero <- maxp-one
    		matrix(c(rep(0,zero),rep(1,one)))
        		}) %>% as.matrix()
    colnames(latepop) <- NULL
    ## simerties
    totpop <- cbind(earlpop,latepop)
    popvotgro <- colSums(totpop)           # Population for each age group
    popsize <- sum(popvotgro) 	         # Total number of citizien
    probage <- popvotgro/popsize 	         # Probability for each age group
    precv <- sample(cou_sim$nprect[x],size=popsize,T) # Allocated to various precincts (uniform?)
    rvot <- sample(seq(1,popsize),size=popsize*cou_sim$tot_regis[x],F) # Registered voters
    precv <-sample(cou_sim$nprect[x],size=popsize,T) # Allocated to various precincts (uniform)
    votdf_cou <- data.frame(id=seq(1:popsize)) %>%
    dplyr::mutate(cou_nr=cou_sim$cou_nr[x]) %>%
    dplyr::mutate(cou_na=cou_sim$cou_na[x]) %>%
    dplyr::mutate(age=as.vector(wakefield::age(n(),x=brack,prob=probage))) %>%     
    dplyr::mutate(prec_nr=sample(cou_sim$nprect[x],size=n(),replace=T)) %>% 
    dplyr::arrange(prec_nr) %>%
    dplyr::mutate(registered=ifelse(id%in%rvot,1,0)) %>% 
    dplyr::left_join(electiontechn(probw,probv,Ztech,nprect=cou_sim$nprect[x]), by='prec_nr')
    }) %>% dplyr::bind_rows(.) -> votdf
    base::save(votdf, file =simsaveload)
}
}
if (elect_type=='rec') {
  if (lsv==1) {votdf <- get(base::load(file=recsaveload))}
  else {
	votdf <- as.data.frame(get(load(reciniload))) %>%
	dplyr::select(id,cou_nr,cou_na,age,prec_nr,registered,voted) %>%
	base::split(.$cou_nr) %>% 
	purrr::map(function(x){
          o <- x %>%dplyr::left_join(electiontechn(probw,probv,Ztech,nprect=max(.$prec_nr)))
        }) %>% dplyr::bind_rows(.) #%>% `colnames<-` (stlvb1) 
	base::save(votdf, file = recsaveload)
}
}
  listvbase[[1]] <<- votdf %>% base::split(.$prec_nr) %>% 
    	purrr::map(function(x){
    x %>%  dplyr::mutate(candraw=rbinom(n(),1,probw)) %>%
    dplyr::mutate(priorvote=ifelse(candraw==1,
    sample(1:3,size=n(),prob=c(x$p1[1],x$p2[1],x$p3[1]),T),
    sample(4:6,size=n(),prob=c(x$p4[1],x$p5[1],x$p6[1]),T)))
  	}) %>% dplyr::bind_rows(.) %>%
                 # Prior voting for which candidate and type of voting
                 dplyr::mutate(a=ifelse(priorvote==1&registered==1,1,0)) %>%
                 dplyr::mutate(c=ifelse(priorvote==2&registered==1,1,0)) %>%
                 dplyr::mutate(b=ifelse(priorvote==4&registered==1,1,0)) %>%
                 dplyr::mutate(d=ifelse(priorvote==5&registered==1,1,0)) %>%
  	       dplyr::mutate(voted=ifelse(a+b+c+d>0,1,0)) %>%
                 # Condition for becoming a credit voter: Registered and not voting
                 dplyr::mutate(C=ifelse((priorvote==3|priorvote==6)&registered==1,1,0)) 
  
  listvbase[[1]] <<-  rename(listvbase[[1]],R=registered)
  listvbase[[1]] <<-  rename(listvbase[[1]],P=prec_nr)
  listvbase[[1]] <<-  rename(listvbase[[1]],V=voted)
  
  listcbase <<- listvbase[[1]] %>% dplyr::select(c('cou_nr','P','R','a','b','c','d')) %>% 
  	dplyr::arrange(cou_nr,P) %>%  dplyr::group_by(cou_nr,P)  %>% 
  	dplyr::mutate(a=sum(a),b=sum(b),c=sum(c),d=sum(d),R=sum(R)) %>%
  	dplyr::distinct() %>% 
  	dplyr::mutate(V=sum(a+b+c+d)) %>%
  	dplyr::ungroup()
  })
Voterdatabase$methods(regvbase=function(arg1=NULL){
#votdf <- c("id","cou_nr","cou_na","age","R","P","V","probwd","Zt","p1","p2","p3","p4","p5","p6")

    listvbase[[2]] <<- listvbase[[1]] %>% 
    dplyr::select(cou_nr,cou_na,id,age,P,R,V) %>%
    ##dplyr::mutate(V=R-C) %>%
    dplyr::group_by(age) %>%
    dplyr::arrange(age) %>%
    dplyr::mutate(ag_geovo=n_distinct(id)) %>% 
    dplyr::mutate(ag_voted=sum(V,na.rm=T)) %>%
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
})
Voterdatabase$methods(scorecard=function(polyo=c(1,2,6,8)){
			      
  polcou[[1]] <<- polyo
  polcou[[2]] <<- unique(listvbase[[2]]$cou_nr)

  lapply(polcou[[2]] ,function(x){
    lapply(1:length(polyo),function(y){
      dft <- dplyr::filter(listvbase[[2]],cou_nr==x)
      ft1 <- paste0("dft$go_key_ratio~poly(dft$age,",polyo[y],",raw=T)")
      ft2 <- paste0("dft$re_key_ratio~poly(dft$age,",polyo[y],",raw=T)")
      list(lm(as.formula(ft1)),lm(as.formula(ft2)))
   })
    }) ->> listscard
    polyscard1 <<- lapply(1:length(polyo), function(x) sapply(1:length(polcou[[2]]), function(y) unname(listscard[[y]][[x]][[1]]$coeff)))	
    polyscard2 <<- lapply(1:length(polyo), function(x) sapply(1:length(polcou[[2]]), function(y) unname(listscard[[y]][[x]][[1]]$coeff)))	
})
Voterdatabase$methods(predictinput=function(arg1=NULL){
			     
  polypredi <<- lapply(1:length(polcou[[1]]), function(x){
    avg_key_poly1 <- t(polyscard1[[x]]) %>% base::colMeans() %>% polynom::polynomial()
    avg_key_poly2 <- t(polyscard2[[x]]) %>% base::colMeans() %>% polynom::polynomial()
    predictsc[[1]] <<- listvbase[[2]] %>%
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
    dplyr::ungroup()}
  ) 
  # For report
  predictsc[[2]]  <<- polypredi %>% dplyr::bind_rows(.) %>%
  dplyr::mutate(state='state') %>%
  dplyr::select(state,cou_nr,cou_na,polyo,corr1,corr2) %>% 
  dplyr::distinct()  
  # Agg report
  predictsc[[3]] <<- predictsc[[2]] %>% 
  dplyr::group_by(polyo) %>%
  dplyr::mutate(mcorr1=mean(corr1)) %>%
  dplyr::mutate(mcorr2=mean(corr2)) %>%
  dplyr::select(state,polyo,mcorr1,mcorr2) %>% 
  dplyr::distinct()
 
})
Voterdatabase$methods(uploadvbase=function(
				    truev=NULL, 
				    maniv=NULL, 
				    param=NULL 
				    ){
listvbase[[3]] <<- listvbase[[2]] 
})

#' @export Voterrollgraphs
Voterdatabaseplots <- setRefClass("Voterdatabaseplots", contains = c('Voterdatabase'))
Voterdatabaseplots$methods(plot_predict=function(plotyvar=c('ag_geovo','ag_voted','ag_regis','ag_vpred1','ag_vpred2'), lp=list(x='Age category',y='Number of voters') 
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
Voterdatabaseplots$methods(plot_keyrat=function(plotyvar=list(li=c('avg_key_ratio1','avg_key_ratio2'),po=c('go_key_ratio','re_key_ratio','avg_key_ratio1','avg_key_ratio2','tur_ratio'))){

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
Voterdatabaseplots$methods(plot_histio=function(plotyvar=c('pred_error1','pred_error2')){

 for (po in 1:length(polcou[[1]])){
   lg_hist[[po]] <<- lapply(polcou[[2]], function(x){
     dfg <- polypredi[[po]] %>% dplyr::filter(cou_nr==x) %>% tidyr::pivot_longer(all_of(plotyvar))
     ctitle <- paste0('County:',dfg$cou_na[x])
     lp <- ggplot2::ggplot(data=dfg) + 
	     geom_histogram(aes(x=value, fill=name),bins=30) 
   })
 }				      
})
Voterdatabaseplots$methods(gridarrange=function(arg1=NULL){

  nmlc <- unique(listvbase[[2]]$cou_na)
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
    plotfile <- paste0(pr_path,'/inst/script/voterroll/ohio/',plotname)
    ggsave(file=plotfile,ag)
    #list(plot=g)
  }
})
#' @export Voterrollreport
Voterrollreport <- setRefClass("Voterrollreport", contains = c('Voterdatabase'))
Voterrollreport$methods(htmlreport=function(reportn='ohio'){

  file_rep_cou <- paste0(pr_path,'/inst/script/voterroll/recorded/',reportn,'report_cou.html')
  file_rep_sta <- paste0(pr_path,'/inst/script/voterroll/recorded/',reportn,'report_sta.html')

  v1 <-  predictsc[[2]] %>% kableExtra::kbl() %>%
    kableExtra::kable_paper(full_width = T) %>%
    kableExtra::save_kable(file=file_rep_sta)
  v2 <- predictsc[[3]] %>% kableExtra::kbl() %>%
    kableExtra::kable_paper(full_width = T) %>%
    kableExtra::save_kable(file=file_rep_sta)
})

