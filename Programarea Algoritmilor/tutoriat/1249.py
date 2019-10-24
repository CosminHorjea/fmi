q = int(input())
for i in range(q):
    ok = 0
    n = int(input())
    a = list(map(int, input().split()))
    a.sort()
    for x in range(len(a)-1):
        if not ok:
            if abs(a[x]-a[x+1]) == 1:
                print(2)
                ok = 1
    if ok:
        continue
    print(1)
