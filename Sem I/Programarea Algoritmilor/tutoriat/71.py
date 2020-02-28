def lungime(s):
    if len(s)<=10:
        return s
    else :
        s2=""
        s2+=s[0]
        s2+=str(len(s)-2)
        s2+=s[-1]
        return s2
n=int(input())
stringuri=[]
for i in range(n):
    stringuri.append(input())
for s in stringuri:
    print(lungime(s))