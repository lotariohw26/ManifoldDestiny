library(ggplot2)
library(dplyr)
library(ManifoldDestiny)
library(htmltools)
#######################################################################################################################################################
##### Proto example 1 and 2
P  <- c(1,2,3,4,5,6)
S  <- c(60,60,60,60,60,55)
T  <- c(40,40,40,40,40,40)
U  <- c(40,40,40,40,40,40)
V  <- c(60,60,60,40,40,40)
Up <- c(40,(40-5),(40-10),40,40,40)
Vp <- c(60,(60+5),(60+10),40,40,40)
R  <- c(200,200,200,200,200,200)
## Tower 1
ex1m <- as.matrix(cbind(S,T,U,V))
towi <- as.data.frame(ex1m) %>% 
  dplyr::mutate(EDVst=paste0(.[,1],"/",.[,2])) %>%
  dplyr::mutate(MIVst_1=paste0(.[1,3],"/",.[1,4])) %>%
  dplyr::mutate(MIVst_2=paste0(.[2,3],"/",.[2,4])) %>%
  dplyr::mutate(MIVst_3=paste0(.[3,3],"/",.[3,4])) %>%
  dplyr::select(5:8) %>%
  t() %>%
  data.frame() %>%
  data.table::setnames(paste0("Precinct ",1:6))
towi[3:4,1] <- ""
towi[4,2] <- ""
## Tower 2
ex2m <- as.matrix(cbind(S,T,Up,Vp))
towii <- as.data.frame(ex2m) %>% 
  dplyr::mutate(EDVst=paste0(.[,1],"/",.[,2])) %>%
  dplyr::mutate(MIVst_1=paste0(.[1,3],"/",.[1,4])) %>%
  dplyr::mutate(MIVst_2=paste0(.[2,3],"/",.[2,4])) %>%
  dplyr::mutate(MIVst_3=paste0(.[3,3],"/",.[3,4])) %>%
  dplyr::select(5:8) %>%
  t() %>%
  data.frame() %>%
  data.table::setnames(paste0("Precinct ",1:6))
towii[3:4,1] <- ""
towii[4,2] <- ""
#towi
#towii
#########################################################################################################################################################
pro_rec_ex1_e <- data.frame(P=c(1,2,3,4,5,6),S=S,T=T,U=U,V=V,R=R)
pro_rec_ex2_e <- data.frame(P=c(1,2,3,4,5,6),S=S,T=T,U=Up,V=Vp,R=R) 
pro_rec_ex1 <- pro_rec_ex1_e[1:3,]
pro_rec_ex2 <- pro_rec_ex2_e[1:3,]
pro_elc_ex1 <- Countinggraphs(pro_rec_ex1)
pro_elc_ex2 <- Countinggraphs(pro_rec_ex2)
cx <- round(pro_elc_ex1$sdfc$x,2)
cy <- round(pro_elc_ex1$sdfc$y,2)
czeta <- round(pro_elc_ex1$sdfc$zeta,2)
calpha <- round(pro_elc_ex1$sdfc$alpha,2)
clambda <- round(pro_elc_ex1$sdfc$lamda,2)
cg <- round(pro_elc_ex1$sdfc$g,2)
ch <- round(pro_elc_ex1$sdfc$y,2)
cGamma <- round(pro_elc_ex1$sdfc$Gamma,2)
##########################################################################################################################################################

