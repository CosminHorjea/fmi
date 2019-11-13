# e 1023 A defapt
n, m = map(int, input().split())
s = input()
t = input()
if(m < n-1):
    print("NO")
elif s == "*":
    print("YES")
else:
    if(s.find("*") == -1):
        if(s != t):
            print("NO")
        else:
            print("YES")
    else:
        st, dr = s.split("*")
        tc = t
        t = t.replace(st, "", 1)
        t = t[len(t)::-1]
        dr = dr[len(dr)::-1]
        t = t.replace(dr, "", 1)
        t = t[len(t)::-1]
        if(s.replace("*", t) == tc):
            print("YES")
        else:
            print("NO")
