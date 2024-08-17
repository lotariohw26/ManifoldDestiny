ManifoldDestiny::wasmconload()
source(paste0(rprojroot::find_rstudio_root_file(),"/R/wasmconverting.R"))
source(paste0(rprojroot::find_rstudio_root_file(),"/R/wasmnonverting.R"))
apps <- appn0
adat <- apps[[1]]
amet <- apps[[2]]
###########################################################################################################
###########################################################################################################
selr <- selreport(apps)
selo <- seloutput(selr)
##########################################################################################################
cob <- Countinggraphs(adat,selvar=names(adat))
sum(dplyr::select(cob$rdfci,S,T,U,V))
prma <- c(24,50,58,62,112,121,146)
cob$purging(z=amet$prg$z,pri=1,prma=prma) 
cob$purdf
cob$plext(2)
sum(dplyr::select(cob$rdfce,S,T,U,V))
def <- Estimation(cob$rdfce)
def$regression("alpha=k0 + k1*g + k2*h")
summary(def$regsum[[1]])
# Call:
# lm(formula = formo, data = edfc)
# 
# Residuals:
#       Min        1Q    Median        3Q       Max 
# -0.051962 -0.002965  0.001530  0.004318  0.117321 
# 
# Coefficients:
#              Estimate Std. Error t value Pr(>|t|)    
# (Intercept) -0.005351   0.002288  -2.338   0.0203 *  
# g            0.680345   0.007584  89.709   <2e-16 ***
# h            0.322876   0.006142  52.571   <2e-16 ***
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 0.014 on 215 degrees of freedom
# Multiple R-squared:  0.9931,	Adjusted R-squared:  0.9931 
# F-statistic: 1.554e+04 on 2 and 215 DF,  p-value: < 2.2e-16
# Call:
# lm(formula = formo, data = edfc)
# 
# Residuals:
#       Min        1Q    Median        3Q       Max 
# -0.051962 -0.002965  0.001530  0.004318  0.117321 
# 
# Coefficients:
#              Estimate Std. Error t value Pr(>|t|)    
# (Intercept) -0.005351   0.002288  -2.338   0.0203 *  
# g            0.680345   0.007584  89.709   <2e-16 ***
# h            0.322876   0.006142  52.571   <2e-16 ***
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 0.014 on 215 degrees of freedom
# Multiple R-squared:  0.9931,	Adjusted R-squared:  0.9931 
# F-statistic: 1.554e+04 on 2 and 215 DF,  p-value: < 2.2e-16

url <- "https://docs.google.com/spreadsheets/d/1ePxTwcx6LFL8pW8SZfx5iZgqZeCUzXY3bUQiFUYncgg/edit?gid=486042717#gid=486042717"
eddf <- googlesheets4::read_sheet(url,range="B14:AQ232") 
lodf <- dplyr::bind_cols(cob$rdfce)
names(eddf)
names(lodf)
pn1 <- as.numeric(eddf[['P#']])
pn2 <- as.numeric(lodf[['P']])
setdiff(pn2,pn1)



setdiff(as.numeric(eddf[['P#']]),as.numeric(lodf[['P']]))
# Call:
# lm(formula = formo, data = edfc)
# 
# Residuals:
#       Min        1Q    Median        3Q       Max 
# -0.052682 -0.002621  0.001438  0.004241  0.118985 
# 
# Coefficients:
#              Estimate Std. Error t value Pr(>|t|)    
# (Intercept) -0.005174   0.002330  -2.221   0.0274 *  
# g            0.682950   0.007539  90.586   <2e-16 ***
# h            0.320726   0.006140  52.237   <2e-16 ***
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 0.01433 on 221 degrees of freedom
# Multiple R-squared:  0.9927,	Adjusted R-squared:  0.9926 
# F-statistic: 1.505e+04 on 2 and 221 DF,  p-value: < 2.2e-16
def$regression("alpha=k0 + k1*g + k2*h + k3*g**2 + k4*h**2 + k5*g*h + k6*h**3 + k7*g*h + k8*g**2*h + k9*g*h**2")
summary(def$regsum[[1]])
# Call:
# lm(formula = formo, data = edfc)
# 
# Residuals:
#        Min         1Q     Median         3Q        Max 
# -0.0221020 -0.0024807 -0.0004238  0.0016570  0.0187834 
# 
# Coefficients:
#              Estimate Std. Error t value Pr(>|t|)    
# (Intercept) -0.004671   0.001913  -2.442  0.01542 *  
# g            0.519016   0.039236  13.228  < 2e-16 ***
# h            0.490453   0.027226  18.014  < 2e-16 ***
# g2          -0.461339   0.079582  -5.797 2.46e-08 ***
# h2          -1.064771   0.073186 -14.549  < 2e-16 ***
# gh           1.582198   0.124267  12.732  < 2e-16 ***
# h3           1.033464   0.050182  20.594  < 2e-16 ***
# g2h          0.381111   0.120575   3.161  0.00181 ** 
# gh2         -1.521376   0.122816 -12.387  < 2e-16 ***
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 0.005073 on 209 degrees of freedom
# Multiple R-squared:  0.9991,	Adjusted R-squared:  0.9991 
# F-statistic: 2.976e+04 on 8 and 209 DF,  p-value: < 2.2e-16
# Call:
# lm(formula = formo, data = edfc)
# 
# Residuals:
#       Min        1Q    Median        3Q       Max 
# -0.020968 -0.002704 -0.000306  0.002068  0.038004 
# 
# Coefficients:
#              Estimate Std. Error t value Pr(>|t|)    
# (Intercept) -0.005287   0.002405  -2.198  0.02902 *  
# g            0.458546   0.046417   9.879  < 2e-16 ***
# h            0.530002   0.031855  16.638  < 2e-16 ***
# g2          -0.312511   0.094160  -3.319  0.00106 ** 
# h2          -1.115004   0.086393 -12.906  < 2e-16 ***
# gh           1.564990   0.152580  10.257  < 2e-16 ***
# h3           1.038567   0.059782  17.373  < 2e-16 ***
# g2h          0.184697   0.145090   1.273  0.20440    
# gh2         -1.402066   0.151996  -9.224  < 2e-16 ***


# ---
googlesheets4::gs4_auth(email="jorn.halvorsen@gmail.com")
library(googlesheets4)
abc <- gs4_create("abc",sheets =cob$rdfce)
gs4_browse(abc)
#want to open it in a browser

cob$rdfce



# libraries
ManifoldDestiny::wasmconload()
library(usethis)
qenvae <- yaml::yaml.load_file(paste0(rprojroot::find_rstudio_root_file(),"/_apps_rel.yml"))
qenvas <- yaml::yaml.load_file(paste0(rprojroot::find_rstudio_root_file(),"/_apps_sim.yml"))
googlesheets4::gs4_auth(email="lotariohw26@gmail.com")
#######################################################################################################################################################
# Applications
recoudatr(qenvae$appn0)

cob$rdfci

head(iris)
lm()






















apps <- appn0
adat <- apps[[1]]
amet <- apps[[2]]
selo <- seloutput(selreport(apps))
View(selo[[1]])

fopl <- cogr$polyc[[1]][[1]]
options(digits = 2)                                                                                               


View(co$rdfc)
#ifelse(Sys.info()[['sysname']]==
#
#
#if(Sys.info()[['sysname']]=="Emscripten")

































ManifoldDestiny::wasmconload()
source(paste0(rprojroot::find_rstudio_root_file(),"/R/wasmconverting.R"))
source(paste0(rprojroot::find_rstudio_root_file(),"/R/wasmnonverting.R"))
###########################################################################################################
###########################################################################################################
apps <- app1
adat <- apps[[1]]
amet <- apps[[2]]
rept <- seloutput(selreport(apps))



rept[[7]]
amet$sol$ro[[1]]
###########################################################################################################
googlesheets4::gs4_auth(email="lotariohw26@gmail.com")
url <- "https://docs.google.com/spreadsheets/d/1ofLpFcJ1Y-Wmwi5w1YqNELo9Cz_Pia8yULmCXeL_YGg/edit?gid=1381547233#gid=1381547233"
gsh <- googlesheets4::read_sheet(url,sheet=1,range="H1:K311") %>% 
	dplyr::mutate(P=row_number()) %>% 
	dplyr::mutate(N=S+T+U+V) %>% 
	dplyr::mutate(across(where(is.list), ~ as.character(.x))) 

abc <- erotation(dfe=gsh,sev=c("N","S","V"),rs=c(1,4,2),gra=c(14.378100,49.762610,11.578100),med=F)

View(abc)
###########################################################################################################



url <- "https://docs.google.com/spreadsheets/d/1IYZEi4WnbyZ5PhOZPFV1h6wO3w2e59qL5l7JJZ3Illw/edit?gid=0#gid=0"
gsh <- googlesheets4::read_sheet(url,sheet=1,range="B1:D609") %>% dplyr::mutate(P=row_number())


  rpar





###########################################################################################################
apps <- appn7
adat <- apps[[1]]
amet <- apps[[2]]
cob <- Countinggraphs(adat,selvar=names(adat))
cob$purging() 
cob$rotation() 



def <- Estimation(cob$rdfc)
def$regression("alpha=k0+k1*h+k2*g")

apps <- appsn
adat <- apps[[1]]
amet <- apps[[2]]


cob <- Countinggraphs(adat,selvar=names(adat))
cob$sortpre(4,3)
cob$plot2d(4,labs=list(title=NULL,x="precinct (normalized)",y="percentage",caption=NULL,alpha=0.4,size=0.5))
summary(selreport(apps)[[3]]$regsum[[1]])
rept <- seloutput(selreport(apps))
ggplot2::geom_point(data=filter(longdf,name%in%psel),ggplot2::aes(x=pri,y=value, color=name),size=labs$size,alpha=labs$alpha) +
ggplot2::geom_line(data=filter(longdf,name%in%paste0(psel,'_pred')),ggplot2::aes(x=pri,y=value, color=name)) 

pselv <- list(psel,psel[c(1,2,3)])[[1]]








#cogr <- Countinggraphs(apps[[1]])
selo <- seloutput(selreport(apps))
# selo[[9]]
# 2+2
#    variable        mean          std
# 1         S 225.8740280 146.59610622
# 2         T 161.1524106  95.48720096
# 3         U 139.4580093  92.04209506
# 4         V 299.0699844 155.52902991
# 5         R 475.0000000   0.00000000
# 6         Z 825.5544323 428.50270642
# 7     alpha   0.4344682   0.12523752
# 8         x   0.5680787   0.14870506
# 9         y   0.3160804   0.10300514
# 10     zeta   1.2202827   0.39134298
# 11    lamda   0.6352896   0.03633607
# 12    Omega   0.4625320   0.07192205
# 13        g   0.4164133   0.13239803
# 14        h   0.4641927   0.15169350
# 15    Gamma   0.5794922   0.09555612
# 16        m   0.3431554   0.06857900
# 17        n   0.6073394   0.08474312
# 18       xi   1.5935878   1.34377116
#    variable        mean          std
# 1         S 225.8740280 146.59610622
# 2         T 161.1524106  95.48720096
# 3         U 139.4580093  92.04209506
# 4         V 299.0699844 155.52902991
# 5         R 475.0000000   0.00000000
# 6         Z 825.5544323 428.50270642
# 7     alpha   0.4344682   0.12523752
# 8         x   0.5680787   0.14870506
# 9         y   0.3160804   0.10300514
# 10     zeta   1.2202827   0.39134298
# 11    lamda   0.6352896   0.03633607
# 12    Omega   0.4625320   0.07192205
# 13        g   0.4164133   0.13239803
# 14        h   0.4641927   0.15169350
# 15    Gamma   0.5794922   0.09555612
# 16        m   0.3431554   0.06857900
# 17        n   0.6073394   0.08474312
# 18       xi   1.5935878   1.34377116
#    variable        mean          std
# 1         S 225.8740280 146.59610622
# 2         T 161.1524106  95.48720096
# 3         U 139.4580093  92.04209506
# 4         V 299.0699844 155.52902991
# 5         R 475.0000000   0.00000000
# 6         Z 825.5544323 428.50270642
# 7     alpha   0.4344682   0.12523752
# 8         x   0.5680787   0.14870506
# 9         y   0.3160804   0.10300514
# 10     zeta   1.2202827   0.39134298
# 11    lamda   0.6352896   0.03633607
# 12    Omega   0.4625320   0.07192205
# 13        g   0.4164133   0.13239803
# 14        h   0.4641927   0.15169350
# 15    Gamma   0.5794922   0.09555612
# 16        m   0.3431554   0.06857900
# 17        n   0.6073394   0.08474312
# 18       xi   1.5935878   1.34377116


copl <- cogr$polyc[[1]][[1]]








###########################################################################################################
# Applications
appt <- app1
# Report
rept <- seloutput(selreport(appt))
rept[[10]]
# Componenta
## Counting
sum(dplyr::select(appt[[1]],S,T,U,V))
abc <- Countingprocess(appt[[1]])
abc$rdfci
## Estimation
def <- Estimation(abc$rdfci)
def$regression("alpha=k0+k1*h+k2*g")
summary(def$regsum[[1]])
###########################################################################################################










ManifoldDestiny::wasmconload()
modlat <- eqpar$meql
laws_df1 <- ManifoldDestiny::eqdef$meql
laws_df2 <- ManifoldDestiny::eqdef$meqs
source(paste0(rprojroot::find_rstudio_root_file(),'/script/R/stylized.R'))
ssr <- selreport(ManifoldDestiny::appsn)
rsr  <- selreport(ManifoldDestiny::apprn)


polynomial(unname(ssr[[1]]$polyc[[1]]$coefficients))


polynomial(ssr[[1]]$polyc[[2]])



polynom::polynomial(unname(ssr[[1]]$polyc[[1]]))
ssr[[1]]$desms[7,2]


polynom::integral(unname(ssr[[1]]$polyc[1]),c(0,1),3)


		  polynom::integral(ssr[[1]]$polyc,c(0,1),3)
unname(ssr[[1]]$polyc[1])










#abc$descriptive(2)
#abc$desms
#abc[[1]]
#abc[[2]]
#abc[[3]]
#abc[[4]]
#abc[[5]]
#abc[[6]]
#abc[[7]]
#abc[[8]]
#abc[[9]]
#abc[[10]]
#abc[[11]]
#abc[[12]]
###########################################################################################################
### Residual
dfm <- (function(x){data.frame(P=seq(1,x),RV=as.integer(rnorm(x,100,30)))})(100)
probw <- c(m=0.51,s=0.10)
probva <- c(vdm=0.7,mdm=0.4,vds=0.10,mds=0.10)
probvb <- c(vdm=0.5,mdm=0.6,vds=0.10,mds=0.10)
ztech <- c(0,1)	
app_bal <- ballcastsim(dfm,probw,probva,probvb,ztech)
########## Normal form
###########################################################################################################
###########################################################################################################
### Loss-function
# Define the loss function
### Structure
loss_function <- function(x) {
  # This is a dummy loss function
  # Replace this with your actual function
  return((x[1] - 5)^2 + (x[2] - 3)^2)
}
# Define the constraints
lower_bounds <- c(0, 1)  # Example lower bounds for x[1] and x[2]
upper_bounds <- c(10, 6)  # Example upper bounds for x[1] and x[2]
# Set initial values for x[1] and x[2]
initial_values <- c(0, 0)
# Use optim() to minimize the loss function
result <- optim(
  par = initial_values,
  fn = loss_function,
  method = "L-BFGS-B",
  lower = lower_bounds,
  upper = upper_bounds,
  hessian = TRUE
)
### Applications
app_ex1_cou <- Countinggraphs(app_bal)
pri_int_ex1 <- app_ex1_cou$polyc[[1]][[1]]
app_ex1_cou$sortpre()
app_ex1_cou$mansys(sygen=list(frm=1,
			      pre=c("alpha","x","y"),
			      end=c("zeta","lamda"),
			      me=c(plnr=1,rot=0),
			      lf="(alpha-alpha_s)^2"))
app_ex1_cou$setres(0.25,1)
app_ex1_cou$manimp(init_par=c(k0=0.0,k1=0.50,k2=0.50),man=true,wn=c(0,0.0),4)
app_ex1_cou$loss_ls[[1]]
app_ex1_cou$loss_ls[[2]]
app_ex1_cou$loss_ls[[3]]
app_ex1_cou$loss_ls[[4]]
app_ex1_cou$loss_ls[[5]]
mean(app_ex1_cou$rdfci$x-app_ex1_cou$rdfc$x)
###########################################################################################################
###########################################################################################################
###########################################################################################################
### Complex estimation
googlesheets4::gs4_auth(email="lotariohw26@gmail.com")
marcdf <- googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1FxJg9hjU-M1MIeKl0koiHDVIp2dPAmm3nJpRzd5Ejdg/edit#gid=811418100",range="A5:N578",sheet="Bounded Tabulations") %>% dplyr::select(1,2,3,4,11:14) %>% dplyr::rename(R=Registered) %>% dplyr::rename_at(1,~"P") %>% dplyr::select(-2)
co <- Countinggraphs(marcdf,names(marcdf))$sdfc %>% dplyr::arrange(P) %>% dplyr::mutate(Psi_s=S/R,Psi_t=T/R) 
la <- olsce(co)
la
#
bal <- app_3_bal[[1]] %>% dplyr::select(-PN) %>% dplyr::mutate(Psi_s=S/R,Psi_t=T/R)
co <- Countinggraphs(bal,names(bal))
co$purging(c(S=50,T=50,U=50,V=50),c(0.05,0.95))
com <- olsce(co$rdfc)
###########################################################################################################
###########################################################################################################
### Rotation estimation
frm <- 2
slv2 <- c('alpha'='k0+k1*h+k2*g+k3*h**2+k4*g*h+k5*g**2+k6*h**3+k7*h**2*g+k8*h*g**2+k9*g**3',solvf='g',root=1)
app4 <- get(load(paste0(rprojroot::find_rstudio_root_file(),"/data/app4.rda")))
co <- Countinggraphs(app4)
#co$purging(regr=list(c('alpha=k0+k1*x+k2*y'),rnr=0))
#co$plext()
co$sortpre(frm)
co$descriptive(frm)
co$r2siminput(frm)
co$plot2d(frm)
co$plotxy(frm)
co$resplot(frm)
co$plotly3d(partition=frm)
co$gridarrange()
co$rotation(selvar=c('Z','S','V'), 
	    rpar=c(theta=0.2509451852,phi=0.8685213889,rho=0.2020759661),
	    rs=c(1,4,2),
	    mmeanv=c(710.76471,257.67059,151.07059),
	    sli=50)
co$rotgraph()
#co$rotplotly
edf1 <- c('z=k0+k1*x+k2*y')
edf2 <- c('z=k0+k1*x+k2*y+k3*x**2+k4*xy+k5*y**2')
edf3 <- c('z=k0+k1*x+k2*y+k3*x**2+k4*xy+k5*y**2+k6*x**3+k7*x**2*y+k8*y**2*x+k9*y**3')
re <- Estimation(co$rdfc[-nrow(co$rdfc),],frm)
re$regression(regequ=edf3)
summary(re$regsum[[1]])
# I
re$hat_predict("Z")
re$lpy[[1]]
lh1 <- re$lpy[[3]]
rh1 <- names(lh1)
test_df <- re$predict_df %>% dplyr::arrange(P) %>% dplyr::mutate(!!!re$kvec) %>% 
	dplyr::mutate(!!!setNames(lapply(lh1, rlang::parse_expr), rh1)) %>%
	dplyr::select(a1,a2,a3,b1,b2,b3,c1,c2,c3) %>% unique()
co$rdfc
utrop <- as.vector(unlist(test_df))
names(utrop) <- names(test_df)
utrop
# II
re$lpy[[2]]
sum(re$kvec)
-9.133800587+0.9248040739+0.4999950756+0.0003072921398-0.001067515909+0.001234044778-0.0000004290742453+0.000001473410171-0.000000441238549-0.0000016015018
nra <- 4
rh2 <- as.list(re$lpy[[2]]$expr)[1:nra]
lh2 <- as.list(re$lpy[[2]]$d)[1:nra]
rh3 <- as.list(re$lpy[[2]]$expr2)[1:nra]
lh3 <- as.list(paste0(re$lpy[[2]]$d,"_C"))[1:nra]
test_df2 <- re$predict_df %>% dplyr::arrange(P) %>% 
	dplyr::mutate(!!!re$kvec) %>%
	dplyr::mutate(!!!utrop) %>%
	dplyr::mutate(!!!setNames(lapply(rh2, rlang::parse_expr), lh2)) %>%
	#dplyr::mutate(!!!setNames(lapply(rh3, rlang::parse_expr), lh3)) %>%
	dplyr::select(as.vector(unlist(c(lh2)))) %>%
	#dplyr::select(as.vector(unlist(c(lh2,lh3)))) %>%
	base::unique()
unlist(test_df2)
summary(re$regsum[[2]])
###########################################################################################################
##########
### Complex STUV
frm <- 1
P  <- c(1,2,3,4,5,6)
S  <- c(60,60,60,60,60,55)
T  <- c(40,40,40,40,40,40)
U  <- c(40,40*2,40*3,40*4,40*5,40*6)
V  <- c(60,60*2,60*3,40*4,40*5,40*6)
Up <- c(40,40*2-5,40*3-15,40*4,40*5,40*6)
Vp <- c(60,60*2+5,60*3+15,40*4,40*5,40*6)
R  <- c(200,200*2,200*3,200*4,200*5,200*6)
pro_rec_ex1_e <- data.frame(P=c(1,2,3,4,5,6),S=S,T=T,U=U,V=V,R=R)
pro_rec_ex2_e <- data.frame(P=c(1,2,3,4,5,6),S=S,T=T,U=Up,V=Vp,R=R) 
clipr::write_clip(pro_rec_ex1_e)
clipr::write_clip(pro_rec_ex2_e)
co <- Countinggraphs(list(pro_rec_ex1_e,pro_rec_ex1_e)[[frm]])
co$purging()
co$plext()
co$sortpre(frm)
co$descriptive(frm)
co$r2siminput(frm)
co$plot2d(frm)
co$plotxy(frm)
co$resplot(frm)
co$plotly3d(partition=frm)
co$rotation()
co$rotgraph()
co$rotplotly
co$gridarrange()
re <- Estimation(co$rdfc,frm)
re$regression(c(alpha="k0+k1*x+k2*y",alpha="k0+k1*g+k2*h")[frm])
summary(re$regsum[[1]])
re$hat_predict(svf=c("y","g")[frm],rnr=1)
summary(re$regsum[[2]])
re$hat_intcomp()
re$comdesc
summary(re$regsum[[3]])
result <- sapply(dfv, function(x){ browser() #eval(parse(text = x))
	 })
dfr <- co$rofc %>% lapply(dfv, function(x){print(dfv[x])})
### Ongoing: Rotation
frm  <- 2
app_c_bal <- app_7_bal
sum(dplyr::select(app_c_bal[[1]],B1,B2,B3))
co <- Countinggraphs(app_c_bal[[1]],selvar=names(app_c_bal[[1]]))
co$purging(rep(30,4))
#co$rotation(c('alpha','h','g'),c(theta=-0.8,-0.25,-0.6),c(1,4,6),NULL,sli=50)
co$plext()
#co$sortpre(frm)
#co$descriptive(frm)
#co$r2siminput(frm)
#co$plot2d(frm)
#co$plotxy(frm)
#co$resplot(frm)
#co$plotly3d(partition=frm)
#co$gridarrange()
edf1 <- c(g='k0+k1*h+k2*alpha+ 
	  k3*h**2+k4*alpha*h+k5*alpha**2+
	  k6*h**3+k7*alpha*h**2+k8*alpha2*h+k9*alpha***3'
)
re <- Estimation(co$rdfce,frm)
re$regression(edf1)
re$diagnostics()
re$resplots[[1]][[1]]
summary(re$regsum[[1]])
re$
hist(rnorm(100, mean = 5, sd = 3))
hist(runif(100, min = 2, max = 4))
shapiro.test(rnorm(100, mean = 5, sd = 3))
shapiro.test(runif(100, min = 2, max = 4))
slv4 <- c('alpha'='k0+k1*h+k2*g+k3*h**2+k4*g*h+k5*g**2+k6*h**3+k7*h**2*g+k8*h*g**2+k9*g**3',solvf='g',root=1)
app_c_bal <- app_5_bal
co <- Countinggraphs(app_c_bal[[1]])
co$purging()
co$plext()
co$sortpre(frm)
co$descriptive(frm)
co$r2siminput(frm)
co$plot2d(frm)
co$plotxy(frm)
co$resplot(frm)
co$plotly3d(partition=frm)
co$gridarrange()
re <- Estimation(co$rdfce,frm)
re$regression(slv4[1])
re$hat_predict("g",1)
summary(lm(as.formula('S~S_hat'),data=re$compare))
re$comdesc
library(googlesheets4)
ls(package:googlesheets4)
sheet_write(iris,"",sheet=5)
#gs4_auth(scopes = "https://www.googleapis.com/auth/spreadsheets")
#https://developers.google.com/identity/protocols/oauth2/scopes
