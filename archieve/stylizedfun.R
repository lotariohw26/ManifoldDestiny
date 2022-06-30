#' @export
dgprealized <- function(maxpeople=30,
		        agebracket=c(18,100),
		        reg=0.8,
		        prv=c(vot=0.80,typeedv=0.6,edvb=0.35,mivb=0.6),
		        prect=data.frame(prect=seq(1,20),county=c(rep('A',10),rep("B",10))),
		        county=c("A","B"),
		        periods=seq(1,5),
		        seed=set.seed(1),
		        timelength=5,
		        credit=0.3,
			state=1){


  # Demograhpic
  agelength <- agebracket[2]-agebracket[1]
  brack <- seq(agebracket[1],agebracket[2]) # why minus
  halflength <- agelength/2  #! should be changed
  earlpop <- matrix(1,maxpeople,halflength)
  stlate <- halflength+1
  enlate <- length(brack)
  # Making decreasing rate of voters belonging to older age groups
  latepop <- seq(stlate,enlate) %>% purrr::map_dfc(function(x,maxp=maxpeople)
		{
			cf <-maxp/(enlate-stlate)
			one <- floor(maxp-cf*(x-stlate))
			zero <- maxp-one
  			matrix(c(rep(0,zero),rep(1,one)))
      		}) %>% as.matrix()


  colnames(latepop) <- NULL
  # True Population
  totpop <- cbind(earlpop,latepop)
  popvotgro <- colSums(totpop)         # Population for each age group
  popsize <- sum(popvotgro) 	       # Total number of citizien
  probage <- popvotgro/popsize 	       # Probability  for each age group
  rvot <- sample(seq(1,popsize),size=popsize*reg) # Registered voters
  balv <- sample(rvot,size=length(rvot)*prv[[1]]) # Registered voters vote or not
  precv <- sample(prect$prect,size=popsize,T) # Allocated to various precincts (uniform)

  sentdf <- data.frame(pi=prect$prect,
		       sentedv=rep(truncnorm::rtruncnorm(length(prect$prect),a=0,b=1,
							 mean=prv[3],
							 sd=0.1)))

  sci <- 500
  hc <- floor(popsize/sci)
  resnr <- c(rep(sci,hc),popsize-sci*hc)
  realvoters <- resnr %>%
    purrr::map_df(randNames::rand_names,nationality="US") %>%
    dplyr::select(gender,name.first,name.last) %>%
    dplyr::mutate(status='real') %>%
    # Id-number for voters
    dplyr::mutate(id_n=row_number()) %>%
    # Allocated to different precincts
    dplyr::mutate(pi=sample(prect$prect,size=n(),replace=T)) %>%
    dplyr::left_join(prect,by=c('pi'='prect')) %>%
    dplyr::left_join(sentdf,by=c('pi')) %>%
    # Can add some noise here later
    dplyr::mutate(sentmiv=sentedv +(prv[4]-prv[3])) %>%
    # Age being allocated to citizien making up the population
    dplyr::mutate(age=as.vector(wakefield::age(n(),x=brack,prob=probage))) %>%
    # Allocated whether citizien register to vote or not
    dplyr::mutate(registered=ifelse(id_n%in%rvot,1,0))  %>%
    # Allocated whether registered people vote or not
    dplyr::mutate(voting=ifelse(id_n%in%balv,1,0)) %>%
    dplyr::mutate(probedv=truncnorm::rtruncnorm(n(),a=0,b=1, mean=sentedv,sd=0*0.0001))  %>%
    dplyr::mutate(probmiv=truncnorm::rtruncnorm(n(),a=0,b=1, mean=sentmiv,sd=0*0.0001)) %>%
    dplyr::mutate(state=state)

  ## Realized DGP ##
  tvoting <- c('EDV','MIV')
  voterdatabase <- realvoters %>%
    dplyr::ungroup() %>%
    dplyr::mutate(votetype=ifelse(voting==1,rbinom(n(),1,prv[2]),NA)) %>%
    dplyr::mutate(probset=ifelse(voting==1,case_when(votetype==0 ~ probedv,
						     votetype==1 ~ probmiv),
				 0))  %>%
    dplyr::mutate(b_vote=ifelse(voting==1,rbinom(n(),1,probset),0)) %>%
    # Labeling votetype
    dplyr::mutate(votetype=ifelse(voting==1,tvoting[1+votetype],NA)) %>%
    # Allocating time indexes
    dplyr::mutate(ti=ifelse(votetype=='MIV',timelength,voting*sample(1:timelength, n(), replace = TRUE)))

    ## Phantom population: split into two types, planned and adjusted
    phavotgro <- floor(colSums(totpop)*credit) # Adding phantom-voters
    phasize <- sum(phavotgro) # Total population size
    phprecv <- sample(prect$prect,size=phasize,T) # Allocated to various precincts (uniform)

    #rpha <- sample(seq(1,popsize),size=phasize*1) # Registered voters
    #bpha <- sample(rpha,size=length(rpha)*0.8) # Active voters

    creditvoters <- tibble(randNames::rand_names(ifelse(phasize==0,1,phasize),nationality='us')) %>%
      dplyr::select(1,6:8,30:31) %>%
      dplyr::select(gender,name.first,name.last)  %>%
      dplyr::mutate(status='credit') %>%
      dplyr::mutate(pi=phprecv) %>%
      dplyr::left_join(prect,by=c('pi'='prect')) %>%
      dplyr::mutate(age=as.vector(wakefield::age(n(),x=brack,prob=probage))) %>%
      # Default position
      dplyr::mutate(registered=0) %>%
      dplyr::mutate(voting=0) %>%
      dplyr::mutate(state=state)

  appvoterdatabase <- dplyr::bind_rows(voterdatabase,creditvoters) %>%
	  dplyr::arrange(desc(status),county,pi)
}

#' @export
countingp <- function(state_election_data=state1_election_data){

  # Realvoters
  fou_cou_pro <- state_election_data %>%
	# filtering the voting data
	dplyr::mutate(t_vote=1-b_vote) %>%
  	dplyr::filter(voting==1) %>%
	dplyr::filter(status=='real') %>%
	dplyr::select(county,ti,pi,voting,votetype,b_vote,t_vote) %>%
	dplyr::mutate(seized=0) %>%
  	# I: Dynamic counting process precincts
	dplyr::group_by(county,votetype,pi,ti) %>%
  	dplyr::arrange(votetype,pi,ti)  %>%
	dplyr::mutate(cum_t_b_votes=cumsum(b_vote)) %>%
	dplyr::mutate(cum_t_t_votes=cumsum(t_vote)) %>%
	dplyr::mutate(cum_t_a_votes=cumsum(t_vote)+cumsum(b_vote)) %>%
	dplyr::mutate(cum_t_r_t_votes=cum_t_t_votes/cum_t_a_votes) %>%
	dplyr::mutate(cum_t_r_b_votes=1-cum_t_r_t_votes) %>%
	dplyr::mutate(regti=dplyr::row_number(ti)) %>%
	dplyr::filter(regti==max(regti)) %>%
	dplyr::select(-t_vote,-b_vote) %>%
  	# II: Static counting process precincts
	dplyr::group_by(county,votetype,pi) %>%
	dplyr::arrange(votetype,county,pi,ti) %>%
	dplyr::mutate(cum_s_t_votes=cumsum(cum_t_t_votes)) %>%
	dplyr::mutate(cum_s_b_votes=cumsum(cum_t_b_votes)) %>%
  	dplyr::mutate(cum_s_a_votes=cumsum(cum_t_t_votes+cum_t_b_votes)) %>%
  	dplyr::mutate(cum_s_r_t_votes=cum_s_t_votes/cum_s_a_votes) %>%
        dplyr::mutate(cum_s_r_b_votes=1-cum_s_r_t_votes) %>%
        # III: Static counting process all votes
  	dplyr::group_by(county,pi) %>%
	dplyr::mutate(cum_sa_t_votes=cumsum(cum_t_t_votes)) %>%
        dplyr::mutate(cum_sa_b_votes=cumsum(cum_t_b_votes)) %>%
  	dplyr::mutate(cum_sa_a_votes=cumsum(cum_t_t_votes+cum_t_b_votes)) %>%
  	dplyr::mutate(cum_sa_r_t_votes=cum_sa_t_votes/cum_sa_a_votes) %>%
        dplyr::mutate(cum_sa_r_b_votes=1-cum_sa_r_t_votes) %>%
        # IV State counting process
        dplyr::ungroup() %>%
        dplyr::mutate(s_cum_t_votes=cumsum(cum_s_t_votes)) %>%
        dplyr::mutate(s_cum_b_votes=cumsum(cum_s_b_votes)) %>%
  	dplyr::mutate(s_cum_a_votes=s_cum_t_votes+s_cum_b_votes) %>%
	dplyr::mutate(s_cum_r_t_votes=s_cum_t_votes/s_cum_a_votes) %>%
	dplyr::mutate(s_cum_r_b_votes=1-s_cum_r_t_votes)

  # Phantom-voters
#  pha_cou_pro <- state_election_data %>%
#	dplyr::filter(status=='credit')
#View(pha_cou_pro)

}

#' @export
sortprecinct <- function(election_box_df=NULL,pol_order=7,M=0,kn=NULL,hn=NULL,
			 polypred=NULL){

  unc <- length(unique(election_box_df$county))
  unp <- length(unique(election_box_df$pi))/unc

  quintile <- election_box_df  %>%
    dplyr::select(county,votetype,ti,pi,cum_s_t_votes,cum_s_b_votes,cum_s_a_votes,cum_s_r_b_votes) %>%
    # Filtering
    dplyr::arrange(county,votetype,pi,ti) %>%
    dplyr::group_by(county,votetype,pi) %>%
    dplyr::filter(ti==max(ti)) %>%
    # Indexing
    dplyr::group_by(county) %>%
    #dplyr::ungroup() %>%
    # base index?
    dplyr::mutate(ix1=rep(1:unp,unc)) %>%
    dplyr::mutate(ix2=rep((unp+1):(unp*unc),2)) %>%
    dplyr::mutate(ix3=c(ix1[1:unp],ix2[1:unp])) %>%
    # Votinginfo
    dplyr::mutate(t1=cum_s_a_votes[ix1]) %>%
    dplyr::mutate(t2=cum_s_a_votes[ix2]) %>%
    dplyr::mutate(ta=t1+t2) %>%
    dplyr::mutate(zeta=t2/t1) %>%
    dplyr::mutate(a=cum_s_b_votes[ix1]) %>%
    dplyr::mutate(b=cum_s_t_votes[ix1]) %>%
    dplyr::mutate(c=cum_s_b_votes[ix2]) %>%
    dplyr::mutate(d=cum_s_t_votes[ix2]) %>%
    dplyr::mutate(x=(a)/(a+b)) %>%
    dplyr::mutate(y=(c)/(c+d)) %>%
    dplyr::mutate(alpha=(x+zeta*y)/(zeta+1)) %>%
    # Sorting by MiV
    dplyr::arrange(county,votetype,y) %>%
    dplyr::group_by(county,votetype) %>%
    dplyr::mutate(agg_ind=dplyr::row_number(alpha)) %>%
    #dplyr::arrange(aggpx) %>%
    # Normalizing precinct to the unit square
    dplyr::mutate(pi_ind=row_number()/length(pi)) %>%
    dplyr::select(county,votetype,y,pi,pi_ind,a,b,c,d,y,x,alpha,t1,t2,zeta) %>%
    dplyr::mutate(creditv=0) %>%
    dplyr::distinct() %>%
    # Rigging: Eric Coomer was here!
    {if(M) sort_overriding(.,k=kn,h=hn,polypred=polypred) else . } %>%
    # Polynomial fitting
    tidyr::nest() %>%
    dplyr::mutate(model1 = data %>% map(~lm(x ~ poly(pi_ind,pol_order, raw=T), data = .))) %>%
    dplyr::mutate(model2 = data %>% map(~lm(y ~ poly(pi_ind,pol_order, raw=T), data = .))) %>%
    dplyr::mutate(model3 = data %>% map(~lm(alpha~ poly(pi_ind,pol_order, raw=T), data = .))) %>%
    dplyr::mutate(pred1 = map2(model1, data, predict)) %>%
    dplyr::mutate(pred2 = map2(model2, data, predict)) %>%
    dplyr::mutate(pred3 = map2(model3, data, predict)) %>%
    tidyr::unnest(c(pred1,pred2,pred3, data)) %>%
    #  Creating new variables
    dplyr::select(-model1,-model2,-model3) %>%
    dplyr::mutate(res_x=x-pred1) %>%
    dplyr::mutate(res_y=y-pred2) %>%
    dplyr::mutate(res_alpha=alpha-pred3) %>%
    dplyr::mutate(res_zeta=zeta-mean(zeta)) %>%
    #dplyr::mutate(crossres=Zres*res_miv) %>%
    dplyr::ungroup() %>%
    tidyr::pivot_longer(c(x,y,alpha,pred1,pred2,pred3))

}

#' @export
quintileplot <- function(quintile_df=NULL,filcou=NULL){

  df_s <- subset(quintile_df,county==filcou)
  ngp <- sortplot(df_s,scale_c=0.25)
  nrp <- resplot(datadf=df_s,xt='res_zeta',yt='res_alpha')
  njp <- resplot(datadf=df_s,xt='res_zeta',yt='res_y')
  df_sw <- tidyr::pivot_wider(df_s)
  xn <- df_sw$x
  yn <- df_sw$y
  zn <- df_sw$alpha
  xyzs <- plotly::plot_ly(x=xn,y=yn,z=zn,type="scatter3d", mode="markers") %>%
  layout(scene = list(
      title = "Manifold",
      xaxis = list(title = "EDV"),
      yaxis = list(title = "MiV"),
      zaxis = list(title = "Agg")))
      list(g1=gridExtra::grid.arrange(ngp,nrp,njp,nrow = 1),g2=xyzs)
#       g2=subplot(ngp1,nrp1,njp1),
}

polinj <- function(relperel=NULL,polynr=5){

  dgpsummed <- relperel %>%
    dplyr::filter(voting==1) %>%
    dplyr::arrange(county,pi) %>%
    dplyr::select(county,pi,b_vote) %>%
    dplyr::arrange(county,pi) %>%
    dplyr::group_by(county,pi) %>%
    dplyr::mutate(rown=dplyr::row_number()) %>%
    dplyr::mutate(ab=sum(b_vote)) %>%
    dplyr::mutate(t1t2=max(rown)) %>%
    dplyr::mutate(alpha=ab/t1t2) %>%
    dplyr::select(-b_vote,-rown) %>%
    dplyr::arrange(county,alpha) %>%
    dplyr::group_by(county) %>%
    dplyr::distinct() %>%
    dplyr::mutate(pre_n=cumsum(t1t2)/sum(t1t2)) %>%
    dplyr::mutate(pre_n_o=row_number(alpha)/max(row_number(alpha))) %>%
    tidyr::nest() %>%
    dplyr::mutate(model= data %>% purrr::map(~lm(alpha ~ poly(pre_n,polynr,raw=T),data = .))) %>%
    dplyr::mutate(predict = purrr::map2(model,data,predict)) %>%
    dplyr::select(-model) %>%
    tidyr::unnest(c(predict, data)) %>%
    dplyr::mutate(res=predict-alpha)

  polc <- broom::tidy(lm(dgpsummed$alpha~poly(dgpsummed$pre_n,polynr, raw=T)))$estimate
  sp <- polynom::integral(polynom::polynomial(polc),c(0,1))

  pn <- polynom::polynomial(coef=polc)

  g1 <- ggplot2::ggplot(dgpsummed,aes(x=pre_n,y=alpha)) +
	  ggplot2::geom_line(aes(y=predict)) +
	  ggplot2::geom_point(aes(pre_n,alpha)) +
	  ggplot2::labs(x='precinct',y='probability')

  g2 <- ggplot2::ggplot(dgpsummed,aes(pre_n,res))+ geom_point() + geom_line(aes(y=0))

  list(df1=dgpsummed,polc=polc,g1=g1,g2=g2,sp=sp)
}

publelectresults <- function(box=flipnormal_box_off){
	presentted_box_df_offflip <- box %>%
  	dplyr::arrange(ti,pi,votetype) %>%
  	dplyr::mutate(tot_t_votes=cumsum(cum_t_t_votes),
  	tot_b_votes=cumsum(cum_t_b_votes),
  	tot_a_votes=cumsum(cum_t_t_votes+cum_t_b_votes)) %>%
  	dplyr::ungroup() %>%
  	dplyr::mutate(trump_ratio=tot_t_votes/tot_a_votes) %>%
  	dplyr::select(county,ti,trump_ratio,tot_t_votes,tot_b_votes,tot_a_votes) %>%
  	tidyr::pivot_longer(c(tot_t_votes,tot_b_votes,tot_a_votes))
}

rotmat <- function(flip_box=NULL,wheel_nr=6, probv=c(0.3,0.2,0.2,0.1,0.0)){
	fractv <- list(1,2,3,4,5) %>% map_dbl(function(x) wheelchoise[which.min(abs(wheelchoise-probv[x]))])
		rows <- length(unique(flip_box$ti))
		cols <- length(unique(flip_box$pi))
		rotwheel <- matrix(rep(fractv,cols),ncol=cols)
}

y_mail <- function(alpha=0.53,x=0.4,k=0.01,h=-0.0282354516396){eval(parse(text='(alpha-k*x-h)/(1-k*x)'),c(list(alpha=alpha,x=x),list(k=k,h=h)))}

sort_overriding <- function(quintiledf=NULL,k=0.01,h=-0.0282354516396,polypred=NULL,backup=F){

    fquintiledf <- quintiledf %>%
    ### Reshufle precinct ordering
    #dplyr::mutate(pi_ind2=reopi) %>%
    ### Injecting new percentages
    dplyr::mutate(xo=x) %>%
    dplyr::left_join(polypred,by=c('county'='county','pi_ind'='pre_n_o')) %>%
    #dplyr::mutate(alphao=polypred$alpha) %>%
    dplyr::mutate(yo=y_mail(alphao,xo,k,h)) %>%
    dplyr::mutate(zetao=(x-alphao)/(alphao-yo)) %>%
    #### Several options here: one written out so far
    dplyr::mutate(co=floor((a+b)*y*zetao)) %>%
    dplyr::mutate(do=floor((a+b)*(1-y)*zetao)) %>%
    ### Testing
    ## Negative zero
    ## Cred line exceeded
    ### Overriding previous values
    dplyr::mutate(alpha=alphao) %>%
    dplyr::mutate(y=yo) %>%
    dplyr::mutate(zeta=zetao) %>%
    ## New variables
    dplyr::mutate(creditv=co-c+do-d)
}

keymanipulator <- function(scale=TRUE,voterbase=TRUE,needed=500){

  vb <- voterbase %>% dplyr::ungroup()
    tregpopr <- sum(vb$registered)/sum(vb$pop_all)
    tvotregr <- sum(vb$voting)/sum(vb$registered)
    xr <- vb$age
    st <- xr[1]
    en <- rev(xr)[1]
    kcf <- broom::tidy(lm(vb$avgregpopratio~poly(vb$age,1,raw=T)))$estimate
    pn <- polynom::polynomial(coef=kcf)
    pn[1] <- pn[1]*1
    pv <- stats::predict(pn,xr)
    keyint <- xr %>% purrr::map_dbl(function(x)
    		   {
    			      polynom::integral(pn,c(x,x+1))
    		   })
    # Statekey for manipulation
    voterbaseout <- vb %>%
    # Calculating syntetic values
    ## Avg
    ## Registered voters in each age group
    #dplyr::mutate(oregistered=floor(pop_all*scale[1]*keyint)) %>%
    dplyr::mutate(oregistered=floor(pop_all*1*keyint)) %>%
    ## People who voted in each age group
    #dplyr::mutate(ovoted=floor(oregistered*ovregratio*keyint))
    dplyr::mutate(ovoted=floor(1*oregistered))
    #dplyr::mutate(ovoted=floor(scale[2]*oregistered))
    ## For finding the rootnorm
    svoters <- sum(voterbaseout$ovoted)
    rootnorm <- svoters

    list(rootnorm,voterbaseout)
}

voterb_overriding <- function(voterbasedf=NULL,scale=TRUE){

    cou <- unique(voterbasedf$county)

    out <- cou %>% purrr::map_dfr(function(x){
        browser()
        ## Filtering out specific county
	dfs <- filter(voterbasedf,county=="A")
	# keymanipulator(scale=scale,voterbase=dfs,needed=500)[[1]]
	# dfs <- filter(voterbasedf,county==x)
	keymanipulator(scale=scale,voterbase=dfs,needed=500)[[2]] %>%
	# Adding unit root
	## Overriding previous values
	dplyr::mutate(registered=oregistered) %>%
        dplyr::mutate(voting=ovoted) %>%
        dplyr::mutate(t_registered=sum(registered)) %>%
        dplyr::mutate(t_voting=sum(voting)) %>%
	## plot first rstio
        dplyr::mutate(t_regpopratio=t_registered/t_pop_real) %>%
        dplyr::mutate(t_votregratio=t_voting/t_registered) %>%
	## plot first rstio
    	dplyr::mutate(regipred=pop_all*1) %>%
    	#dplyr::mutate(regipred=pop_all*scale[1]*avgregpopratio) %>%
    	#dplyr::mutate(votipred=regipred*scale[2]*avgturnratio)
    	dplyr::mutate(votipred=regipred*1)
	})
}

sortprecinct <- function(election_box_df=NULL,pol_order=7,M=0,kn=NULL,hn=NULL,
			 polypred=NULL){

  unc <- length(unique(election_box_df$county))
  unp <- length(unique(election_box_df$pi))/unc

  quintile <- election_box_df  %>%
    dplyr::select(county,votetype,ti,pi,cum_s_t_votes,cum_s_b_votes,cum_s_a_votes,cum_s_r_b_votes) %>%
    # Filtering
    dplyr::arrange(county,votetype,pi,ti) %>%
    dplyr::group_by(county,votetype,pi) %>%
    dplyr::filter(ti==max(ti)) %>%
    # Indexing
    dplyr::group_by(county) %>%
    #dplyr::ungroup() %>%
    # base index?
    dplyr::mutate(ix1=rep(1:unp,unc)) %>%
    dplyr::mutate(ix2=rep((unp+1):(unp*unc),2)) %>%
    dplyr::mutate(ix3=c(ix1[1:unp],ix2[1:unp])) %>%
    # Votinginfo
    dplyr::mutate(t1=cum_s_a_votes[ix1]) %>%
    dplyr::mutate(t2=cum_s_a_votes[ix2]) %>%
    dplyr::mutate(ta=t1+t2) %>%
    dplyr::mutate(zeta=t2/t1) %>%
    dplyr::mutate(a=cum_s_b_votes[ix1]) %>%
    dplyr::mutate(b=cum_s_t_votes[ix1]) %>%
    dplyr::mutate(c=cum_s_b_votes[ix2]) %>%
    dplyr::mutate(d=cum_s_t_votes[ix2]) %>%
    dplyr::mutate(x=(a)/(a+b)) %>%
    dplyr::mutate(y=(c)/(c+d)) %>%
    dplyr::mutate(alpha=(x+zeta*y)/(zeta+1)) %>%
    # Sorting by MiV
    dplyr::arrange(county,votetype,y) %>%
    dplyr::group_by(county,votetype) %>%
    dplyr::mutate(agg_ind=dplyr::row_number(alpha)) %>%
    #dplyr::arrange(aggpx) %>%
    # Normalizing precinct to the unit square
    dplyr::mutate(pi_ind=row_number()/length(pi)) %>%
    dplyr::select(county,votetype,y,pi,pi_ind,a,b,c,d,y,x,alpha,t1,t2,zeta) %>%
    dplyr::mutate(creditv=0) %>%
    dplyr::distinct() %>%
    # Rigging: Eric Coomer was here!
    {if(M) sort_overriding(.,k=kn,h=hn,polypred=polypred) else . } %>%
    # Polynomial fitting
    tidyr::nest() %>%
    dplyr::mutate(model1 = data %>% map(~lm(x ~ poly(pi_ind,pol_order, raw=T), data = .))) %>%
    dplyr::mutate(model2 = data %>% map(~lm(y ~ poly(pi_ind,pol_order, raw=T), data = .))) %>%
    dplyr::mutate(model3 = data %>% map(~lm(alpha~ poly(pi_ind,pol_order, raw=T), data = .))) %>%
    dplyr::mutate(pred1 = map2(model1, data, predict)) %>%
    dplyr::mutate(pred2 = map2(model2, data, predict)) %>%
    dplyr::mutate(pred3 = map2(model3, data, predict)) %>%
    tidyr::unnest(c(pred1,pred2,pred3, data)) %>%
    #  Creating new variables
    dplyr::select(-model1,-model2,-model3) %>%
    dplyr::mutate(res_x=x-pred1) %>%
    dplyr::mutate(res_y=y-pred2) %>%
    dplyr::mutate(res_alpha=alpha-pred3) %>%
    dplyr::mutate(res_zeta=zeta-mean(zeta)) %>%
    dplyr::mutate(crossres_zm=res_zeta*res_miv) %>%
    dplyr::mutate(crossres_za=res_zeta*res_alpha) %>%
    dplyr::ungroup() %>%
    tidyr::pivot_longer(c(x,y,alpha,pred1,pred2,pred3))

}

histerrpred <-function(x,label=NULL){
  ggplot2::ggplot(data=x) + geom_histogram(aes(x=value)) + ggplot2::labs(title = label$title)
}
keyplot <-function(x,label=NULL){

	ggplot2::ggplot(data=x, aes(x=age,y=value, color=name)) +
	  geom_point() +
	  scale_y_continuous(limits=c(0, 2)) +
          ggplot2::labs(caption=paste("Polynomial of order:",x$polyorder))
}
countyplot3 <- function(dfl=NULL,
			type='natural',
			state='1',
			cou='A',
			lab=list(c("avgregpopratio","avgturnratio"),
			         #c("registered","voting"),
			         c("pop_all","registered","voting"),
			  c('regipred','votipred'))){

	# County name
	cou_name <- paste0("State: ",state," (",type,")"," County:", cou)

	# Polynomial
	ckr <- dfl %>%
		purrr::map(function(x) dplyr::filter(x,name%in%lab[[1]]&county%in%c(cou)) %>%
	keyplot())

	# True
  	cpo <- dfl %>% purrr::map(function(x){
	 	dplyr::filter(x,name%in%lab[[2]]&county%in%c(cou)) %>%
   votplot() +
		ggplot2::labs(caption=paste0('Registration ratio:=',round(x$t_regpopratio,digits=2),' Voting ratio:', round(x$t_votregratio,digits=2)))
	})

	cpm <- dfl %>% purrr::map(function(x){
	 dplyr::filter(x,name%in%lab[[3]]&county%in%c(cou)) %>%
   votplot() +
  	 ggplot2::labs(caption=paste0('corr (r) population vs. registration:=',round(x$corr_reg,digits=4),' corr (r) registration vs. voting:', round(x$corr_reg,digits=4)))
	})

   ga <- gridExtra::marrangeGrob(append(append(ckr,cpo),cpm),nrow=length(dfl),ncol=3,top=cou_name)

  plotname <- paste(cou_name,".png")
  plotfile <- paste0("pngs/",plotname)
  ggsave(file=plotfile,ga)
  list(plot=ga)


}
desmosr <- function(equation='x^2',theta=1,round='(1-x^2)^(1/2)',x=seq(-1,1,0.01),select=c('xt','yt')){
  u1 <- eval(parse(text=round),list(x=x))
  u2 <- eval(parse(text=round),list(x=x))*-1
  y <- eval(parse(text=equation),list(x=x))
  # Rotation
  xt <- x*cos(theta)-y*sin(theta)
  yt <- x*cos(theta)+y*sin(theta)

  # Collecting


  df <- data.frame(x,xt,u1,u2,e1,yt)
  dfs <- df %>% tidyr::pivot_longer(c(x,xt,u1,u2,e1,yt))
  ggplot(data=dfs,aes(x=x,y=value,color=name)) + geom_point() + geom_line() + theme_classic()
  #ggplot(data=dfs,aes(x=xt,y=value,color=name)) + geom_point() + geom_line() + theme_classic()
  # evaluation
  t1 <- eval(parse(text='x'),list(x=x)) # Predetermined
  b1 <- eval(parse(text='1-x'),list(x=x))  # Predetermined
  rl <- eval(parse(text='lambda'),c(list(lambda=lambda),list(x=x))) # Enforced
  t2 <- rl-(b1-rl)/zeta # Combination
  b2 <- 1-t2
  at <- (t1+t2*zeta)/(zeta+1)
  ab <- (b1+b2*zeta)/(zeta+1)

  # Plot
  df <- data.frame(x,t1,b1,rl,t2,b2,at,ab)
  dfs <- df %>% tidyr::pivot_longer(c(t1,b1,rl,t2,b2,at,ab)) %>% subset(name%in%select)
  plot <- ggplot(data=dfs,aes(x=x,y=value,color=name)) + geom_point() + geom_line() + theme_classic()
  # output
  list(df=df,dfv=df[],plot=plot)
}
billiard <- function(){
  print(abc)
}
gpot <- function(df,name,title="",subtitle="",x="",y=""){
  ggplot(data=df,aes(x=ti,y=value,colour=name)) +
    geom_smooth(method='loess') +
    labs(title =title, x =x, y =y, subtitle = subtitle) +
    theme_classic()
}
unitroot <- function(poly=NULL,theta=0,increase=0.01){
	y <- eval(parse(text=poly),c(list(x=x)))
	x = seq(0,1,increase)
	xtt = cos(theta)*x-sin(theta)*y
	ytt = sin(theta)*x+cos(theta)*y
	plotframe <- data.frame(index=seq(0,1,0.01),x,y,xtt,ytt)
	ggplot2::ggplot(plotframe) +
		geom_point(aes(x=x,y=y)) +
		geom_point(aes(x=xtt,y=ytt)) +
                scale_x_continuous(limits=c(0, 1)) +
                scale_y_continuous(limits=c(0, 1)) +
		theme_classic()
}

#' @export
sortplot <- function(qdf=NULL,pis='pi_ind',scale_c=0.25,y=c(0,0.75),x=c(0,1)){

  ggplot2::ggplot(qdf) +
    geom_point(data=filter(qdf,name%in%c('x','y','alpha')),aes(x=pi_ind,y=value, color=name)) +
    geom_line(data=filter(qdf,name%in%c('pred1','pred2','pred3')),aes(x=pi_ind,y=value, color=name)) +
    labs(x="precinct",y="percentage",title="") +
    geom_point(aes(x=pi_ind,y=(zeta*scale_c)/max(zeta))) +
    geom_line(aes(x=pi_ind,y=(scale_c*mean(zeta))/max(zeta))) +
    scale_x_continuous(limits=c(x[1], x[2])) +
    scale_y_continuous(
      limits=c(y[1], y[2]),
      name = "Probability",
      sec.axis = sec_axis(~.*max(qdf$zeta)/scale_c, name="Zeta")
  )
}

resplot <- function(datadf=NULL,xt=NULL,yt=NULL,x_scale=c(-2.2)){
  ggplot2::ggplot(data=datadf,aes_string(x=xt,y=yt),) +
    geom_point() +
    geom_smooth(method = "lm", se = FALSE, col = "deeppink") +
    labs(caption = paste0("With fitted straight line model (R2)=",signif(summary(lm(datadf[[yt]]~datadf[[xt]]))$r.squared)),3)
#    scale_x_continuous(limits=c(-1.5,1.5))
    #scale_x_continuous(limits=c(x_scale[1], x_scale[2]))
    #scale_y_continuous(limits=c(0, 1))
}

### One characters
coupolybase <- function(dfage=state1_election_data,
			flist=list(lage=18,uage=100),
		        polyorder=TRUE,M=0,scale=NULL){

  agedatatidy <- dfage %>%
    dplyr::ungroup() %>%
    # Eligible voters
    dplyr::filter(age>=flist$lage) %>%
    dplyr::filter(age<=flist$uage) %>%
    dplyr::arrange(county,age) %>%
    dplyr::group_by(county,age) %>%
    # Population size among age groups
    dplyr::mutate(pop_real=sum(ifelse(status=='real',1,0))) %>%
    dplyr::mutate(pop_cred=sum(ifelse(status=='credit',1,0))) %>%
    dplyr::mutate(pop_all=pop_real+pop_cred) %>%
    # Registered among age groups
    dplyr::mutate(registered=sum(registered, na.rm=T)) %>%
    # Voting among age groups
    dplyr::mutate(voting=sum(voting, na.rm=T)) %>%
    dplyr::select(state,county,age,
		  pop_real,pop_cred,pop_all,
		  registered, voting) %>%
    # Geting rid of individual characteristics
    dplyr::distinct() %>%
    # Registration and voting ratios
    dplyr::mutate(rpopallratio=registered/pop_all) %>%
    dplyr::mutate(rpoprealratio=registered/pop_real) %>%
    dplyr::mutate(vregratio=voting/registered) %>%
    dplyr::group_by(county) %>%
    tidyr::nest() %>%
    dplyr::mutate(model1 = data %>% purrr::map(~lm(rpopallratio ~poly(age,polyorder,raw=T), data = .))) %>%
    dplyr::mutate(model2 = data %>% purrr::map(~lm(vregratio ~ poly(age,polyorder,raw=T), data = .))) %>%
    dplyr::mutate(pred1 = purrr::map2(model1, data, predict)) %>%
    dplyr::mutate(pred2 = purrr::map2(model2, data, predict)) %>%
    dplyr::select(-model1,-model2) %>%
    tidyr::unnest(c(pred1,pred2,data)) %>%
    # Overriding voter database
    dplyr::mutate(avgregpopratio=mean(pred1)) %>%
    dplyr::mutate(avgturnratio=mean(pred2))  %>%
    # Totals (predetermined)
    dplyr::mutate(t_pop_all=sum(pop_all)) %>%
    dplyr::mutate(t_pop_real=sum(pop_real)) %>%
    dplyr::mutate(t_pop_cred=sum(pop_cred)) %>%
    dplyr::mutate(t_registered=sum(registered)) %>%
    dplyr::mutate(t_voting=sum(voting)) %>%
    # Initial ratios
    dplyr::mutate(t_regpopratio=t_registered/t_pop_real) %>%
    dplyr::mutate(t_votregratio=t_voting/t_registered) %>%
    dplyr::mutate(regipred=pop_all*t_regpopratio*avgregpopratio) %>%
    dplyr::mutate(votipred=regipred*t_votregratio*avgturnratio) %>%
    {if(M) voterb_overriding(.,scale=scale) else . } %>%
    #! Consider
    drop_na() %>%
    dplyr::mutate(r_prederror=registered-regipred) %>%
    dplyr::mutate(b_prederror=voting-votipred) %>%
    dplyr::mutate(corr_reg=cor(regipred,registered)) %>%
    dplyr::mutate(corr_vot=cor(votipred,voting)) %>%
    dplyr::mutate(polyorder=polyorder) %>%
    dplyr::ungroup() %>%
    tidyr::pivot_longer(c(pop_all,pop_real,pop_cred,registered,voting,
			  avgregpopratio,avgturnratio,
		  regipred,votipred))

}
