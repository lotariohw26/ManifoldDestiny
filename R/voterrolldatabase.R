#' @export Voterdatabase
Voterdatabase <- setRefClass("Voterdatabase", fields=list(
							  listvbase='list')
)
Voterdatabase$methods(initialize=function(agebracketmax=c(18,100,30),
					  nprect=20,
					  reg=0.80,
					  namebase='defvotbase',
					  newdraw=F
					  ){

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
    popsize <- sum(popvotgro) 	         # Total number of citizien
    probage <- popvotgro/popsize 	         # Probability for each age group
    precv <- sample(nprect,size=popsize,T) # Allocated to various precincts (uniform?)

    # Registration
    rvot <- sample(seq(1,popsize),size=popsize*reg,F) # Registered voters

    # Allocation
    precv <-sample(nprect,size=popsize,T) # Allocated to various precincts (uniform)

    # Realvoters
    #sci <- 500; hc <- floor(popsize/sci); resnr <- c(rep(sci,hc),popsize-sci*hc)
    #voterrolldatabase <- resnr %>% purrr::map_df(randNames::rand_names,nationality="US") %>%
    #dplyr::select(gender,name.first,name.last) %>%
    # Id-number for voters
    voterrolldatabase <- data.frame(idn=seq(1:popsize)) %>%
      #dplyr::mutate(status='real') %>%
      # Age being assigned to citizien making up the population
      dplyr::mutate(age=as.vector(wakefield::age(n(),x=seq(agebrack[1],agebrack[2]),prob=probage))) %>%     
      # Assigned to different precincts
      dplyr::mutate(P=sample(nprect,size=n(),replace=T)) %>% 
      dplyr::arrange(P) %>%
      # Assigned whether citizien register to vote or not
      dplyr::mutate(R=ifelse(idn%in%rvot,1,0)) 
      #listvbase[[1]] <<- list(voterrolldatabase,totpop,agebrack)
      listvbase[[1]] <<- voterrolldatabase
      base::save(file=vfile,listvbase)
    } 
    else {
      listvbase <<- get(base::load(file=vfile))
    }
})
Voterdatabase$methods(realizedgp=function(probv=list(c(0.60,0.30,0.10),
						     c(0.30,0.60,0.10)),
					  probw=c(0.50,0.05),
                                          Ztech=c(0,1),
                                          tvoting=c('EDV','MIV')){

  nprect <- max(listvbase[[1]]$P)
  ## Election Technology and voter sentiment
  ztech <- data.frame(P=seq(1,nprect)) %>%
	  dplyr::mutate(probwd=rnorm(nprect,probw[1],probw[2])) %>%
	  dplyr::mutate(Zt=runif(n(), min=Ztech[1], max=Ztech[2])) %>%
          dplyr::mutate(p1=probv[[1]][1]) %>%
          dplyr::mutate(p2=probv[[1]][2]+probv[[1]][3]*Zt) %>%
          dplyr::mutate(p3=probv[[1]][3]*(1-Zt)) %>%
          dplyr::mutate(p4=probv[[2]][1]) %>%
          dplyr::mutate(p5=probv[[2]][2]+probv[[2]][3]*Zt) %>%
          dplyr::mutate(p6=probv[[2]][3]*(1-Zt))

  ## Technology
  listvbase[[2]] <<- listvbase[[1]] %>% dplyr::left_join(ztech, by="P") %>%
	  base::split(.$P) %>%
  purrr::map(function(x){
  x %>%  dplyr::mutate(candraw=rbinom(n(),1,probwd)) %>%
	 dplyr::mutate(voted=ifelse(candraw==1,
      		      sample(1:3,size=n(),prob=c(x$p1[1],x$p2[1],x$p3[1]),T),
      		      sample(4:6,size=n(),prob=c(x$p4[1],x$p5[1],x$p6[1]),T)))
  }) %>%
  dplyr::bind_rows(.) %>%
  # Prior voting for which candidate and type of voting
  dplyr::mutate(a=ifelse(voted==1&R==1,1,0)) %>%
  dplyr::mutate(c=ifelse(voted==2&R==1,1,0)) %>%
  dplyr::mutate(b=ifelse(voted==4&R==1,1,0)) %>%
  dplyr::mutate(d=ifelse(voted==5&R==1,1,0)) %>%
  # Condition for becoming a credit voter: Registered and not voting
  dplyr::mutate(C=ifelse((voted==3|voted==6)&R==1,1,0)) 

})
Voterdatabase$methods(regvbase=function(){
	browser()
lrda <- listvbase[[2]] %>% dplyr::select(idn,age,voted,C) %>%
	dplyr::mutate(cou_nr=1) %>%
	dplyr::mutate(cou_na="abc") %>%
	dplyr::group_by(age) %>%
        dplyr::mutate(ag_geovo=n_distinct(id)) %>%
        dplyr::mutate(ag_voted=sum(voted, na.rm=T)) %>%
        dplyr::mutate(ag_regis=sum(registered, na.rm=T)) %>% 
        dplyr::mutate(ag_gevos=ag_voted/ag_geovo) %>% 
        dplyr::mutate(ag_revos=ag_voted/ag_regis) %>%
	# Total
        dplyr::ungroup() %>%
        dplyr::select(cou_nr,age,ag_geovo,ag_regis,ag_voted,ag_gevos,ag_revos) %>%
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






View(lrda)
names(listvbase[[2]])
#  [1] "cou_nr"       "cou_na"       "age"          "ag_geovo"     "ag_regis"     "ag_voted"     "ag_gevos"     "ag_revos"     "tot_geopo"    "tot_voted"    "tot_regis"    "geo_ratio"    "tur_ratio"   
# [14] "go_key_ratio" "re_key_ratio"

View()
})
Voterdatabase$methods(uploadvbase=function(
				    truev=NULL, 
				    maniv=NULL, 
				    param=NULL 
				    ){
browser()

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
})
