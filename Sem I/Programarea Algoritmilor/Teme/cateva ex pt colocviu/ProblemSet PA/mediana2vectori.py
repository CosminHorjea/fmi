#mediana a 2 vectori sortati cu dimensiuni diferite
sir=input()
v=[ int(x) for x in sir.split()]
sir=input()
w=[ int(x) for x in sir.split()]
def mediana2(v,w):
    if len(v)<=2:
       a=0#indicele din v
       b=0# indicele din w
       x=[]# x e vatorul cu care lucrez
       #combin vectorii in x
       while a<len(v) and b<len(w):
           if v[a]<w[b]:
               x.append(v[a])
               a+=1
           else:
               x.append(w[b])
               b+=1
       while a<len(v):
            x.append(v[a])
            a+=1
       while b<len(w):
            x.append(w[b])
            b+=1
       k=len(x)//2
       print(x)
       if len(x) % 2 == 0:
           return(x[k - 1] + x[k]) / 2
       else:
           return x[k]
        #returnez mediana lui x
    i=len(v)//2 #jumaatea lui v
    j=len(w)//2 #jumatatea lui w
    # calculez medianele celor 2 vectori
    if len(v)%2==0:
        m1=(v[i-1]+v[i])//2
    else:
        m1=v[i]
    #in m1 am mediana din v

    if len(w)%2==0:
        m2 = (w[j - 1] + w[j]) // 2
    else:
        m2=w[j]
    # in m2 meidana din w

    if m1<m2: # daca medaian din primu e mai mica dacat cea din al doilea
        v=v[i:] # iau partea superioara a lui v
        w=w[:(len(w)-j)] #iau partea inf a lui w dupa pozitia medianei lui v
    else: #daca mediana lui w e mai mare
        w=w[j:] # iau partea superioara din w
        if len(v)%2!=0:
            v=v[:i+1]
        else:
           v=v[:i]# si partea inf din v
    print(v,w)
    return mediana2(v,w)

print(mediana2(v,w))