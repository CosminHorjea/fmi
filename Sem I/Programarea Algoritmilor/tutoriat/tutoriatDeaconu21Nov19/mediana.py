#mediana a 2 vectori sortati cu dimensiuni diferite
sir=input()
v=[ int(x) for x in sir.split()]
sir=input()
w=[ int(x) for x in sir.split()]
def mediana2(v,w):
    if len(v)<=2:
       a=0
       b=0
       x=[]
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

           return(x[k - 1] + x[k]) // 2
       else:
           return x[k]


    i=len(v)//2
    j=len(w)//2
    if len(v)%2==0:

            m1=(v[i-1]+v[i])//2
    else:
            m1=v[i]

    if len(w)%2==0:
            m2 = (w[j - 1] + w[j]) // 2
    else:
        m2=w[j]



    if m1<m2:
        v=v[i:]
        w=w[:(len(w)-i)]
    else:

        w=w[i:]
        if len(v)%2!=0:
            v=v[:i+1]
        else:
           v=v[:i]
    print(v,w)
    return mediana2(v,w)

print(mediana2(v,w))