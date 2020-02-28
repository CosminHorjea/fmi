e=[[3,0.1],[5,0.12],[6,0.08],[12,0.2],[15,0.1],[16,0.1],[20,0.3]]

def weightedMedian(e,p,r):
    print(e[p:r])
    if r==p:
        return e[p]
    if r-p==1 :
        if e[r][1]==e[p][1]:
            return (e[r][1]+e[p][1])/2
        if(e[p][1]>e[r][1]):
            return p
    q= (r-p)//2
    sumaStanga = sum([x[1] for x in e[:q]])
    sumaDreapta = sum([x[1] for x in e[q+1:]])
    # print(sumaStanga,sumaDreapta)
    if sumaStanga <1/2 and sumaDreapta<1/2:
        return e[q]
    else:
        if sumaStanga>sumaDreapta:
            e[q][1]+=sumaDreapta
            weightedMedian(e,p,q+1)
        else:
            e[q][1]+=sumaStanga
            weightedMedian(e,q,r+1)


weightedMedian(e,0,len(e))