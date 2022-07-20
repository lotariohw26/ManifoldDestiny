#' @export electiontechn
electiontechn <- function(probw=c(0.50,0.05), 
			  probv=list(c(0.60,0.30,0.10),
				     c(0.30,0.60,0.10)),
			  Ztech=c(0,1), 
			  nprect=NULL){	

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
voterroll='data.frame',
listscard='list', 
polyscard1='list',
polyscard2='list',
polypredi='list', 
polcou='list',  
lg_pred='list',  
lg_hist='list',  
lg_keyr='list', 
rotp='character'))
Voterdatabase$methods(initialize=function(state=c('simulation'), 
					  coudatafile='vtr_ohio.rda', 
					  agebracketmax=c(18,100,30),
					  nprect=20,
					  tot_regis=0.80,
					  probw=c(0.50,0.05),
					  probv=list(c(0.60,0.30,0.10),
						     c(0.30,0.60,0.10)),
                                          Ztech=c(0,1),
                                          modes=c('EDV','MIV'), 
					  namebase='defvotbase',
					  newdraw=F){

pr_path <- rprojroot::find_rstudio_root_file()
### 2 ###
##### initialize
#stlvb1 <- c("id","cou_nr","cou_na","age","R","P","V","probwd","Zt","p1","p2","p3","p4","p5","p6")
#coudatafile='vtr_ohio.rda'
#loadrec <- paste0(pr_path,'/data/',coudatafile)
#saverec <- paste0(pr_path,'/inst/script/voterroll/recorded/',coudatafile)
##voterroll_emp 
#names(listvbase[[1]])
#as.data.frame(get(load(loadrec)))
##!
#s <- listvbase[[1]] <<- as.data.frame(get(load(l_ivfile))) %>% 
#  dplyr::select(id,cou_nr,cou_na,age,registered,prec_nr,voted) %>%
#  base::split(.$cou_nr) %>%
#  purrr::map(function(x){
#    o <- x %>%dplyr::left_join(electiontechn(nprect=max(.$prec_nr)))
#  }) %>% 
#  dplyr::bind_rows(.) %>% `colnames<-` (stlvb1)
#base::save(file=saverec,s)
###### load
loadrec <- paste0(pr_path,'/inst/script/voterroll/recorded/',coudatafile)
listvbase[[1]] <<- get(base::load(file=loadrec))
})
Voterdatabase$methods(regvbase=function(arg1=NULL){

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

  nrco <- unique(listvbase[[2]]$cou_nr)
    lapply(nrco,function(x){
      lapply(1:length(polyo),function(y){
        dft <- dplyr::filter(listvbase[[2]],cou_nr==x)
        ft1 <- paste0("dft$go_key_ratio~poly(dft$age,",polyo[y],",raw=T)")
        ft2 <- paste0("dft$re_key_ratio~poly(dft$age,",polyo[y],",raw=T)")
        list(lm(as.formula(ft1)),lm(as.formula(ft2)))
      })
    }) ->> listscard
    polyscard1 <<- lapply(1:length(polyo), function(x) sapply(1:length(nrco), function(y) unname(listscard[[y]][[x]][[1]]$coeff)))	
    polyscard2 <<- lapply(1:length(polyo), function(x) sapply(1:length(nrco), function(y) unname(listscard[[y]][[x]][[1]]$coeff)))	
})
Voterdatabase$methods(predictinput=function(arg1=NULL){

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



















