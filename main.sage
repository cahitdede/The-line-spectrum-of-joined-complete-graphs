#SAGEMATH code

def LineSpecOfJoinOfCompleteGraphs(N,s,u):
    n = 0
    for i in range(N):
        n+=s[i]*u[i]
        
    m=0
    for i in range(N):
        for j in range(i,N):
            if j==i:
                continue
            m+=s[i]*u[i]*s[j]*u[j]
        m+=s[i]*(u[i]-1)*u[i]/2
    
    k = [n-s[i]*u[i]+u[i]-1 for i in range(N)]
    
    f=1
    for i in range(N):
        f*=(x-k[i]-u[i]+3+u[i]*s[i])
    for j in range(N):
        fj=1
        for i in range(N):
            if i==j:
                continue
            fj*=(x-k[i]-u[i]+3+u[i]*s[i])
        f-= (u[j]*s[j]*fj)
    
    alpha = f.roots()
    
    S= [[-2,(m-n)]]
    
    for a in alpha:
        S +=[[a[0],a[1]]]
    
    
    for i in range(N):
        if u[1]>1:
            S+=[[k[i]-3,s[i]*(u[i]-1)]]
        if s[i]>1:
            S+=[[k[i]-3+u[i],(s[i]-1)]]
    return S


#Example
N = 3
s = [3,2,1]
u = [2,3,4]

K=[graphs.CompleteGraph(i) for i in range(1,10)]

G = (s[0]*K[u[0]-1]).join((s[1]*K[u[1]-1]).join(s[2]*K[u[2]-1]))
G = G.line_graph()
L = G.adjacency_matrix()
L_spec = L.eigenvalues()
print(L_spec)

S = LineSpecOfJoinOfCompleteGraphs(N,s,u)

for i in range(len(S)):
    for j in range(i+1,len(S)):
        if S[i][0] == S[j][0]:
            S[i][1] += S[j][1]
            S.remove(S[j])
            
print(S)

fail = 0

for s in S:
    if (L_spec.count(s[0]) != s[1]):
        print(s[0], "fail")
        fail = 1
if fail:
    print("FAIL")
else:
    print("SUCCESS")
