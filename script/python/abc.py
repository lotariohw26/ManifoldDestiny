# https://docs.google.com/spreadsheets/d/1Qf51QlYkCmd8h72R5JrFUt9VYCgpq8U_RyQTLzOoiFc/edit?gid=499474525#gid=499474525
import pandas as pd
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
k3=0.064912642  
k4=0.064007760 
k5=-0.785443920
k6=0.092375583 
k7=-1.271709722  
k8=3.038048882
k9=0.923841730

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
test[2]['expr']
test[2]['expr'][2]
test[2]['expr'][3]


nr = 5
lhs = test[2]['d'][nr]
rhs = test[2]['expr'][nr]
plsv.pareq(str(rhs),a1=a1,a2=a2,a3=a3,b1=b1,b2=b2,b3=b3,c1=c1,c2=c2,c3=c3,k0=k0,k1=k1,k2=k2,k3=k3,k4=k4,k5=k5,k6=k6,k7=k7,k8=k8,k9=k9)
rhs
lhs

# Initialize an empty list to store the results for the DataFrame
results = []
for nr in range(20):  # Example: looping from 0 to 4, you can change the range as needed
  lhs = test[2]['d'][nr]
  rhs = test[2]['expr'][nr]
  pareq_result = plsv.pareq(str(rhs), a1=a1, a2=a2, a3=a3, b1=b1, b2=b2, b3=b3, c1=c1, c2=c2, c3=c3, k0=k0, k1=k1, k2=k2, k3=k3, k4=k4, k5=k5, k6=k6, k7=k7, k8=k8, k9=k9)
  results = results.append({
      'lhs': lhs,
      'rhs': rhs,
      'pareq_result': pareq_result
  })
  df_results = pd.DataFrame(results)
    
results = []
for nr in range(20):  # Example: looping from 0 to 19, you can change the range as needed
    lhs = test[2]['d'][nr]
    rhs = test[2]['expr'][nr]
    pareq_result = plsv.pareq(
        str(rhs),
        a1=a1, a2=a2, a3=a3,
        b1=b1, b2=b2, b3=b3,
        c1=c1, c2=c2, c3=c3,
        k0=k0, k1=k1, k2=k2, k3=k3, k4=k4, k5=k5, k6=k6, k7=k7, k8=k8, k9=k9
    )
    # Append the result dictionary directly to the list
    results.append({
        'lhs': lhs,
        'rhs': rhs,
        'pareq_result': pareq_result
    })

df_results = pd.DataFrame(results)
df_results.to_csv('results.csv', index=False)

lhs: d_000
0.001643394-0.001643393953
lhs: d_110
0.8973153912789109-0.8973
lhs: d_101
0.4071932389090186-0.4072
lhs: d_100
-1.3118839020577144-1.3119
lhs: d_220
-0.3128688463478883-0.3128688459
lhs: d_330
1.0534362501230063-1.05343625
lhs: d_202
-0.3157483283534651-0.3157483282
lhs: d_303
0.93462393175588-0.9346239316
lhs: d_200
-0.09191410329864645-0.09191410324
lhs: d_300
-0.013142792646241595-0.01314279264
lhs: d_211
0.7590771006031121-0.7590771006
lhs: d_210
0.3469878996010749-0.3469878993
lhs: d_312
-2.074803792120009-(-2.074803792)
lhs: d_310
0.29107640846896415-0.2910764084
lhs: d_201
-0.37108719030286785-0.3710871903
lhs: d_321
0.20771277395662346-0.2077127746
lhs: d_301
0.355014958784053-0.3550149588
lhs: d_320
-1.0562878296510383-(-1.05628783)
lhs: d_302
1.199962364580633-1.199962364
lhs: d_311
-0.85836961014258-(-0.86138405)




import pandas as pd

# Initialize an empty list to store the results for the DataFrame
results = []

# Loop through the range (adjust the range according to your needs)
for nr in range(20):  # Example: looping from 0 to 19, you can change the range as needed
    # Retrieve lhs and rhs values from test
    lhs = test[2]['d'][nr]
    rhs = test[2]['expr'][nr]
    
    # Call the 'pareq' method with the necessary arguments (assuming pareq returns a value or result)
    pareq_result = plsv.pareq(str(rhs), a1=a1, a2=a2, a3=a3, b1=b1, b2=b2, b3=b3, 
                              c1=c1, c2=c2, c3=c3, k0=k0, k1=k1, k2=k2, k3=k3, 
                              k4=k4, k5=k5, k6=k6, k7=k7, k8=k8, k9=k9)
    
    # Append the lhs, rhs, and pareq_result into the results list as a dictionary
    results.append({
        'lhs': lhs,
        'rhs': rhs,
        'pareq_result': pareq_result
    })

# Convert the results list into a pandas DataFrame
df_results = pd.DataFrame(results)

# Now df_results holds the data and you can use it for further analysis or saving
print(df_results)  # Optional: Display the DataFrame in the console

# If you want to save this DataFrame to a file (like a CSV)
df_results.to_csv('pareq_results.csv', index=False)










# II
















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



