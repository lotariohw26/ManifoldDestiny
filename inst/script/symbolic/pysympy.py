######################################################################################################################
#reticulate::repl_python()
######################################################################################################################
########################################################################################################################
# Cleaning namespace
for name in dir():
  if not name.startswith('_'):
      del globals()[name]
# Import packages
import json
import sympy
import numpy
import sys
#import matplotlib.pyplot as plt
from sympy import solve, Eq, symbols, latex, simplify
#from matplotlib.pyplot import *
import pandas
import os
apath = os.getcwd()
print(apath)
#readmodvar = pandas.read_csv('script/symbolic/csv/parameters.csv', sep=',') 
readmodvar = pandas.read_csv('inst/script/symbolic/csv/parameters.csv', sep=',') 
#readmodvar = pandas.read_csv('csv/parameters.csv', sep=',') 
sympy.var(readmodvar.iloc[:,0])
beforems = set(dir())
#########################################################################################################################
cx  = [Eq(x,a/(a+b))]
cy  = [Eq(y,c/(c+d))]
cg  = [Eq(g,a/(a+d))]
ch  = [Eq(h,b/(b+c))]
cm  = [Eq(m,a/(a+c))]
cn  = [Eq(n,b/(b+d))]
cce = [Eq(ceta,(c+d)/(a+b))]
cal = [Eq(alpha,(a+c)/(a+b+c+d))]
cla = [Eq(lamda,(a+d)/(a+b+c+d))]
com = [Eq(Omega,(a+b)/(a+b+c+d))]
cxi = [Eq(xi,(b+d)/(a+c))]
cga = [Eq(Gamma,(b+c)/(a+d))]
#########################################################################################################################
### Standard form
x_s=       cx
alpha_s =  [Eq(alpha,Omega*x+(1-Omega)*y),Eq(alpha,(x+zeta*y)/(1+zeta)),Eq(alpha,(g+Gamma*h)/(Gamma+1)),Eq(alpha,(1)/(xi+1))]
lambda_s = [Eq(alpha,(x+zeta*y)/(1+zeta)),Eq(alpha,(1)/(xi+1)),Eq(alpha,(m+xi*(1-n))/(xi+1))]
zeta_s =   [Eq(alpha,(x-alpha)/(alpha-y))]
y_s = 	   [Eq(y,solve(alpha_s[1],y)[0])]
##########################################################################################################################
###### Oppostion form
x_o=       cx
alpha_o =  [Eq(alpha,(x+zeta*y)/(1+zeta))]
lambda_o = [Eq(alpha,(x+zeta*y)/(1+zeta))]
zeta_o =   [Eq(alpha,(x+zeta*y)/(1+zeta))]
y_o = 	    [Eq(alpha,(x+zeta*y)/(1+zeta))]
###############################################################################################################################
######### Hybrid form
x_h=       cx
alpha_h =  [Eq(alpha,(x+zeta*y)/(1+zeta))]
lambda_h = [Eq(alpha,(x+zeta*y)/(1+zeta))]
zeta_h =   [Eq(alpha,(x+zeta*y)/(1+zeta))]
y_h = 	   [Eq(alpha,(x+zeta*y)/(1+zeta))]
############################################################################################################################
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
###########################################################################################################################
