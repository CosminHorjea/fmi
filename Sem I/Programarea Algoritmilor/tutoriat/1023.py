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
        if(t.find(st) != 0):
            print("NO")
        else:
            t.replace(st, "")
            poz = t.find(dr)
            if(t[poz:] != dr):
                print("NO")
            else:
                print("YES")
