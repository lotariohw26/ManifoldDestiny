####################################################################################################################
########################################################################################################################
# Cleaning namespace
for name in dir():
  if not name.startswith('_'):
      del globals()[name]
# Import packages
#import json
import sympy
import numpy
import sys
from sympy import solve, Eq, symbols, latex, simplify, diff
import pandas
import os
import rpy2
import rpy2.robjects as robjects
from rpy2.robjects.packages import importr, data
rroot=importr('rprojroot')
abs_path = rroot.find_rstudio_root_file()[0]
csvfile=abs_path+'/script/python/csv/parameters.csv'
readmodvar = pandas.read_csv(csvfile, sep=',') 
sympy.var(readmodvar.iloc[:,0])
beforems = set(dir())
########################################################################################################################
#########################################################################################################################
### Standard form proportions
x_s       = [Eq(x,S/(S+T))]
y_s       = [Eq(y,U/(U+V))]
zeta_s    = [Eq(zeta,(U+V)/(S+T)),Eq(zeta,(x-alpha)/(alpha-y))]
alpha_s   = [Eq(alpha,(S+U)/(S+T+U+V)),Eq(alpha,(x+zeta*y)/(1+zeta))]
lamda_s   = [Eq(lamda,(S+V)/(S+T+U+V)),Eq(lamda,(x+zeta*(1-y))/(zeta+1))]
Omega_s   = [Eq(Omega,(S+T)/(S+T+U+V)),Eq(Omega,zeta/(1+zeta))]
###########################################################################################################################
######### Hybrid form proportions
g_h       = [Eq(g,S/(S+V))]
h_h       = [Eq(h,U/(T+U))]
Gamma_h   = [Eq(Gamma,(T+U)/(S+V)),Eq(Gamma,(g-alpha)/(alpha-h))]
alpha_h   = [Eq(alpha,(S+U)/(S+T+U+V)),Eq(alpha,(g+Gamma*h)/(1+Gamma))]
Omega_h   = [Eq(Omega,(S+T)/(S+T+U+V)),Eq(Omega,(g+Gamma*(1-g))/(Gamma+1)),Eq(Omega,(2*g+Gamma)/(Gamma+1)-alpha)]
lamda_h   = [Eq(lamda,(S+V)/(S+T+U+V)),Eq(lamda,1/(Gamma+1))]
###############################################################################################################################
###### Oppostion form proportions
lamda_o   = [Eq(lamda,(S+V)/(S+T+U+V)),Eq(lamda,(2*m+xi)/(xi+1)-Omega)]
Omega_o   = [Eq(Omega,(S+T)/(S+T+U+V)),Eq(Omega,(m+xi*n)/(xi+1))]
m_o       = [Eq(m,T/(T+V))]
n_o       = [Eq(n,S/(S+U))]
xi_o      = [Eq(xi,(T+V)/(S+U)),Eq(xi,(m-Omega)/(Omega-n)),Eq(xi,(m-lamda)/(lamda-(1-n)))]
lamda_o   = [Eq(lamda,(S+V)/(S+T+U+V)),Eq(Omega,Gamma/(1+Gamma))]
#############################################################################################################################
##### Integers
S_s = [Eq(s,S),Eq(u,x*Z*Omega)]
T_s = [Eq(t,T),Eq(u,(1-x)*Z*Omega)]
U_s = [Eq(u,U), Eq(u,y*Z*(1-Omega))]
V_s = [Eq(v,V), Eq(v,(1-y)*Z*(1-Omega))]
###
S_h = [Eq(s,S), Eq(s,g*Z*lamda)]
V_h = [Eq(v,V), Eq(v,(1-g)*Z*lamda)]
U_h = [Eq(u,U), Eq(u,h*Z*lamda)]
T_h = [Eq(t,T), Eq(s,(1-h)*Z*lamda)]
###
S_o = [Eq(s,S), Eq(s,S)]
T_o = [Eq(s,T), Eq(t,T)]
U_o = [Eq(u,U), Eq(u,U)]
V_o = [Eq(v,V), Eq(v,V)]
############################################################################################################################
###### Implications:
### Standard form
#y_s.append(Eq(y,solve(alpha_s[1],y)[0]))
### Hybrid form
#solve(alpha_s[1],y)
### Oppostion form
### Interaction
#############################################################################################################################
### Causality
#az_df1 = diff(solve(alpha_s[1],alpha)[0],zeta)
#az_df2 = diff(diff(solve(alpha_s[1],alpha)[0],zeta),zeta)
#aG_df1 = diff(solve(alpha_h[1],alpha)[0],Gamma)
#aG_df2 = diff(diff(solve(alpha_h[1],alpha)[0],Gamma),Gamma)
#############################################################################################################################
##########################################################################################################################
###### Storing ###
##### Storing ###
afterms = set(dir())
modvarlist = list(afterms - beforems)
modvarlist.remove('beforems')
modvarlist
modeqs = dict()
modeql = dict()
dfs = [] 
dfl = [] 
parv = 'empty'
for i in range(0,len(modvarlist)):
  modeqs[parv] = dfs
  modeql[parv] = dfl
  parv = modvarlist[i]
  dfs = [] 
  dfl = [] 
  nid = len(eval(modvarlist[i])) 
  for j in range(0,nid):
    dfs.append(str(eval(modvarlist[i])[j].rhs))
    dfl.append(latex(eval(modvarlist[i])[j].rhs))
modeqs[parv] = dfs
modeql[parv] = dfl
modeqs.pop('empty')
modeql.pop('empty')
#########################################################################################################################


