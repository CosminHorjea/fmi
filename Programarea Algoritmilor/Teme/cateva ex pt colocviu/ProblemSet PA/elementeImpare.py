l=[2,2,2,4,2]
def verific(s,d):
    if(s==d):
        if(l[s]%2):return True
        else: return False
    else:
        m = (s+d)//2
        return (verific(s,m) or verific(m+1,d))

print(verific(0,len(l)-1))