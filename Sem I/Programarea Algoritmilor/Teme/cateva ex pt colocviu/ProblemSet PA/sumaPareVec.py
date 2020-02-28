l=[1,2,3,4]

def sumaPareVec(s,d):
    if(s==d):
        if(l[s]%2==0):
            return l[s]
        return 0
    else:
        m=(s+d)//2
        return (sumaPareVec(s,m)+sumaPareVec(m+1,d))
print(sumaPareVec(0,len(l)-1))