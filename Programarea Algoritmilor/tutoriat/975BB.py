def scor(a):
    s = 0
    for i in range(0, 14):
        if(a[i] % 2 == 0):
            s += a[i]
    return s


a = list(map(int, input().split()))
ac = a.copy()
n = 14

maxim = 0
for x in range(14):
    if(a[x] != 0):
        m = a[x]
        a[x] = 0
        for i in range(n):
            a[i] += m//n
        m %= n
        while(m):
            x = (x+1) % n
            a[x] += 1
            m -= 1
        if(maxim < scor(a)):
            maxim = scor(a)
    a = ac.copy()
print(maxim)
# 1256B
