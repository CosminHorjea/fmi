f = open('date2.in', 'r')

n, m = map(int, f.readline().split())
d = []
T = [0 for x in range(n)]
puncte = [[0 for x in range(m)] for y in range(n)]
for i in range(n):
    T[i] = list(map(int, f.readline().split()))
drum = [[0 for x in range(m)] for y in range(n)]
puncte = T.copy()  # de ce nu imi face o copie si il modifica pe T?????
for i in range(n):
    for j in range(m):
        if(i == 0 and j == 0):
            continue
        if(i == 0):
            puncte[i][j] += puncte[i][j-1]
            drum[i][j] = 'stanga'
        elif(j == 0):
            puncte[i][j] += puncte[i-1][j]
            drum[i][j] = 'sus   '
        else:
            puncte[i][j] += max(puncte[i-1][j], puncte[i][j-1])
            if(puncte[i-1][j] > puncte[i][j-1]):
                drum[i][j] = 'sus   '
            else:
                drum[i][j] = 'stanga'

# print(*puncte, sep="\n")
print(puncte[n-1][m-1])
# print(*drum, sep="\n")

while n > 0 and m > 0:
    d.append((n, m))
    if(drum[n-1][m-1] == 'sus   '):
        n -= 1
    else:
        m -= 1
print(*sorted(d, reverse=True))
