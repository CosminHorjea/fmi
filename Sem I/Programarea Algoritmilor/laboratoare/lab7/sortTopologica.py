f = open('topologica.in')

n = int(f.readline())

v = {i: [] for i in range(n)}

final = []

for line in f.readlines():
    i, j = map(int, line.split())
    v[i].append(j)
S = [x for x in v if len(v[x]) == 0]
while(len(S)):
    final.append(S[0])
    for i in v:
        if S[0] in v[i]:
            v[i].remove(S[0])
            if(len(v[i]) == 0):
                S.append(i)
    S = S[1:]

# print(grade)
print(*reversed(final))
