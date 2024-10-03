# https://docs.google.com/spreadsheets/d/1Qf51QlYkCmd8h72R5JrFUt9VYCgpq8U_RyQTLzOoiFc/edit?gid=499474525#gid=499474525
import polysolver as plsv
import math                                                                   
prv = ["g","h","alpha"]
rve = [1, 2, 4]
gra = [-44.9573,7.001545,-19.9677]
eqs = ["z=k0+k1*x+k2*y+k3*x**2+k4*x*y+k5*y**2+k6*x**3+k7*x**2*y+k8*y**2*x+k9*y**3","alpha=k0+k1*g+k2*h+k3*Gamma"][0]
sfo = ['g','h','alpha'][2]
test = plsv.genpolycoeffr(elem=prv,expr=eqs,solv=sfo,eur=rve)
m1v = math.cos(math.radians(gra[0]))
m2v = math.cos(math.radians(gra[1]))
m3v = math.cos(math.radians(gra[2]))
n1v = math.sin(math.radians(gra[0]))
n2v = math.sin(math.radians(gra[1]))
n3v = math.sin(math.radians(gra[2]))
m1v, m2v, m3v, n1v, n2v, n3v
k0=0.001643394 
k1=1.075717880 
k2=-0.731335532  
k3=-0.785443920  
k4=0.064007760  
k5=0.064912642  
k6=0.923841730  
k7=3.038048882 
k8=-1.271709722
k9=0.092375583
# I
a1 = plsv.pareq(ste=str(test[1][0]),m1=m1v,m2=m2v,m3=m3v,n1=n1v,n2=n2v,n3=n3v)
a2 = plsv.pareq(ste=str(test[1][1]),m1=m1v,m2=m2v,m3=m3v,n1=n1v,n2=n2v,n3=n3v)
a3 = plsv.pareq(ste=str(test[1][2]),m1=m1v,m2=m2v,m3=m3v,n1=n1v,n2=n2v,n3=n3v)
b1 = plsv.pareq(ste=str(test[1][3]),m1=m1v,m2=m2v,m3=m3v,n1=n1v,n2=n2v,n3=n3v)
b2 = plsv.pareq(ste=str(test[1][4]),m1=m1v,m2=m2v,m3=m3v,n1=n1v,n2=n2v,n3=n3v)
b3 = plsv.pareq(ste=str(test[1][5]),m1=m1v,m2=m2v,m3=m3v,n1=n1v,n2=n2v,n3=n3v)
c1 = plsv.pareq(ste=str(test[1][6]),m1=m1v,m2=m2v,m3=m3v,n1=n1v,n2=n2v,n3=n3v)
c2 = plsv.pareq(ste=str(test[1][7]),m1=m1v,m2=m2v,m3=m3v,n1=n1v,n2=n2v,n3=n3v)
c3 = plsv.pareq(ste=str(test[1][8]),m1=m1v,m2=m2v,m3=m3v,n1=n1v,n2=n2v,n3=n3v)
a1, a2, a3, b1, b2, b3, c1, c2, c3
test[2]['expr'][4]
'a1**2*k3 + a1*b1*k4 + b1**2*k5'
'a1**2*k3 + a1*b1*k4 + b1**2*k5'
'a1**2*k3 + a1*b1*k4 + b1**2*k5'


# II
d_000 = plsv.pareq(str(test[2]['expr'][0]),a1=a1,a2=a2,a3=a3,b1=b1,b2=b2,b3=b3,c1=c1,c2=c2,c3=c3,k0=k0,k1=k1,k2=k2,k3=k3,k4=k4,k5=k5,k6=k6,k7=k7,k8=k8,k9=k0)
d_110 = plsv.pareq(str(test[2]['expr'][1]),a1=a1,a2=a2,a3=a3,b1=b1,b2=b2,b3=b3,c1=c1,c2=c2,c3=c3,k0=k0,k1=k1,k2=k2,k3=k3,k4=k4,k5=k5,k6=k6,k7=k7,k8=k8,k9=k0)
d_101 = plsv.pareq(str(test[2]['expr'][2]),a1=a1,a2=a2,a3=a3,b1=b1,b2=b2,b3=b3,c1=c1,c2=c2,c3=c3,k0=k0,k1=k1,k2=k2,k3=k3,k4=k4,k5=k5,k6=k6,k7=k7,k8=k8,k9=k0)
d_100 = plsv.pareq(str(test[2]['expr'][3]),a1=a1,a2=a2,a3=a3,b1=b1,b2=b2,b3=b3,c1=c1,c2=c2,c3=c3,k0=k0,k1=k1,k2=k2,k3=k3,k4=k4,k5=k5,k6=k6,k7=k7,k8=k8,k9=k0)
d_220 = plsv.pareq(str(test[2]['expr'][4]),a1=a1,a2=a2,a3=a3,b1=b1,b2=b2,b3=b3,c1=c1,c2=c2,c3=c3,k0=k0,k1=k1,k2=k2,k3=k3,k4=k4,k5=k5,k6=k6,k7=k7,k8=k8,k9=k0)
d_330 = plsv.pareq(str(test[2]['expr'][5]),a1=a1,a2=a2,a3=a3,b1=b1,b2=b2,b3=b3,c1=c1,c2=c2,c3=c3,k0=k0,k1=k1,k2=k2,k3=k3,k4=k4,k5=k5,k6=k6,k7=k7,k8=k8,k9=k0)
d_202 = plsv.pareq(str(test[2]['expr'][6]),a1=a1,a2=a2,a3=a3,b1=b1,b2=b2,b3=b3,c1=c1,c2=c2,c3=c3,k0=k0,k1=k1,k2=k2,k3=k3,k4=k4,k5=k5,k6=k6,k7=k7,k8=k8,k9=k0)
d_303 = plsv.pareq(str(test[2]['expr'][7]),a1=a1,a2=a2,a3=a3,b1=b1,b2=b2,b3=b3,c1=c1,c2=c2,c3=c3,k0=k0,k1=k1,k2=k2,k3=k3,k4=k4,k5=k5,k6=k6,k7=k7,k8=k8,k9=k0)
d_200 = plsv.pareq(str(test[2]['expr'][8]),a1=a1,a2=a2,a3=a3,b1=b1,b2=b2,b3=b3,c1=c1,c2=c2,c3=c3,k0=k0,k1=k1,k2=k2,k3=k3,k4=k4,k5=k5,k6=k6,k7=k7,k8=k8,k9=k0)
d_300 = plsv.pareq(str(test[2]['expr'][9]),a1=a1,a2=a2,a3=a3,b1=b1,b2=b2,b3=b3,c1=c1,c2=c2,c3=c3,k0=k0,k1=k1,k2=k2,k3=k3,k4=k4,k5=k5,k6=k6,k7=k7,k8=k8,k9=k0)
d_211 = plsv.pareq(str(test[2]['expr'][10]),a1=a1,a2=a2,a3=a3,b1=b1,b2=b2,b3=b3,c1=c1,c2=c2,c3=c3,k0=k0,k1=k1,k2=k2,k3=k3,k4=k4,k5=k5,k6=k6,k7=k7,k8=k8,k9=k0)
d_210 = plsv.pareq(str(test[2]['expr'][11]),a1=a1,a2=a2,a3=a3,b1=b1,b2=b2,b3=b3,c1=c1,c2=c2,c3=c3,k0=k0,k1=k1,k2=k2,k3=k3,k4=k4,k5=k5,k6=k6,k7=k7,k8=k8,k9=k0)
d_312 = plsv.pareq(str(test[2]['expr'][12]),a1=a1,a2=a2,a3=a3,b1=b1,b2=b2,b3=b3,c1=c1,c2=c2,c3=c3,k0=k0,k1=k1,k2=k2,k3=k3,k4=k4,k5=k5,k6=k6,k7=k7,k8=k8,k9=k0)
d_310 = plsv.pareq(str(test[2]['expr'][13]),a1=a1,a2=a2,a3=a3,b1=b1,b2=b2,b3=b3,c1=c1,c2=c2,c3=c3,k0=k0,k1=k1,k2=k2,k3=k3,k4=k4,k5=k5,k6=k6,k7=k7,k8=k8,k9=k0)
d_201 = plsv.pareq(str(test[2]['expr'][14]),a1=a1,a2=a2,a3=a3,b1=b1,b2=b2,b3=b3,c1=c1,c2=c2,c3=c3,k0=k0,k1=k1,k2=k2,k3=k3,k4=k4,k5=k5,k6=k6,k7=k7,k8=k8,k9=k0)
d_321 = plsv.pareq(str(test[2]['expr'][15]),a1=a1,a2=a2,a3=a3,b1=b1,b2=b2,b3=b3,c1=c1,c2=c2,c3=c3,k0=k0,k1=k1,k2=k2,k3=k3,k4=k4,k5=k5,k6=k6,k7=k7,k8=k8,k9=k0)
d_301 = plsv.pareq(str(test[2]['expr'][16]),a1=a1,a2=a2,a3=a3,b1=b1,b2=b2,b3=b3,c1=c1,c2=c2,c3=c3,k0=k0,k1=k1,k2=k2,k3=k3,k4=k4,k5=k5,k6=k6,k7=k7,k8=k8,k9=k0)
d_320 = plsv.pareq(str(test[2]['expr'][17]),a1=a1,a2=a2,a3=a3,b1=b1,b2=b2,b3=b3,c1=c1,c2=c2,c3=c3,k0=k0,k1=k1,k2=k2,k3=k3,k4=k4,k5=k5,k6=k6,k7=k7,k8=k8,k9=k0)
d_302 = plsv.pareq(str(test[2]['expr'][18]),a1=a1,a2=a2,a3=a3,b1=b1,b2=b2,b3=b3,c1=c1,c2=c2,c3=c3,k0=k0,k1=k1,k2=k2,k3=k3,k4=k4,k5=k5,k6=k6,k7=k7,k8=k8,k9=k0)
d_311 = plsv.pareq(str(test[2]['expr'][19]),a1=a1,a2=a2,a3=a3,b1=b1,b2=b2,b3=b3,c1=c1,c2=c2,c3=c3,k0=k0,k1=k1,k2=k2,k3=k3,k4=k4,k5=k5,k6=k6,k7=k7,k8=k8,k9=k0)

# I
d_000
# II
d_100
d_101
d_110
# III
d_200
d_201
d_202
d_210
d_211
d_220
# IV
d_300
d_301
d_302
d_303
d_310
d_311
d_312
d_320
d_321
d_330



nr = 2
test[2]['d'][nr], test[2]['var'][nr], test[2]['expr'][nr]
d_000
nr = 1
test[2]['d'][nr], test[2]['var'][nr], test[2]['expr'][nr]
d_110
nr = 2
test[2]['d'][nr], test[2]['var'][nr], test[2]['expr'][nr]
nr = 3
test[2]['d'][nr], test[2]['var'][nr], test[2]['expr'][nr]
nr = 4
test[2]['d'][nr], test[2]['var'][nr], test[2]['expr'][nr]
nr = 5
test[2]['d'][nr], test[2]['var'][nr], test[2]['expr'][nr]
nr = 6
test[2]['d'][nr], test[2]['var'][nr], test[2]['expr'][nr]
nr = 7
test[2]['d'][nr], test[2]['var'][nr], test[2]['expr'][nr]
nr = 8
test[2]['d'][nr], test[2]['var'][nr], test[2]['expr'][nr]
nr = 9
test[2]['d'][nr], test[2]['var'][nr], test[2]['expr'][nr]
nr = 10
test[2]['d'][nr], test[2]['var'][nr], test[2]['expr'][nr]
nr = 11
test[2]['d'][nr], test[2]['var'][nr], test[2]['expr'][nr]
nr = 12
test[2]['d'][nr], test[2]['var'][nr], test[2]['expr'][nr]
nr = 13
test[2]['d'][nr], test[2]['var'][nr], test[2]['expr'][nr]
nr = 14
test[2]['d'][nr], test[2]['var'][nr], test[2]['expr'][nr]
nr = 15
test[2]['d'][nr], test[2]['var'][nr], test[2]['expr'][nr]
nr = 16
test[2]['d'][nr], test[2]['var'][nr], test[2]['expr'][nr]
nr = 17
test[2]['d'][nr], test[2]['var'][nr], test[2]['expr'][nr]
nr = 18
test[2]['d'][nr], test[2]['var'][nr], test[2]['expr'][nr]
nr = 19
test[2]['d'][nr], test[2]['var'][nr], test[2]['expr'][nr]



d_110
d_200
d_201
d_202
d_211
d_210
d_220
d_300
d_301
d_302
d_303
d_310
d_312
d_311
d_321
d_320
d_330



