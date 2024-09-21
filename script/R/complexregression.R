##########################################################################################################
comdat <- function(dr=goext){
  P <- dr['P']
  le <- dim(P)[1]
  dr <- dplyr::arrange(dr,P)
  ### Data
  #if (is.null(dr[[zv[1]]])) {zv[[1]]<- rep(0,le)}
  #if (is.null(dr[[zv[2]]])) {zv[[2]]<- rep(0,le)}
  #if (is.null(dr[[xv[1]]])) {xv[[1]]<- rep(0,le)}
  #if (is.null(dr[[xv[2]]])) {xv[[2]]<- rep(0,le)}
  #if (is.null(dr[[yv[1]]])) {yv[[1]]<- rep(0,le)}
  #if (is.null(dr[[yv[2]]])) {yv[[2]]<- rep(0,le)}
  z0 <- complex(real=rep(1,le),imaginary=rep(0,le))
  x0 <- complex(real=rep(1,le),imaginary=rep(0,le))
  y0 <- complex(real=rep(1,le),imaginary=rep(0,le))
  zi <- complex(real=dr[['z1']],imaginary=dr[['z2']])
  xi <- complex(real=dr[['x1']],imaginary=dr[['x2']])
  yi <- complex(real=dr[['y1']],imaginary=dr[['y2']])
  vin <- data.frame(z0,x0,y0,zi,xi,yi)
  cvar <- c('x0y0','x0y1','x1y0','x0y2','x1y1','x2y0','x0y3','x1y2','x2y1','x3y0')
  oc <- sapply(cvar,function(cn){
  rp <- as.numeric(substr(cn,2,2))
  cp <- as.numeric(substr(cn,4,4))
  xn <- xi^rp
  yn <- yi^cp
  fp <- Re(xn)*Re(yn)-Im(xn)*Im(yn)
  sp <- Re(xn)*Im(yn)+Im(xn)*Re(yn)
  complex(real=fp,imaginary=sp)
  })
  dfX <- dplyr::bind_cols(as.data.frame(z0),as.data.frame(oc))
}
#' @export olsce
olsce <- function(dr=goext){
	browser()
  Y <- as.matrix(dplyr::select(dr,names(dr)[1]))
  X <- as.matrix(dplyr::select(dr,names(dr)[-1]))
  ### Estimated coefficients
  slv <- solve(Conj(t(X)) %*% X, Conj(t(X)) %*% Y)
  beta_cr <- complex(real=Re(slv),imaginary=Im(slv))
  ex_o <- X %*% as.vector(beta_cr)
  ##
  res <- complex(real=Re(ex_o)-Re(Y),imaginary=0)
  tss <- complex(real=Re(Y)-Re(mean(ex_o)),imaginary=0)
  RSS <- complex(real=Re(res)^2-Im(res)^2, imaginary=2*Re(res)*Im(res))
  TSS <- complex(real=Re(tss)^2-Im(tss)^2, imaginary=2*Re(tss)*Im(tss))
  vecsq <- c(sum(Re(RSS)),sum(Im(RSS)),sum(Re(TSS)),sum(Im(TSS)))
  rc <-sqrt(vecsq[1]^2+vecsq[2]^2)
  tc <-sqrt(vecsq[3]^2+vecsq[4]^2)
  r2I <- 1-rc/tc
  list(beta=beta_cr,r2=r2I)
}
##########################################################################################################
library(ManifoldDestiny)
library(ggplot2)
library(dplyr)
##########################################################################################################
# I
set.seed(4242)
n <- 8
slop <- complex(real = 4.23, imaginary = 2.323)
interc <- complex(real = 1.4, imaginary = 1.804)
e <- complex(real=rnorm(n)/6, imaginary=rnorm(n)/6)
xx <- complex(real= rnorm(n), imaginary= rnorm(n))
yy <- complex(real= rnorm(n), imaginary= rnorm(n))
tframecom <- data.frame(x= xx,y=yy, z= slop*xx + slop*yy + interc + e)
tframerel <- tframecom %>% dplyr::mutate(P=row_number(),z=as.complex(z),x=as.complex(x),y =as.complex(y),z1=Re(z),z2= Im(z),x1=Re(x),x2=Im(x),y1=Re(y),y2=Im(y)) %>% select(P,z1,z2,y1,y2,x1,x2)
# II
baldata <- apn3n
WS <- Sys.info()[['sysname']]=="Emscripten"
da <- baldata[[1]]
md <- baldata[[2]]
frm <- as.numeric(md$sol$fr)
##########################################################################################################
# A
complexlm::lm(z ~ x + y, data = tframecom, weights = rep(1,n))
# I
# II
# B
# I
# II
abc <- comdat(dr=tframerel)
olsce(abc)
View(abc)






