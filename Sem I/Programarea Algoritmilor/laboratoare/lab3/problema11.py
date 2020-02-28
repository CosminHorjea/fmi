# N = int(input())
N = 5
# habar n-am de ce nu merge cu 0*n and all that
M = [[0 for x in range(N)] for y in range(N)]
nr = 1
for i in range(N):
    for j in range(N):
        M[i][j] = nr
        # print(M[i][j])
        nr += 1
print(M)
