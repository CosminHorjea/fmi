# Toate programarile cu numar maxim de spectacole (Greedy + backtracking)

# comparator dupa ora de sfarsit a unui spectacol
def cmp_spectacole(sp):
    return sp[2]

# functie care determina numarul maxim de spectacole care pot fi programate
# folosind metoda Greedy
def numarMaximSpectacole(lsp):
    lsp.sort(key=cmp_spectacole)

    # ora de sfarsit a ultimului spectacol programat
    ult = "00:00"
    cnt = 0
    for sp in lsp:
        if sp[1] >= ult:
            cnt += 1
            ult = sp[2]

    return cnt


# generarea tuturor programarilor cu numar maxim de spectacole
# folosind metoda backtracking
def bkt(k):
    global sol, nms, fout, lsp

    for v in range(len(lsp)):
        sol[k] = v
        if (v not in sol[:k]) and (k == 0 or lsp[sol[k]][1] >= lsp[sol[k-1]][2]):
            if k == nms-1:
                for p in sol:
                    fout.write(lsp[p][1] + "-" + lsp[p][2] + " " + lsp[p][0] + "\n")
                fout.write("\n")
            else:
                bkt(k+1)


fin = open("spectacole.txt")

# lsp = lista spectacolelor
lsp = []
for linie in fin:
    aux = linie.split()
    # ora de inceput si ora de sfarsit pentru spectacolul curent
    tsp = aux[0].split("-")
    lsp.append((" ".join(aux[1:]), tsp[0], tsp[1]))

fin.close()

fout = open("programari.txt", "w")

# nms = numarul maxim de spectacole = lungimea solutiilor care vor fi generate cu backtracking
nms = numarMaximSpectacole(lsp)

sol = [0] * nms
bkt(0)

fout.close()