def bkt(k):
    global vecini, sol

    for c in range(1, 5):
        sol[k] = c
        ok = True
        for i in range(1, k):
            if k in vecini[i] and sol[k] == sol[i]:
                ok = False
                break
        if ok:
            if k == len(vecini):
                print(sol[1:])
            else:
                bkt(k+1)


f = open("harta.txt")
n = int(f.readline())

vecini = {k:[] for k in range(1, n+1)}

for linie in f:
    aux = linie.split()
    x = int(aux[0])
    y = int(aux[1])
    vecini[x] += [y]
    vecini[y] += [x]

sol = [0]*(n+1)
bkt(1)
