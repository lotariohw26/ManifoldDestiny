# !!! fix deviation from mean
import sympy, pandas, numpy
from sympy import solve, Eq, symbols, latex, simplify, diff, poly, sympify, Matrix, pprint, collect, expand, Poly, Symbol, Pow
def rall(sel=[0, 0, 0]):
    n, m = symbols('n m')
    
    rxy = Matrix([[m, -n, 0], 
                  [n, m, 0],
                  [0, 0, 1]])
    
    rxz = Matrix([[m, 0, -n], 
                  [0, 1, 0],
                  [n, 0, m]])
    
    ryx = Matrix([[m, n, 0], 
                  [-n, m, 0],
                  [0, 0, 1]])
    
    ryz = Matrix([[1, 0, 0], 
                  [0, m, -n],
                  [0, n, m]])
    
    rzx = Matrix([[m, 0, n], 
                  [0, 1, 0],
                  [-n, 0, m]])
    
    rzy = Matrix([[1, 0, 0], 
                  [0, m, n],
                  [0, -n, m]])
    
    ps = [0, rxy, rxz, ryx, ryz, rzx, rzy]
    
    allrot = [ps[i] for i in sel]
    return allrot

#def genpolycoeff():
#def genpolycoeff2(equ="alpha=k0+k1*g+k2*h", solvd='alpha'):
def genpolycoeff(plr=1,parm=["alpha", "x", "y"],solvd='alpha',eur=[0, 0, 0]):
    x, y, z = sympy.symbols('x y z')
    k0, k1, k2, k3, k4, k5, k6, k7, k8, k9, k10 = symbols('k0:11')
    sympy.var('alpha x y g h n m zeta Gamma lamda ui')
    expr = [Eq(z,k0+k1*x+k2*y),Eq(z,k0+k1*x+k2*y+k3*x**2+k4*x*y+k5*y**2),Eq(z,k0+k1*x+k2*y+k3*x**2+k4*x*y+k5*y**2+k6*x**3+k7*x**2*y+k8*y**2*x+k9*y**3)][plr-1]
    sum_eur = sum(eur)
    # Without rotation
    if sum_eur == 0:
        exprc = expr.subs([(z,parm[0]),(x,parm[1]),(y,parm[2])])
        polys = poly(exprc, sympify(solvd)).all_coeffs()
        abc = []
        uvw = []
        ABCDE = [0, 0, 0, 0, 0]
        ABCDE[:len(polys)] = polys
        return ABCDE, 0, 0
    # With rotation
    else:
        dxyz = {'x': 1, 'y': 2, 'z': 3}
        # Defining
        x,  y,  z  = sympy.symbols('x y z')
        ui, vi, wi = sympy.symbols('ui vi wi')
        u0, v0, w0 = sympy.symbols('u0 v0 w0')
        u1, v1, w1 = sympy.symbols('u1 v1 w1')
        u2, v2, w2 = sympy.symbols('u2 v2 w2')
        a1, a2, a3 = sympy.symbols('a1 a2 a3')
        b1, b2, b3 = sympy.symbols('b1 b2 b3')
        c1, c2, c3 = sympy.symbols('c1 c2 c3')
        m1, m2, m3 = sympy.symbols('m1 m2 m3')
        n1, n2, n3 = sympy.symbols('n1 n2 n3')
        mu, mv, mw = sympy.symbols('mu mv mw')
        # Replace
        PS = rall(sel=eur)
        r0 = Matrix([u0, v0, w0])
        r1 = PS[0].subs([(n, n1), (m, m1)]) * r0
        r2 = PS[1].subs([(n, n2), (m, m2)]) * r1
        RR = PS[2].subs([(n, n3), (m, m3)]) * r2
        sympy.expand(RR.row(0)[0])
        sympy.expand(RR.row(1)[0])
        sympy.expand(RR.row(2)[0])
        av = sympy.collect(sympy.expand(RR.row(0)[0]), (u0, v0, w0))
        bv = sympy.collect(sympy.expand(RR.row(1)[0]), (u0, v0, w0))
        cv = sympy.collect(sympy.expand(RR.row(2)[0]), (u0, v0, w0))
        a1s = av.coeff(u0)
        a2s = av.coeff(v0)
        a3s = av.coeff(w0)
        b1s = bv.coeff(u0)
        b2s = bv.coeff(v0)
        b3s = bv.coeff(w0)
        c1s = cv.coeff(u0)
        c2s = cv.coeff(v0)
        c3s = cv.coeff(w0)
        Eu = Eq(x, a1s * u0 + a2s * v0 + a3s * w0)
        Ev = Eq(y, b1s * u0 + b2s * v0 + b3s * w0)
        Ew = Eq(z, c1s * u0 + c2s * v0 + c3s * w0)
        abc = [a1s, a2s, a3s, b1s, b2s, b3s, c1s, c2s, c3s]
        # Manual
        pvar = [w0, v0, u0, w0**2, v0*w0, v0**2, u0*w0, u0*v0, u0**2, w0**3, v0*w0**2, v0**2*w0, v0**2*w0, v0**3, u0*w0**2, u0*v0*w0, u0*v0**2, u0**2*w0, u0**2*v0, u0**3]
        # Connect to rotmat
        Eu = Eq(x, a1 * u0 + a2 * v0 + a3 * w0)
        Ev = Eq(y, b1 * u0 + b2 * v0 + b3 * w0)
        Ew = Eq(z, c1 * u0 + c2 * v0 + c3 * w0)
        # Start with non-rotated
        exprf = solve(expr,z)[0]-z
        exprc = exprf.subs([(x, solve(Eu, x)[0]), (y, solve(Ev, y)[0]), (z, solve(Ew, z)[0])])
        # Reorganize
        exprr = collect(expand(exprc), pvar)
        xr = [] 
        yr = []
        zr = []
        clma = ['u0','v0','w0','d','var','expr','expr2']
        eqsn = len(exprr.args)
        data = [["0"] * 7 for _ in range(eqsn)]
        matarch = pandas.DataFrame(data, columns=clma)
        matarch.loc[0, ['expr','expr2']]=exprr.args[0]
        matarch.loc[0, ['d']]='d_000'
        for i in range(1, eqsn):
            expt = exprr.args[i]
            expr = expt.args[-1]
            varn = expt / expr
            nrfs = len(varn.free_symbols)
            matarch.loc[i, 'var'] = str(varn)
            for j in range(0,nrfs):
                varn = expt.args[j].as_base_exp()[0]
                pown = expt.args[j].as_base_exp()[1]
                matarch.loc[i, str(varn)] = pown
                subd = {a1: a1s, a2: a2s, a3: a3s,b1: b1s, b2: b2s, b3: b3s,c1: c1s, c2: c2s, c3: c3s}
                matarch.loc[i, 'expr'] = expr
                matarch.loc[i, 'expr2'] = expr.subs(subd) 
                cmbx = int(matarch.loc[i, 'u0'])
                cmby = int(matarch.loc[i, 'v0'])
                cmbz = int(matarch.loc[i, 'w0'])
                dr = sum([cmbx, cmby, cmbz])
                matarch.loc[i,'d']='d_'+"".join([str(dr),str(cmbx),str(cmby)])
                dic1 = matarch.set_index('d')['expr'].to_dict()
                dic2 = matarch.set_index('d')['expr2'].to_dict()
                dic = [dic1,dic2][0]
                nrs = dxyz[solvd]-1
        ABCDE = [0, 0, 0, 0, 0]
        A=Matrix([0,0,0])
        B=Matrix([0,0,0])
        C=Matrix([0,0,0])
        D=Matrix([0,0,0])
        E=Matrix([0,0,0])
        if plr in [3]:
            A[0] +=  dic['d_330']
            A[1] +=  dic['d_303']
            A[2] +=  dic['d_300']
            B[0] +=  dic['d_320']*u0+dic['d_321']*w0
            B[1] +=  dic['d_302']*u0+dic['d_312']*v0
            B[2] +=  dic['d_301']*w0+dic['d_310']*v0
            C[0] +=  dic['d_310']*u0**2+dic['d_311']*u0*w0+dic['d_312']*w0**2+dic['d_110']
            C[1] +=  dic['d_301']*u0**2+dic['d_311']*u0*v0+dic['d_321']*v0**2+dic['d_101']
            C[2] +=  dic['d_302']*w0**2+dic['d_311']*w0*v0+dic['d_320']*w0**2+dic['d_201']*v0+dic['d_210']*w0+dic['d_110']
            D[0] += dic['d_300']*u0**3+dic['d_301']*w0*u0**2+dic['d_302']*w0**2*u0+dic['d_303']*w0**3
            D[1] += dic['d_300']*u0**3+dic['d_310']*u0*v0**2+dic['d_320']*v0**2*u0+dic['d_330']*v0**3
            D[2] += dic['d_303']*v0**3+dic['d_312']*w0*v0**2+dic['d_321']*w0**2*v0+dic['d_330']*v0**3
        if plr in [2,3]:
            B[0] += dic['d_220']
            B[1] += dic['d_202']
            B[2] += dic['d_200']
            C[0] += dic['d_210']*u0+dic['d_211']*w0
            C[1] += dic['d_201']*u0+dic['d_211']*v0
            C[2] += dic['d_201']*v0+dic['d_210']*w0
            D[0] += dic['d_200']*u0**2+dic['d_201']*w0*u0+dic['d_202']*w0**2
            D[1] += dic['d_200']*u0**2+dic['d_210']*v0*u0+dic['d_220']*v0**2
            D[2] += dic['d_202']*v0**2+dic['d_211']*v0*w0+dic['d_220']*w0**2
        if plr in [1,2,3]:
            C[0] += dic['d_110']
            C[1] += dic['d_101']
            C[2] += dic['d_110']
            D[0] += dic['d_100']*u0+dic['d_101']*w0+dic['d_000']
            D[1] += dic['d_100']*u0+dic['d_110']*v0+dic['d_000']
            D[2] += dic['d_101']*v0+dic['d_110']*w0+dic['d_000']
        ABCDE[0] = A[nrs].subs([(u0,parm[0]),(v0,parm[1]),(w0,parm[2])])
        ABCDE[1] = B[nrs].subs([(u0,parm[0]),(v0,parm[1]),(w0,parm[2])])
        ABCDE[2] = C[nrs].subs([(u0,parm[0]),(v0,parm[1]),(w0,parm[2])])
        ABCDE[3] = D[nrs].subs([(u0,parm[0]),(v0,parm[1]),(w0,parm[2])])
        ABCDE[4] = E[nrs]
        indpr = [[2,3,4,0,1],[1,2,3,4,0],[0,1,2,3,4]]
        ABCDE = [ABCDE[i] for i in indpr[plr-1]]
        msl = ['u0','v0','w0','expr','expr2']
        matarch[msl]=matarch[msl].astype(str)
        return ABCDE, matarch, abc
#genpolycoeff(plr=1,parm=["alpha", "x", "y"], solvd='y') 
#genpolycoeff(plr=1,parm=["alpha", "x", "y"], solvd='y',eur=[1, 4, 2])[0]

def genpolycoeff2(flr=1, equ="alpha=k0+k1*g+k2*h", solvd='alpha'):
    k0, k1, k2, k3, k4, k5, k6, k7, k8, k9, k10 = symbols('k0:11')
    alpha, g, h, n, m, zeta, Gamma, lamda, ui = symbols('alpha g h n m zeta Gamma lamda ui')
    ls, rs = equ.split('=')
    eqs = Eq(sympify(ls), sympify(rs))
    polys = poly(eqs.rhs - eqs.lhs, sympify(solvd)).all_coeffs()
    ABCDE = [0, 0, 0, 0, 0]
    ABCDE[:len(polys)] = polys
    return ABCDE, 0, 0
# genpolycoeff2(flr=1, equ="alpha=k0+k1*g+k2*h", solvd='alpha')

def pareq(ste='(x + y*zeta)/(zeta + 1)', **kwargs):
    return eval(ste, kwargs)

