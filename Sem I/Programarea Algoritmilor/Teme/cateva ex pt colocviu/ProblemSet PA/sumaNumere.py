l=[1,2,3,4,5,6]
def suma(s,d):
    if(s==d):return l[s]
    else:
        m=(s+d)//2
        left=suma(s,m)
        right=suma(m+1,d)
        return left+right
print(suma(0,len(l)-1))