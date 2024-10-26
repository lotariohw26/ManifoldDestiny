library(ggplot2)
library(dplyr)
library(ManifoldDestiny)
library(htmltools)
#######################################################################################################################################################
##### Proto example 1 and 2
P  <- c(1,2,3,4,5,6)
S  <- c(60,60,60,60,60,60)
T  <- c(40,40,40,40,40,40)
U  <- c(40,2*40,3*40,3*40,3*40,3*40)
V  <- c(60,2*60,3*60,3*40,3*40,3*40)
Up <- c(40,2*(40-5),3*(40-10),3*40,3*40,3*40)
Vp <- c(60,2*(60+5),3*(60+10),3*40,3*40,3*40)
R  <- c(200,2*200,3*200,3*200,3*200,3*200)
## Tower 1
ex1m <- as.matrix(cbind(P,R,S,T,U,V)) %>% as.data.frame()
towi <- as.data.frame(ex1m) %>%
	dplyr::mutate(EDVst=paste0(.[,3],"/",.[,4])) %>%
        dplyr::mutate(MIVst_1=paste0(.[1,5],"/",.[1,6])) %>%
        dplyr::mutate(MIVst_2=paste0(.[2,5]/2,"/",.[2,6]/2)) %>%
        dplyr::mutate(MIVst_3=paste0(.[2,6]/3,"/",.[3,6]/3)) %>%
        dplyr::select(7:10) %>%
        t() %>%
        data.frame() %>%
        data.table::setnames(paste0("Precinct ",1:6))
towi[3:4,1] <- ""
towi[4,2] <- ""
towi
## Tower 2
ex2m <- as.matrix(cbind(P,R,S,T,Up,Vp)) %>% as.data.frame()
towii <- as.data.frame(ex2m) %>%
	dplyr::mutate(EDVst=paste0(.[,3],"/",.[,4])) %>%
        dplyr::mutate(MIVst_1=paste0(.[1,5],"/",.[1,6])) %>%
        dplyr::mutate(MIVst_2=paste0(.[2,5]/2,"/",.[2,6]/2)) %>%
        dplyr::mutate(MIVst_3=paste0(.[2,6]/3,"/",.[3,6]/3)) %>%
        dplyr::select(7:10) %>%
        t() %>%
        data.frame() %>%
        data.table::setnames(paste0("Precinct ",1:6))
towii[3:4,1] <- ""
towii[4,2] <- ""
#########################################################################################################################################################
colnames(ex1m) <- c("P","R","S","T","U","V")
colnames(ex2m) <- c("P","R","S","T","U","V")
c1df <- Countinggraphs(ex1m)
c2df <- Countinggraphs(ex2m)
##########################################################################################################################################################
stfc1 <- dplyr::select(c1df$sdfc,all_of(c(stickers[[1]][[1]])))[1:3,]
stfc2 <- dplyr::select(c2df$sdfc,all_of(c(stickers[[1]][[1]])))[1:3,]
hyfc1 <- dplyr::select(c1df$sdfc,all_of(c(stickers[[1]][[2]])))[1:3,]
hyfc2 <- dplyr::select(c2df$sdfc,all_of(c(stickers[[1]][[2]])))[1:3,]
opfc1 <- dplyr::select(c1df$sdfc,all_of(c(stickers[[1]][[3]])))[1:3,]
opfc2 <- dplyr::select(c2df$sdfc,all_of(c(stickers[[1]][[3]])))[1:3,]
cx <- round(c1df$sdfc$x,2)
cy <- round(c1df$sdfc$y,2)
czeta <- round(c1df$sdfc$zeta,2)
calpha <- round(c1df$sdfc$alpha,2)
clambda <- round(c1df$sdfc$lamda,2)
cg <- round(c1df$sdfc$g,2)
ch <- round(c1df$sdfc$y,2)
cGamma <- round(c1df$sdfc$Gamma,2)


