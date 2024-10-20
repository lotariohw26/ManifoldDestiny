##############################################################################################################
# Settings
apps <- T # Oppdater plot
##############################################################################################################
# Packages
suppressMessages(ManifoldDestiny::wasmconload())
###############################################################################################################
ManifoldDestiny::bm()
###############################################################################################################
if(isTRUE(apps)) {
x <- 1
appl <- list(c("abc","ManifoldDestiny"), c("manimp","ManifoldDestiny"),c("empapp","ManifoldDestiny"), c("restor","ManifoldDestiny"))
  lapply(1:1, function(x) {
		 x <- 1
     system.file("shinyapps",appl[x][[1]][1], package=appl[x][[1]][2]) %>%
     fs::dir_copy(paste0("inst/shinyapps/",appl[x][[1]][1]), overwrite = TRUE)
     dp <- paste0("inst/shinyapps/",appl[[x]][1])
     tp <- paste0("docs/",appl[[x]][1])
     shinylive::export(dp,tp)
  })
}
#runStaticServer("docs/r2rsim")
###############################################################################################################
#lpku <<- list(
#  S = list(
#    x = c(Sd = 'x*(Z-U-V)', Td = '(1-x)*(Z-U-V)', Ud = 'U', Vd = 'V'),'S~S_hat',
#    x = c(Sd = 'x*(Z-U-V)', Td = '(1-x)*(Z-U-V)', Ud = 'U', Vd = 'V'),'S~S_hat',
#    y = c(Sd = 'S', Td = 'T', Ud = 'y*(Z-S-T)', Vd = '(1-y)*(Z-S-T)','U~U_hat')
#  ),
#  H = list(
#    g = c(Sd = 'g*(Z-T-U)', Td = 'T', Ud = 'U', Vd = '(1-g)*(Z-T-U)','S~S_hat'),
#    h = c(Sd = 'S', Td = 'h*(Z-T-U)', Ud = 'h*(Z-T-U)', Vd = 'V','S~S_hat')
#  ),
#  O = list(
#    n = c(Sd = 'm*(Z-T-V)', Td = 'T', Ud = '(1-m)*(Z-T-V)', Vd = 'V','S-S_hat'),
#    m = c(Sd = 'S', Td = 'm*(Z-T-V)', Ud = 'U', Vd = '(1-m)*(Z-T-V)','T-T_hat')
#  )
#)
#usethis::use_data(lpku, overwrite = TRUE)
################################################################################################################
##  # Model
#fdm <- paste0(rprojroot::find_rstudio_root_file(),'/script/python/pysympy.py')A
#reticulate::source_python(fdm)
#eqpar <- list(meql=reticulate::py$modeql,meqs=reticulate::py$modeqs)
### Saving data
#usethis::use_data(eqpar, overwrite = TRUE)
##  # Cubic
#peqs <-c(
#'k0 + k1*u + k2*v',
#'k0 + k1*u + k2*v + k3*u**2 + k4*v**2 + k5*u*v',
#'k0 + k1*u + k2*v + k3*u**2 + k4*v**2 + k5*u*v + k6*v**3 + k7*u*v + k8*u**2*v + k9*u*v**2',
#'k0 + k1*u + k2*v + k3*u**2 + k4*v**2 + k5*u*v + k6*u**3 + k7*v**3 + k8*u**2*v + k9*u*v**2 + k10*u**4 + k11*v**4 + k12*u**3*v + k13*u**2*v**2 + k14*u*v**3 +k15*u**4*v + k16*u*v**2')
#usethis::use_data(peqs, overwrite = TRUE)
################################################################################################################
#laws2 <- tribble(
#  ~Law_Number, ~North_vs_South, ~West_vs_East, ~Diagonal_vs_Diagonal,
#  "First Law", "$x_{1}=\\alpha_{1}+\\zeta(\\alpha_{1}-y_{1})$", "$g_{1}=\\alpha_{1}+\\gamma(\\alpha_{1}-h_{1})$", "$m_{1}=\\Omega_{1}+\\xi(\\Omega_{1}-n_{1})$",
#  "Second Law", "$x_{1}=\\lambda_{1}+\\zeta(\\lambda_{1}-y_{2})$", "$g_{1}=\\Omega_{1}+\\gamma(\\Omega_{1}-h_{2})$", "$m_{1}=\\lambda_{1}+\\xi(\\lambda_{1}-n_{2})$",
#  "Third Law", "$x_{1}=\\frac{\\alpha_{1}y_{2}-\\lambda_{1}y_{1}}{(\\alpha_{1}-\\lambda_{1})-(y_{1}-y_{2})}$", "$g_{1}=\\frac{\\alpha_{1}h_{2}-\\Omega_{1}h_{1}}{(\\alpha_{1}-\\Omega_{1})-(h_{1}-h_{2})}$", "$m_{1}=\\frac{\\Omega_{1}n_{2}-\\lambda_{1}n_{1}}{(\\Omega_{1}-\\lambda_{1})-(n_{1}-n_{2})}$",
#  "Fourth Law", "$x_{1}=\\frac{\\lambda_{1}+\\alpha_{1}-\\Omega_{2}}{2\\Omega_{1}}$", "$g_{1}=\\frac{\\Omega_{1}+\\alpha_{1}-\\lambda_{2}}{2\\lambda_{1}}$", "$m_{1}=\\frac{\\lambda_{1}+\\Omega_{1}-\\alpha_{2}}{2\\alpha_{1}}$",
#  "Fifth Law", "$y_{1}=\\alpha_{1}-\\zeta^{-1}(\\alpha_{1}-x_{1})$", "$h_{1}=\\alpha_{1}-\\gamma^{-1}(\\alpha_{1}-g_{1})$", "$n_{1}=\\Omega_{1}-\\xi^{-1}(\\Omega_{1}-m_{1})$",
#  "Sixth Law", "$y_{1}=\\lambda_{2}-\\zeta^{-1}(\\lambda_{1}-x_{1})$", "$h_{1}=\\Omega_{2}-\\gamma^{-1}(\\Omega_{1}-g_{1})$", "$n_{1}=\\lambda_{2}-\\xi^{-1}(\\lambda_{1}-m_{1})$",
#  "Seventh Law", "$y_{1}=\\frac{x_{1}\\lambda_{2}-x_{2}\\alpha_{1}}{(\\lambda_{2}-\\alpha_{1})-(x_{2}-x_{1})}$", "$h_{1}=\\frac{g_{1}\\Omega_{2}-g_{2}\\alpha_{1}}{(\\Omega_{2}-\\alpha_{1})-(g_{2}-g_{1})}$", "$n_{1}=\\frac{m_{1}\\lambda_{2}-m_{2}\\Omega_{1}}{(\\lambda_{2}-\\Omega_{1})-(m_{2}-m_{1})}$",
#  "Eighth Law", "$y_{1}=\\frac{\\lambda_{2}+\\alpha_{1}-\\Omega_{1}}{2\\Omega_{2}}$", "$h_{1}=\\frac{\\Omega_{2}+\\alpha_{1}-\\lambda_{1}}{2\\lambda_{2}}$", "$n_{1}=\\frac{\\lambda_{2}+\\Omega_{1}-\\alpha_{1}}{2\\alpha_{2}}$",
#  "Ninth Law", "$\\alpha_{1}=x_{1}\\Omega_{1}+\\Omega_{2}y_{1}$", "$\\alpha_{1}=g_{1}\\lambda_{1}+\\lambda_{2}h_{1}$", "$\\Omega_{1}=m_{1}\\alpha_{1}+\\alpha_{2}n_{1}$",
#  "Tenth Law", "$\\alpha_{1}=\\Omega_{1}(x_{1}-x_{2})+\\lambda_{2}$", "$\\alpha_{1}=\\lambda_{1}(g_{1}-g_{2})+\\Omega_{2}$", "$\\Omega_{1}=\\alpha_{1}(m_{1}-m_{2})+\\lambda_{2}$",
#  "Eleventh Law", "$\\alpha_{1}=\\Omega_{2}(y_{1}-y_{2})+\\lambda_{1}$", "$\\alpha_{1}=\\lambda_{2}(h_{1}-h_{2})+\\Omega_{1}$", "$\\Omega_{1}=\\alpha_{2}(n_{1}-n_{2})+\\lambda_{1}$",
#  "Twelfth Law", "$\\alpha_{1}=\\frac{x_{1}(y_{2}-y_{1})-\\lambda_{1}(x_{1}-y_{1})}{y_{2}-x_{1}}$", "$\\alpha_{1}=\\frac{g_{1}(h_{2}-h_{1})-\\Omega_{1}(g_{1}-h_{1})}{h_{2}-g_{1}}$", "$\\Omega_{1}=\\frac{m_{1}(n_{2}-n_{1})-\\lambda_{1}(m_{1}-n_{1})}{n_{2}-m_{1}}$",
#  "Thirteenth Law", "$\\lambda_{1}=x_{1}\\Omega_{1}+\\Omega_{2}y_{2}$", "$\\Omega_{1}=g_{1}\\lambda_{1}+\\lambda_{2}h_{2}$", "$\\lambda_{1}=m_{1}\\alpha_{1}+\\alpha_{2}n_{2}$",
#  "Fourteenth Law", "$\\lambda_{1}=\\Omega_{1}(x_{1}-x_{2})+\\alpha_{2}$", "$\\Omega_{1}=\\lambda_{1}(g_{1}-g_{2})+\\alpha_{2}$", "$\\lambda_{1}=\\alpha_{1}(m_{1}-m_{2})+\\Omega_{2}$",
#  "Fifteenth Law", "$\\lambda_{1}=\\frac{\\alpha_{1}(x_{1}-y_{2})-x_{1}(y_{1}-y_{2})}{x_{1}-y_{1}}$", "$\\Omega_{1}=\\frac{\\alpha_{1}(g_{1}-h_{2})-g_{1}(h_{1}-h_{2})}{g_{1}-h_{1}}$", "$\\lambda_{1}=\\frac{\\Omega_{1}(m_{1}-n_{2})-m_{1}(n_{1}-n_{2})}{m_{1}-n_{1}}$",
#  "Sixteenth Law", "$\\lambda_{1}=\\Omega_{2}(y_{2}-y_{1})+\\alpha_{1}$", "$\\Omega_{1}=\\lambda_{2}(h_{2}-h_{1})+\\alpha_{1}$", "$\\lambda_{1}=\\alpha_{2}(n_{2}-n_{1})+\\Omega_{1}$",
#  "Seventeenth Law", "$\\zeta=\\frac{x_{1}-\\alpha_{1}}{\\alpha_{1}-y_{1}};\\Omega_{1}=\\frac{y_{1}-\\alpha_{1}}{y_{1}-x_{1}}$", "$\\gamma=\\frac{g_{1}-\\alpha_{1}}{\\alpha_{1}-h_{1}};\\lambda_{1}=\\frac{h_{1}-\\alpha_{1}}{h_{1}-g_{1}}$", "$\\xi=\\frac{m_{1}-\\Omega_{1}}{\\Omega_{1}-n_{1}};\\alpha_{1}=\\frac{n_{1}-\\Omega_{1}}{n_{1}-m_{1}}$",
#  "Eighteenth Law", "$\\Omega_{1}=\\frac{\\lambda_{2}-\\alpha_{1}}{x_{2}-x_{1}}=\\frac{\\alpha_{2}-\\lambda_{1}}{x_{2}-x_{1}}$", "$\\gamma_{1}=\\frac{\\Omega_{2}-\\alpha_{1}}{g_{2}-g_{1}}=\\frac{\\alpha_{2}-\\Omega_{1}}{g_{2}-g_{1}}$", "$\\alpha_{1}=\\frac{\\lambda_{2}-\\Omega_{1}}{m_{2}-m_{1}}=\\frac{\\Omega_{2}-\\lambda_{1}}{m_{2}-m_{1}}$",
#  "Nineteenth Law", "$\\zeta=\\frac{x_{1}-\\lambda_{1}}{\\lambda_{1}-y_{2}}; \\Omega_{1}=\\frac{y_{2}-\\lambda_{1}}{y_{2}-x_{1}}$", "$\\gamma=\\frac{g_{1}-\\Omega_{1}}{\\Omega_{1}-h_{2}}; \\lambda_{1}=\\frac{h_{2}-\\Omega_{1}}{h_{2}-g_{1}}$", "$\\xi=\\frac{m_{1}-\\lambda_{1}}{\\lambda_{1}-n_{2}}; \\alpha_{1}=\\frac{n_{2}-\\lambda_{1}}{n_{2}-m_{1}}$",
#  "Twentieth Law", "$\\zeta=\\frac{\\lambda_{1}-\\alpha_{1}}{(y_{2}-y_{1})+(\\alpha_{1}-\\lambda_{1})}$", "$\\gamma=\\frac{\\Omega_{1}-\\alpha_{1}}{(h_{2}-h_{1})+(\\alpha_{1}-\\Omega_{1})}$", "$\\xi=\\frac{\\lambda_{1}-\\Omega_{1}}{(n_{2}-n_{1})+(\\Omega_{1}-\\lambda_{1})}$"
#)
################################################################################################################
#stick <-
#  list(parm=list(
#  S=c("alpha","x","y","zeta","lamda","Omega"),
#  H=c("alpha","g","h","Gamma","Omega","lamda"),
#  O=c("alpha","m","n","xi","lamda","Omega"),
#  B=c("alpha","x","y","Omega","m","n")
#  ),
#  forms=list('_s','o_h','h_o')) 
#usethis::use_data(stick, overwrite = TRUE)
#  
#frmsel <- list(c(1,2,3,4,5,6),c(7,8,9,10,11,12),c(13,14,15,16,17,18),c(19,20,21,22,23,24))
#usethis::use_data(frmsel, overwrite = TRUE)
################################################################################################################
#file.copy(from = "script/python/abc.py", to ="MD_WASMS/examples/python/repl/poly.py", overwrite=T) 
file.copy(from="inst/shinyapps/r2rsim/app.R",to="MD_WASMS/examples/r/001-hello/app.R", overwrite=T) 
file.copy(from="inst/shinyapps/r2rsim/app.R",to="MD_WASMS/examples/r/002-text/app.R", overwrite=T) 
file.copy(from="inst/shinyapps/r2rsim/app.R",to="MD_WASMS/examples/r/003-reactivity/app.R", overwrite=T) 
file.copy(from="inst/shinyapps/r2rsim/app.R",to="MD_WASMS/examples/r/004-mpg/app.R", overwrite=T) 

#library(webshot)
#webshot("https://www.r-project.org/", "r.png")
#webshot("https://www.r-project.org/", "r-viewport.png", cliprect = "viewport")
