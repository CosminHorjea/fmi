e=[[3,0.1],[5,0.12],[6,0.08],[15,0.22],[12,0.08],[16,0.1],[20,0.3]]

def weightedMedian(e,p,r):
    print(e[p:r],p,r)
    if r==p:
        return e[p][0]
    if r-p==1 :
        if e[r][1]==e[p][1]: # daca au aceeasi pondere returnez pe oricare
            return (e[r][0]+e[p][0])/2
        if(e[p][1]>e[r][1]): # daca nu pe ala cu ponderea mai mare
            return e[p][0]
        else:
            return e[r][0]
    q= (r+p)//2 #aleg un pivot (in mijloc)
    print(e[q],q)
    sumaStanga = sum([x[1] for x in e[p:q]]) # suma ponderii elem la stanga de pivot
    sumaDreapta = sum([x[1] for x in e[q+1:r]]) # suma ponderii elem la dreapta de pivot
    print(sumaStanga,sumaDreapta)
    if sumaStanga <=1/2 and sumaDreapta<=1/2: #daca sumele partiale sunt mai mici decat 1/2
        return e[q][0] # am gasit elementul si e pe poz pivotului
    else:
        if sumaStanga>sumaDreapta: # daca suma din stanga e mai mare
            e[q][1]+=sumaDreapta # adun la pivot toate ponderile din dreapta
            return weightedMedian(e,p,q+1) # si fac acelasi lucru pt partea din stanga, deoarece acolo se afla mediana
        else: # analog mai sus
            e[q][1]+=sumaStanga
            return weightedMedian(e,q,r)


print(weightedMedian(e,0,len(e)))