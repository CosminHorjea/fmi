f = open('proiecte.txt', 'r')
g = open('profit.txt', 'w')
proiecte = []
maxim = 0
for r in f.readlines():
    r = r.split()
    r[1] = int(r[1])
    if r[1] > maxim:
        maxim = r[1]
    r[2] = int(r[2])
    proiecte.append(tuple(r))
sol = [0]*(maxim+1)
proiecte.sort(key=lambda x: x[2], reverse=True)
# print(proiecte)
for p in proiecte:
    if(sol[p[1]]):
        k = p[1]
        while(sol[k] and k > 0):
            k -= 1
        if k != 0:
            sol[k] = (p[0], p[2])
    else:
        sol[p[1]] = (p[0], p[2])
# print(sol)
g.write('T='+str(maxim)+'\n')
g.write('proiecte: ')
for i in range(1, maxim+1):
    g.write(sol[i][0]+" ")
g.write('\n')
suma = 0
for i in range(1, maxim+1):
    # mai trebuie traba cu plusurile si egal, useless stuff imo
    suma += sol[i][1]
g.write(str(suma))
