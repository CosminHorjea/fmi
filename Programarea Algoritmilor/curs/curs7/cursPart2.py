f = open('part2.txt')
n = int(f.readline())
a = [None]*(n+1)
L=[[]]
for i in range(n):
    a[i+1] = [0]*(n+1)
    L.append([])
for line in f:
    l = line.split()
    i = int(l[0])
    j = int(l[1])
    a[i][j] = a[j][i] = 1
    L[i].append(j)
    L[j].append(i)
# for i in range(n):
#     print(a[i+1][1:])
for i in range(n):
    print(L[i])