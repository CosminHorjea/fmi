with open("graf_in.txt", 'r') as f:
    muchii = []
    tipGraf = f.readline()
    n = int(f.readline())
    m = int(f.readline())
    for i in range(m):
        x, y = map(int, f.readline().split())
        muchii.append((x, y))
    s, f = map(int, f.readline().split())
# a)
# print(muchii)
# ======================
# b)
listaAdiacenta = {}
for pereche in muchii:
    if(pereche[0] in listaAdiacenta.keys()):
        listaAdiacenta[pereche[0]].append(pereche[1])
    else:
        listaAdiacenta[pereche[0]] = [pereche[1]]
    if(tipGraf == "neorientat\n"):
        if(pereche[1] in listaAdiacenta.keys()):
            listaAdiacenta[pereche[1]].append(pereche[0])
        else:
            listaAdiacenta[pereche[1]] = [pereche[0]]
print(listaAdiacenta)
# ======================
# c)
# trebuie sa tinem cont ca trebuie index de la 1, nu stiu sa o generez asa, deci col si rand 0 au val 0
# M = [[0 for x in range(n+1)] for y in range(n+1)]
# for pereche in muchii:
#     M[pereche[0]][pereche[1]] = 1
#     if(tipGraf == "neorientat\n"):
#         M[pereche[1]][pereche[0]] = 1
# print(M)
# ======================
# d) # nu stiu ce zicea cu tupluri, cu (s,-1), am facut basic. E nevoie de punctul B
# BF = []
# st = dr = 0
# BF.append(s)
# while(st <= dr):
#     if(BF[st] in listaAdiacenta.keys()):
#         for vecin in listaAdiacenta[BF[st]]:
#             if vecin not in BF:
#                 BF.append(vecin)
#                 dr += 1
#     print(BF[st])
#     st += 1
# ======================
# e)
# DF = []
# vizitat = []
# DF.append(s)
# vizitat.append(s)
# while(DF != []):
#     v = DF.pop()
#     if(v in listaAdiacenta.keys()):
#         for vecin in listaAdiacenta[v]:
#             if vecin not in vizitat:
#                 DF.append(vecin)
#             vizitat.append(vecin)
#     print(v)
# ======================
