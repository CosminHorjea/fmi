# Sa se afiseze toate numerele naturale formate din cifre distincte 
# care au suma cifrelor egala cu un s dat.
def bkt(k):
    global sol, n

    for v in range(1 if k == 0 else 0, 10):
        if v not in sol[:k]:
            sol[k] = v
            if sum(sol[:k+1]) <= n:
                if sum(sol[:k + 1]) == n:
                    print(*sol[:k + 1], sep="")
                    if 0 not in sol[:k+1]:
                        print(*sol[:k + 1], 0, sep="")
                else:
                    # if sum(sol[:k+1]) < n:
                    bkt(k+1)


n = 3
sol = [0]*10
bkt(0)
