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
#######################################################################################################################################################

