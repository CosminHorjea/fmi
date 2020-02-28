n = int(input())
a = list(map(int, input().split()))
a.sort()
# print(a)
nr = 1
for i in range(1, len(a)):
    ok = 0
    for j in range(i):
        if(a[i] % a[j] == 0):
            ok = 1
    if(not ok):
        nr += 1
print(nr)
