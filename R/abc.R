def <- function(cdf=NULL,kve=NULL,plr=3,svar='g'){
  names(kve) <- paste0("k",0:(length(kve)-1))
  vmat <- c(unique(cdf$st1),unique(cdf$st2),unique(cdf$st3))
  pyg <- py_genpolycoeff(plr=plr,parm=c("alpha", "y", "x"),solv='y',grd=1,eur=vmat)
  abcv <- setNames(sapply(pyg[[2]][1:9], as.character), paste(rep(c("a", "b", "c"), each = 3), 1:3, sep = ""))
  ABCDEv <- setNames(sapply(pyg[[1]], as.character),c("A","B","C","D","E"))

  #View(outabc)
  outabc <- cdf %>% dplyr::mutate(!!!kve)%>%
      dplyr::mutate(a1=pareq(abcv[1],c(as.list(.[,])))) %>%
      dplyr::mutate(a2=pareq(abcv[2],c(as.list(.[,])))) %>%
      dplyr::mutate(a3=pareq(abcv[3],c(as.list(.[,])))) %>%  
      dplyr::mutate(b1=pareq(abcv[4],c(as.list(.[,])))) %>%
      dplyr::mutate(b2=pareq(abcv[5],c(as.list(.[,])))) %>%
      dplyr::mutate(b3=pareq(abcv[6],c(as.list(.[,])))) %>%
      dplyr::mutate(c1=pareq(abcv[7],c(as.list(.[,])))) %>%
      dplyr::mutate(c2=pareq(abcv[8],c(as.list(.[,])))) %>%
      dplyr::mutate(c3=pareq(abcv[9],c(as.list(.[,])))) %>%
      dplyr::mutate(A=pareq(ABCDEv[1],c(as.list(.[,])))) %>%
      dplyr::mutate(B=pareq(ABCDEv[2],c(as.list(.[,])))) %>%
      dplyr::mutate(C=pareq(ABCDEv[3],c(as.list(.[,])))) %>%
      dplyr::mutate(D=pareq(ABCDEv[4],c(as.list(.[,])))) %>%
      dplyr::mutate(E=pareq(ABCDEv[5],c(as.list(.[,])))) %>%
      dplyr::group_by(P) %>%
      dplyr::mutate(polsolv=py_polysolver(plr-1,c(A,B,C,D,E)[1:plr])) %>%
      #dplyr::mutate(polsolv=py_polysolverW(pnr-1,c(A,B,C,D,E)[1:pnr])) %>%
      dplyr::mutate(!!paste0("polsolvreal"):=Re(polsolv[1])) %>%
      dplyr::ungroup()


}

##' @export manobj
#manobj <- function(enfl=NULL,dfa=NULL,svar='y'){
#  polyc <- setNames(as.vector(lapply(enfl[[1]], as.character)),LETTERS[1:5])
#  la_e <- unlist(polyc[c(LETTERS[1:5])])
#  pnr <- sum(la_e!="0")
#  rootdf <- dfa  %>%
#    dplyr::mutate(A=pareq(la_e[1],c(as.list(.[,])))) %>%
#    dplyr::mutate(B=pareq(la_e[2],c(as.list(.[,])))) %>%
#    dplyr::mutate(C=pareq(la_e[3],c(as.list(.[,])))) %>%
#    dplyr::mutate(D=pareq(la_e[3],c(as.list(.[,])))) %>%
#    dplyr::mutate(E=pareq(la_e[3],c(as.list(.[,])))) %>%
#    dplyr::group_by(P) %>%
#    #dplyr::mutate(polsolv=py_polysolverW(pnr-1,c(A,B,C,D,E)[1:pnr])) %>%
#    dplyr::mutate(polsolv=py_polysolver(pnr-1,c(A,B,C,D,E)[1:pnr])) %>%
#    dplyr::mutate(!!paste0(svar):=Re(polsolv[1])) %>%
#    dplyr::ungroup()
#  rootdf[[svar]]
#}

#' @export olsce
olsce <- function(dr=goext,ce=NULL,zv=c('alpha','NULL'),xv=c('lamda','Psi_s'),yv=c('lamda','Psi_t')){
  P <- dr['P']
  le <- dim(P)[1]
  dr <- dplyr::arrange(dr,P)
  ### Data
  if (is.null(zv[2])) zv[[2]]<- rep(0,le)
  z0 <- complex(real=dr[[zv[1]]],imaginary=)
  x0 <- complex(real=rep(1,le),imaginary=rep(0,le))
  y0 <- complex(real=rep(1,le),imaginary=rep(0,le))
  xi <- complex(real=dr[[xv[1]]],imaginary=dr[[xv[2]]])
  yi <- complex(real=dr[[yv[1]]],imaginary=dr[[yv[2]]])
  vin <- data.frame(P,z0,x0,y0,xi,yi)
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
  dfX <- as.data.frame(oc)
  X <- as.matrix(dfX)
  Y <- as.matrix(vin$z0)
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

#olsce()
#beta_r <- c(-0.005693794321159,0.000763439988202552,0.816255513568808,1.58764312942543,-0.140264148421178,-0.498357855155589,0.513978651269852,-0.582940600960614,0.0261057978154113,0.421921936572005,0.113403802790825,0.0164414984815799)
#fit.complex = function(Y, X.List) {
#
#        # Split into real variables
#        YF = break1(Y)
#        XF.List = do.call(c, lapply(X.List,
#                function(x) { list(break1(x), break2(x)) } ))
#
#        # Make the data.fram
#        Data = data.frame(Y = YF)
#        X.Names = paste('X', 1:length(XF.List), sep='')
#
#        for (N in seq_along(XF.List)) {
#                Data[[ X.Names[[N]] ]] = XF.List[[N]]
#        }
#
#        # Formula + Model
#        Formula = paste("Y ~ ", paste(X.Names, collapse='+'), "-1")
#        Model = lm(as.formula(Formula), data=Data)
#
#        # Make them complex again
#        Coeffs = sapply(seq_along(X.List),
#                function(N) {
#                        ( Model$coefficients[[ X.Names[[2*N-1]] ]]
#                        + Model$coefficients[[ X.Names[[2*N]] ]]*1i )
#                })
#        names(Coeffs) = names(X.List)
#
#        Model$coefficients.complex = Coeffs
#
#        Model
#}
#break1 = function(X) {
#        do.call(c, lapply(X, function(x) { c(Re(x), Im(x)) }))
#}
#break2 = function(X) {
#        do.call(c, lapply(X, function(x) { c(-Im(x), Re(x)) }))
#}
#fit.complex = function(Y, X.List) {
#
#        # Split into real variables
#        YF = break1(Y)
#        XF.List = do.call(c, lapply(X.List,
#                function(x) { list(break1(x), break2(x)) } ))
#
#        # Make the data.fram
#        Data = data.frame(Y = YF)
#        X.Names = paste('X', 1:length(XF.List), sep='')
#
#        for (N in seq_along(XF.List)) {
#                Data[[ X.Names[[N]] ]] = XF.List[[N]]
#        }
#
#        # Formula + Model
#        Formula = paste("Y ~ ", paste(X.Names, collapse='+'), "-1")
#	View(Data)
#	browser()
#        Model = lm(as.formula(Formula), data=Data)
#
#        # Make them complex again
#        Coeffs = sapply(seq_along(X.List),
#                function(N) {
#                        ( Model$coefficients[[ X.Names[[2*N-1]] ]]
#                        + Model$coefficients[[ X.Names[[2*N]] ]]*1i )
#                })
#        names(Coeffs) = names(X.List)
#
#        Model$coefficients.complex = Coeffs
#
#        Model
#}
#Beta0 = 1 + 3i
#Beta1 = 3 - 2i
#
#X = runif(15, 0, 10)
#Y = (Beta0 + Beta1*X +
#        rnorm(length(X), 0, 0.7) * exp(1i*runif(length(X), 0, 2*pi))
#)
#View(Y)
#View(X)
#Model = fit.complex(Y, list(
#         const = 0*X+1,
#        linear = X
#))
#
#Beta0.Est = Model$coefficients.complex[[1]]
#Beta1.Est = Model$coefficients.complex[[2]]
#> Beta0.Est
#[1] 1.090385+3.017922i
#> Beta1.Est
#[1] 2.912617-2.030427i
#' @export abc
