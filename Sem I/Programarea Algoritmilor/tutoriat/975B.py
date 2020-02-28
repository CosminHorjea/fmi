def scor(a):
    s = 0
    for i in range(0, 14):
        if(a[i] % 2 == 0):
            s += a[i]
    return s


a = list(map(int, input().split()))
ac = a.copy()


maxim = 0
for x in range(14):
    if(a[x] != 0):
        m = a[x]
        a[x] = 0
        i = x
        while(m):
            a[(i+1) % 14] += 1
            m -= 1
            i += 1
        s1 = scor(a)
        if(maxim < s1):
            maxim = s1
    a = ac.copy()
print(maxim)
# 1256B
