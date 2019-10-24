def isDistinct(n):
    v = [0]*10
    while(n > 0):
        v[n % 10] += 1
        n //= 10
    for i in v:
        if(i > 1):
            return 0
    return 1


ok = 0
n, m = map(int, input().split())
for i in range(n, m+1):
    if(isDistinct(i)):
        print(i)
        ok = 1
        break
if(not ok):
    print(-1)
# print(isDistinct(98766))
