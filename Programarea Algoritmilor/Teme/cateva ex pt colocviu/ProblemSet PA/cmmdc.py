l=[2,2,1,4,10]
def euclid(a,b):
    while(a!=0 and b!=0):
        if a>b:
            a%=b
        else:
            b%=a
    return a+b
def cmmdc(s,d):
    if(s==d):return l[s]
    else:
        m=(s+d)//2
        a=cmmdc(s,m)
        b=cmmdc(m+1,d)
        return euclid(a,b)
print(cmmdc(0,len(l)-1))